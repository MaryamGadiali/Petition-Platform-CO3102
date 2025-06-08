package com.example.cw2.controllers;

import com.example.cw2.models.BioID;
import com.example.cw2.models.User;
import com.example.cw2.repositories.userRepository;
import com.example.cw2.services.BioIDService;
import com.example.cw2.services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

@Controller
public class AuthenticationController {

    @Autowired
    private userRepository userRepo;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Autowired
    private UserService userService;

    @Autowired
    private BioIDService bioIDService;

    // Display the registration form
    @GetMapping("/register")
    public String showRegistrationForm(Model model) {
        System.out.println("Reached the register page");
        model.addAttribute("user", new User()); // Bind an empty User object to the form
        return "register"; // Render "register.jsp"
    }

    //An ajax post method to see if the passed in bio id is valid or not
    @PostMapping("/checkBioID")
    @ResponseBody
    public String checkBioID(@RequestParam("bioIDCode") String bioIDCode) {
        System.out.println("Checking bioID: " + bioIDCode);
        BioID bioID = bioIDService.findBioID(bioIDCode);
        if (bioID == null) {
            System.out.println("No match");
            return "No match";
        }
        else if (bioID.getUser()!=null) {
            System.out.println("BioID already used");
            return "BioID already used";
        }
        else{
            System.out.println("Valid");
            return "Valid";
        }
    }

    //AJAX check to see if email is already in use
    @PostMapping("/checkEmail")
    @ResponseBody
    public String checkEmail(@RequestParam("email") String email) {
        System.out.println("Checking email: " + email);
        User user = userRepo.findByUserEmail(email);
        if (user == null) {
            System.out.println("No match");
            return "No match";
        }
        else{
            System.out.println("Email already in use");
            return "Email already in use";
        }
    }


    //Register post request
    @PostMapping("/register")
    public String register(@ModelAttribute("user") User user, BindingResult result, Model model) {
        System.out.println("Registering user: " + user.getUserEmail());
        if (result.hasErrors()) {
            System.out.println("Errors found");
            return "register"; // Return form with errors displayed
        }
        // Check if email is already taken - a double check after the dynamic ajax check
        if (userRepo.findByUserEmail(user.getUserEmail()) != null) {
            System.out.println("Email already in use");
            model.addAttribute("emailError", "This email is already in use.");
            return "register";
        }
        user.setPasswordHash(passwordEncoder.encode(user.getPasswordHash()));

        // Set the default role
        user.setRole("ROLE_CITIZEN");
        userService.saveUser(user);

        return "redirect:/login"; //So spring security can correctly handle the authentication and cookie
    }


    @GetMapping("/login")
    public String loginPage(Authentication authentication) {
        if (authentication != null && authentication.isAuthenticated() && userService.getCurrentUser()!=null) {
            System.out.println("User is already authenticated");
            return "redirect:/dashboard";
        }
        return "login";
    }

    @GetMapping("/accessDenied")
    public String error() {
        return "accessDenied";
    }


    @ModelAttribute("userName")
    public String getCurrentUserName() {
        User currentUser = userService.getCurrentUser();
        return currentUser != null ? currentUser.getFullname() : "Guest"; //Shouldn't be guest, but just a placeholder
    }

}
