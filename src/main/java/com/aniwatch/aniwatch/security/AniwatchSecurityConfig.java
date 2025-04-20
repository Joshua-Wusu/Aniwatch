package com.aniwatch.aniwatch.security;

import org.springframework.boot.web.servlet.ServletListenerRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationFailureHandler;
import org.springframework.security.web.session.HttpSessionEventPublisher;

@Configuration
@EnableWebSecurity
public class AniwatchSecurityConfig {

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
        http
                // Keeping CSRF disabled for debugging - will use <#if _csrf??> temporarily
                .csrf(csrf -> csrf.disable())

                // Will Re-enable CSRF once everything works (big cope)
                // .csrf(csrf -> csrf.ignoringRequestMatchers("/register/**"))

                .authorizeHttpRequests(authorize -> authorize
                        // Static resources
                        .requestMatchers("/css/**", "/js/**", "/pics/**", "/uploads/**", "/images/**", "/favicon.ico").permitAll()

                        // Public pages
                        .requestMatchers("/", "/home","/browse-anime").permitAll()
                        .requestMatchers("/register/**", "/login", "/logout").permitAll()
                        .requestMatchers("/check-username", "/register/validate-username").permitAll()
                        .requestMatchers("/debug/**").permitAll() // Debug endpoints
                        .requestMatchers("/watchlists/watchlist-list").permitAll()
                        .requestMatchers("/watchlists/{id}/**").permitAll()
                        .requestMatchers("/provider-profile/{id}").permitAll()
                        .requestMatchers("/user-profile/{id}").permitAll()
                        .requestMatchers("/user/check-type").permitAll()
                        .requestMatchers("/comments/list/**").permitAll()
                        .requestMatchers("/comments/replies/**").permitAll()
                        .requestMatchers("/provider-profile/provider-watchlist/all").permitAll()
                        .requestMatchers("/provider-profile/subscribed-watchlists").permitAll()
                        .requestMatchers("/user-profile/subscribed-watchlists").permitAll()

                        // Actions that require authentication
                        .requestMatchers("/provider-profile/update").authenticated()
                        .requestMatchers("/user-profile/update").authenticated()

                        // Protected pages
                        .requestMatchers("/watchlists/new", "/watchlists/create", "/watchlists/edit/**", "/watchlists/update/**", "/watchlists/delete/**").hasAuthority("ROLE_PROVIDER")
                        .anyRequest().authenticated()
                )
                .formLogin(form -> form
                        .loginPage("/login")
                        .loginProcessingUrl("/login")
                        .failureHandler(authenticationFailureHandler())
                        .successHandler(authenticationSuccessHandler())
                        .permitAll()
                )

                // I only tested it once, and it seemed to work, idk if its really reliable
                .sessionManagement(session -> session
                        .invalidSessionUrl("/login") // Redirect to login page on invalid session
                        .maximumSessions(1) // Limit to one session per user
                        .maxSessionsPreventsLogin(false) // False allows new login, thus invalidating the old session
                        .expiredUrl("/login") // Redirect to login page on session expiration
                        .and() // ignore this for now, code should still run...I think
                        .sessionFixation().migrateSession()
                        .sessionCreationPolicy(SessionCreationPolicy.IF_REQUIRED)
                        .invalidSessionUrl("/login?expired")
                )

                .logout(logout -> logout
                        .logoutSuccessUrl("/home")
                        .permitAll()
                );

        return http.build();
    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    public AuthenticationFailureHandler authenticationFailureHandler() {
        SimpleUrlAuthenticationFailureHandler handler = new SimpleUrlAuthenticationFailureHandler("/?showLoginModal=true&loginError=true");
        handler.setUseForward(false);
        return handler;
    }

    @Bean
    public AuthenticationSuccessHandler authenticationSuccessHandler() {
        return (request, response, authentication) -> {
            System.out.println("User successfully authenticated: " + authentication.getName());
            System.out.println("Authorities: " + authentication.getAuthorities());
            response.sendRedirect("/home");
        };
    }

    @Bean
    public ServletListenerRegistrationBean<HttpSessionEventPublisher> httpSessionEventPublisher() {
        return new ServletListenerRegistrationBean<>(new HttpSessionEventPublisher());
    }
}