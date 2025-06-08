package com.example.cw2.services;

import com.example.cw2.models.User;
import com.example.cw2.repositories.userRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.GrantedAuthority;

import java.util.Collection;
import java.util.Collections;


@Service
public class UserService implements UserDetailsService {

    @Autowired
    private userRepository userRepo;

    public void saveUser(User user){
        user.setRole("ROLE_CITIZEN");
        userRepo.save(user);
    }

    public User findByUserEmail(String email){
        return userRepo.findByUserEmail(email);
    }

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        User user = userRepo.findByUserEmail(username);
        if (user == null) {
            throw new UsernameNotFoundException("User not found");
        }
        return new org.springframework.security.core.userdetails.User(user.getUserEmail(), user.getPasswordHash(), getAuthorities(user));
    }

    private Collection<? extends GrantedAuthority> getAuthorities(User user) {
        return Collections.singletonList(new SimpleGrantedAuthority(user.getRole()));
    }

    public User getCurrentUser() {
        String currentUserEmail = SecurityContextHolder.getContext().getAuthentication().getName();
        System.out.println("Current user email: " + currentUserEmail);
        User u = userRepo.findByUserEmail(currentUserEmail);
        return u;
    }

    public void save(User u) {
        userRepo.save(u);
    }
}
