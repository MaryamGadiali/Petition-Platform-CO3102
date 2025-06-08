package com.example.cw2;

//import com.example.cw2.filter.JwtAuthFilter;
import com.example.cw2.services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Lazy;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
@EnableWebSecurity
@EnableMethodSecurity
public class BasicConfiguration {

    private final UserService userService;

    public BasicConfiguration(UserService userService) {
        this.userService = userService;
    }

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception{
        return http
                .csrf().disable()
                .authorizeHttpRequests()

                .antMatchers("/register","/checkBioID","/checkEmail").permitAll()
                .antMatchers("/slpp/*").permitAll()
                .antMatchers("/login").permitAll()
                .antMatchers("/admin/**").hasRole("ADMIN")
                .antMatchers("/**").hasAnyRole("ADMIN","CITIZEN")
                .anyRequest().authenticated()
                .and().formLogin(form->form
                        .loginPage("/login")
                        .loginProcessingUrl("/login")
                        .defaultSuccessUrl("/dashboard",true)
                        .failureUrl("/login?error=true")
                        )

                .exceptionHandling()
                .accessDeniedPage("/accessDenied")
                .and()
                .rememberMe()
                .key("uniqueAndSecret")
                .tokenValiditySeconds(86400)
                .userDetailsService(userService)
                .and()
                .logout()
                .permitAll()
                .and().build();}

}


