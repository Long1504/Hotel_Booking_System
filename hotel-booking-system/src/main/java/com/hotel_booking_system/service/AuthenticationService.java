package com.hotel_booking_system.service;

import com.hotel_booking_system.dto.request.AuthenticationRequest;
import com.hotel_booking_system.dto.request.IntrospectRequest;
import com.hotel_booking_system.dto.request.LogoutRequest;
import com.hotel_booking_system.dto.request.RefreshRequest;
import com.hotel_booking_system.dto.response.AuthenticationResponse;
import com.hotel_booking_system.dto.response.IntrospectResponse;
import com.hotel_booking_system.entity.InvalidatedToken;
import com.hotel_booking_system.entity.User;
import com.hotel_booking_system.enums.UserStatus;
import com.hotel_booking_system.exception.AppException;
import com.hotel_booking_system.exception.ErrorCode;
import com.hotel_booking_system.repository.InvalidatedTokenRepository;
import com.hotel_booking_system.repository.UserRepository;
import com.nimbusds.jose.*;
import com.nimbusds.jose.crypto.MACSigner;
import com.nimbusds.jose.crypto.MACVerifier;
import com.nimbusds.jwt.JWTClaimsSet;
import com.nimbusds.jwt.SignedJWT;
import lombok.RequiredArgsConstructor;
import lombok.experimental.NonFinal;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import java.text.ParseException;
import java.time.Instant;
import java.time.temporal.ChronoUnit;
import java.util.Date;
import java.util.StringJoiner;
import java.util.UUID;

@Service
@RequiredArgsConstructor
@Slf4j
public class AuthenticationService {
    private final UserRepository userRepository;
    private final InvalidatedTokenRepository invalidatedTokenRepository;
    private PasswordEncoder passwordEncoder = new BCryptPasswordEncoder(10);

    @NonFinal
    @Value("${jwt.signerKey}")
    private String SIGNER_KEY;

    @NonFinal
    @Value("${jwt.valid-duration}")
    private long VALID_DURATION;

    @NonFinal
    @Value("${jwt.refreshable-duration}")
    private long REFRESHABLE_DURATION;

    // Giải mã và kiểm tra token có hợp lệ không
    public IntrospectResponse introspect(IntrospectRequest request) throws ParseException, JOSEException {
        String token = request.getToken();

        boolean isValid = true;

        try {
            verifyToken(token, false);
        } catch (AppException e) {
            isValid = false;
        }

        return IntrospectResponse.builder()
                .valid(isValid)
                .build();
    }

    // Xác thực user dựa vào username và password -> Trả về token (nếu xác thực thành công)
    public AuthenticationResponse authenticate(AuthenticationRequest request) {
        User user = userRepository.findByUsername(request.getUsername())
                .orElseThrow(() -> new AppException(ErrorCode.USER_NOT_FOUND));

        // Check có bị xóa không
        if (user.getDeletedAt() != null) {
            throw new AppException(ErrorCode.USER_DELETED);
        }

        // Check có bị khóa không
        if (user.getUserStatus().equals(UserStatus.LOCKED.name())) {
            throw new AppException(ErrorCode.ACCOUNT_LOCKED);
        }

        boolean authenticated = passwordEncoder.matches(request.getPassword(), user.getPassword());

        if (!authenticated)
            throw new AppException(ErrorCode.INVALID_CREDENTIALS);

        String token = generateToken(user);

        return AuthenticationResponse.builder()
                .token(token)
                .authenticated(authenticated)
                .build();
    }

    public void logout(LogoutRequest request) throws ParseException, JOSEException {
        try {
            SignedJWT signedToken = verifyToken(request.getToken(), true);

            String jit = signedToken.getJWTClaimsSet().getJWTID();
            Date expiryTime = signedToken.getJWTClaimsSet().getExpirationTime();

            InvalidatedToken invalidatedToken = InvalidatedToken.builder()
                    .id(jit)
                    .expiryTime(expiryTime)
                    .build();

            invalidatedTokenRepository.save(invalidatedToken);
        } catch(AppException e) {
            log.info("Token đã hết hạn");
        }
    }

    public AuthenticationResponse refreshToken(RefreshRequest request) throws ParseException, JOSEException {
        SignedJWT signedJWT = verifyToken(request.getToken(), true);

        String jit = signedJWT.getJWTClaimsSet().getJWTID();
        Date expiryTime = signedJWT.getJWTClaimsSet().getExpirationTime();

        InvalidatedToken invalidatedToken = InvalidatedToken.builder()
                .id(jit)
                .expiryTime(expiryTime)
                .build();

        invalidatedTokenRepository.save(invalidatedToken);

        String username = signedJWT.getJWTClaimsSet().getSubject();

        User user = userRepository.findByUsername(username).orElseThrow(() -> new AppException(ErrorCode.UNAUTHENTICATED));

        String token = generateToken(user);

        return AuthenticationResponse.builder()
                .token(token)
                .authenticated(true)
                .build();
    }

    private SignedJWT verifyToken(String token, boolean isRefresh) throws JOSEException, ParseException {
        JWSVerifier verifier = new MACVerifier(SIGNER_KEY.getBytes());

        SignedJWT signedJWT = SignedJWT.parse(token);

        Date expiryTime = isRefresh
                ? new Date(signedJWT.getJWTClaimsSet().getIssueTime().toInstant().plus(REFRESHABLE_DURATION, ChronoUnit.SECONDS).toEpochMilli())
                : signedJWT.getJWTClaimsSet().getExpirationTime();

        boolean verified = signedJWT.verify(verifier);

        if(!(verified && expiryTime.after(new Date())))
            throw new AppException(ErrorCode.UNAUTHENTICATED);

        if(invalidatedTokenRepository.existsById(signedJWT.getJWTClaimsSet().getJWTID()))
            throw new AppException(ErrorCode.UNAUTHENTICATED);

        return signedJWT;
    }

    // Tạo token
    private String generateToken(User user) {
        JWSHeader header = new JWSHeader(JWSAlgorithm.HS512);

        JWTClaimsSet jwtClaimsSet = new JWTClaimsSet.Builder()
                .subject(user.getUsername())
                .issuer("hotelbooking.com")
                .issueTime(new Date())
                .expirationTime(new Date(Instant.now().plus(VALID_DURATION, ChronoUnit.SECONDS).toEpochMilli()))
                .jwtID(UUID.randomUUID().toString()) // tokenID
                .claim("scope", buildScope(user)) // Lưu role hoặc permission
                .build();

        Payload payload = new Payload(jwtClaimsSet.toJSONObject());

        JWSObject jwsObject = new JWSObject(header, payload);

        try {
            jwsObject.sign(new MACSigner(SIGNER_KEY.getBytes()));
            return jwsObject.serialize();
        } catch (JOSEException e) {
            log.error("Không thể tạo token", e);
            throw new RuntimeException(e);
        }
    }

    private String buildScope(User user) {
        StringJoiner stringJoiner = new StringJoiner(" ");
        if(!CollectionUtils.isEmpty(user.getRoles())) {
            user.getRoles().forEach(role -> stringJoiner.add(role.getRoleName()));
        }
        return stringJoiner.toString();
    }
}
