package com.hotel_booking_system.config;

import com.hotel_booking_system.enums.RoleName;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.oauth2.server.resource.authentication.JwtAuthenticationConverter;
import org.springframework.security.oauth2.server.resource.authentication.JwtGrantedAuthoritiesConverter;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.CorsConfigurationSource;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;

import java.util.List;

@Configuration
@EnableWebSecurity
@EnableMethodSecurity
@RequiredArgsConstructor
public class SecurityConfig {
    private final CustomJwtDecoder customJwtDecoder;

    private final String[] PUBLIC_ENDPOINTS_POST = {
            "/api/v1/auth/login",
            "/api/v1/users/register"
    };

    private final String[] PUBLIC_ENDPOINTS_GET = {

    };

    private final String[] ADMIN_ENDPOINTS_POST = {

    };

    private final String[] ADMIN_ENDPOINTS_GET = {
            "/api/v1/users"
    };

    private final String[] ADMIN_ENDPOINTS_PUT = {

    };

    private final String[] ADMIN_ENDPOINTS_DELETE = {

    };

    private final String[] CUSTOMER_ENDPOINTS_POST = {

    };

    private final String[] CUSTOMER_ENDPOINTS_GET = {

    };

    private final String[] CUSTOMER_ENDPOINTS_PUT = {

    };

    private final String[] CUSTOMER_ENDPOINTS_DELETE = {

    };

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity httpSecurity) throws Exception {
        httpSecurity
                .cors(cors -> cors.configurationSource(corsConfigurationSource()))
                .csrf(csrf -> csrf.disable())
                .authorizeHttpRequests(request -> request
                        .requestMatchers(HttpMethod.POST, PUBLIC_ENDPOINTS_POST).permitAll()
                        .requestMatchers(HttpMethod.GET, PUBLIC_ENDPOINTS_GET).permitAll()
                        .requestMatchers(HttpMethod.POST, ADMIN_ENDPOINTS_POST).hasRole(RoleName.ADMIN.name())
                        .requestMatchers(HttpMethod.GET, ADMIN_ENDPOINTS_GET).hasRole(RoleName.ADMIN.name())
                        .requestMatchers(HttpMethod.PUT, ADMIN_ENDPOINTS_PUT).hasRole(RoleName.ADMIN.name())
                        .requestMatchers(HttpMethod.DELETE, ADMIN_ENDPOINTS_DELETE).hasRole(RoleName.ADMIN.name())
                        .requestMatchers(HttpMethod.POST, CUSTOMER_ENDPOINTS_POST).hasRole(RoleName.CUSTOMER.name())
                        .requestMatchers(HttpMethod.GET, CUSTOMER_ENDPOINTS_GET).hasRole(RoleName.CUSTOMER.name())
                        .requestMatchers(HttpMethod.PUT, CUSTOMER_ENDPOINTS_PUT).hasRole(RoleName.CUSTOMER.name())
                        .requestMatchers(HttpMethod.DELETE, CUSTOMER_ENDPOINTS_DELETE).hasRole(RoleName.CUSTOMER.name())
                        .anyRequest().authenticated()
                )
                .oauth2ResourceServer(oauth2 -> oauth2
                        .jwt(jwtConfigurer -> jwtConfigurer
                                .decoder(customJwtDecoder)
                                .jwtAuthenticationConverter(jwtAuthenticationConverter()))
                        .authenticationEntryPoint(new JwtAuthenticationEntryPoint())
                );

        return httpSecurity.build();
    }

    // Custom lại scope (mặc định là SCOPE_)
    @Bean
    public JwtAuthenticationConverter jwtAuthenticationConverter() {
        JwtGrantedAuthoritiesConverter jwtGrantedAuthoritiesConverter = new JwtGrantedAuthoritiesConverter();
        jwtGrantedAuthoritiesConverter.setAuthorityPrefix("ROLE_");

        JwtAuthenticationConverter jwtAuthenticationConverter = new JwtAuthenticationConverter();
        jwtAuthenticationConverter.setJwtGrantedAuthoritiesConverter(jwtGrantedAuthoritiesConverter);

        return jwtAuthenticationConverter;
    }

    // Cấu hình CORS cho phép frontend truy cập
    @Bean
    public CorsConfigurationSource corsConfigurationSource() {
        CorsConfiguration configuration = new CorsConfiguration();
        configuration.setAllowedOrigins(List.of("http://127.0.0.1:5500", "http://localhost:5500", "http://127.0.0.1:5501", "http://localhost:5501"));
        configuration.setAllowedMethods(List.of("GET", "POST", "PUT", "DELETE", "OPTIONS"));
        configuration.setAllowedHeaders(List.of("*"));
        configuration.setAllowCredentials(true); //Cho phép gửi cookie/token nếu cần

        UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
        source.registerCorsConfiguration("/**", configuration);
        return source;
    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder(10);
    }
}
