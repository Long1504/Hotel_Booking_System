package com.hotel_booking_system.config;

import com.hotel_booking_system.entity.Role;
import com.hotel_booking_system.entity.User;
import com.hotel_booking_system.enums.RoleName;
import com.hotel_booking_system.enums.UserStatus;
import com.hotel_booking_system.exception.AppException;
import com.hotel_booking_system.exception.ErrorCode;
import com.hotel_booking_system.repository.RoleRepository;
import com.hotel_booking_system.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.ApplicationRunner;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.crypto.password.PasswordEncoder;

import java.util.HashSet;
import java.util.Set;

@RequiredArgsConstructor
@Configuration
@Slf4j
public class ApplicationInitConfig {
    private final RoleRepository roleRepository;
    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;

    // Hàm này run mỗi khi start application
    @Bean
    ApplicationRunner applicationRunner(UserRepository userRepository) {
        return args -> {
            // Tạo Role mặc định nếu chưa có
            if (roleRepository.count() == 0) {
                roleRepository.save(Role.builder().roleName(RoleName.ADMIN.name()).build());
                roleRepository.save(Role.builder().roleName(RoleName.RECEPTIONIST.name()).build());
                roleRepository.save(Role.builder().roleName(RoleName.CUSTOMER.name()).build());
            }

            // Tạo Admin nếu chưa có
            if (userRepository.findByUsername("admin").isEmpty()) {
                Set<Role> roles = new HashSet<>();
                Role role = roleRepository.findByRoleName(RoleName.ADMIN.name())
                        .orElseThrow(() -> new AppException(ErrorCode.ROLE_NOT_FOUND));
                roles.add(role);

                User user = User.builder()
                        .username("admin")
                        .password(passwordEncoder.encode("12345678"))
                        .firstName("")
                        .lastName("")
                        .gender("")
                        .email("admin@gmail.com")
                        .phone("0123456789")
                        .userStatus(UserStatus.ACTIVE.name())
                        .roles(roles)
                        .build();

                userRepository.save(user);
                log.warn("Tài khoản admin đã được tạo với mật khẩu mặc định là: 12345678. Vui lòng thay đổi!");
            }
        };
    }
}
