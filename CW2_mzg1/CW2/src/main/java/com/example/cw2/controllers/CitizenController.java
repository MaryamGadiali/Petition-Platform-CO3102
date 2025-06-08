package com.example.cw2.controllers;

import com.example.cw2.models.Petition;
import com.example.cw2.models.User;
import com.example.cw2.services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import com.example.cw2.services.PetitionService;

import java.util.ArrayList;
import java.util.List;


@Controller
public class CitizenController {

    @Autowired
    private UserService userService;

    @Autowired
    private PetitionService petitionService;


    //Relies on Spring Security's session-based authentication instead of JWT

    @ModelAttribute("userName")
    public String getCurrentUserName() {
        User currentUser = userService.getCurrentUser();
        return currentUser != null ? currentUser.getFullname() : "Guest"; //shouldn't be guest, but just a placeholder
    }


    @GetMapping("/dashboard")
    public String home() {
        //if admin, go to admin dashboard
        if (userService.getCurrentUser().getRole().equals("ROLE_ADMIN")) {
            return "redirect:/admin/petitionsCommitteeDashboard";
        }
        else{ //if citizen, go to citizen dashboard
            return "redirect:/listAllPetitions";
        }
    }

    @RequestMapping(value = {"/listAllPetitions"})
    public String listAllPetitions(Model model){
        User u = userService.getCurrentUser();

        List<Petition> allPetitions = petitionService.findAllPetitions();
        List<Petition> userSignedPetitions = u.getSignedPetitions();
        List<Petition> userUnsignedPetitions = new ArrayList<>(allPetitions);
        List<Petition> userCreatedPetitions = u.getCreatedPetitions();
        userUnsignedPetitions.removeAll(userSignedPetitions);
        userUnsignedPetitions.removeAll(userCreatedPetitions);

        model.addAttribute("userSignedPetitions", userSignedPetitions);
        model.addAttribute("userUnsignedPetitions", userUnsignedPetitions);
        model.addAttribute("userCreatedPetitions", userCreatedPetitions);

        return "listAllPetitions";
    }

    @RequestMapping(value = {"/petition/create"})
    public ModelAndView createPetition(){
        return new ModelAndView("createPetition", "petition", new Petition());
    }

    @PostMapping(value = {"/petition/save"})
    public ModelAndView savePetition(@ModelAttribute("petition") Petition petition, Model model, BindingResult result){
        System.out.println("Reached save petition");
        if (result.hasErrors()) {
            System.out.println("Errors found");
            return new ModelAndView("user/listAllPetitions"); // Return form with errors displayed
        }
        //save petition creator
        User u = userService.getCurrentUser();
        petition.setPetitionCreator(u);
        petition.setPetitionCreatorEmail(u.getUserEmail());
        petition.setStatus("open");
        petition.setSignatureCount(0);
        u.addCreatedPetition(petition);
        petitionService.savePetition(petition);
        return new ModelAndView("redirect:/listAllPetitions");
    }

    @GetMapping("/petition/{petitionID}")
    public String viewPetition(@PathVariable("petitionID") int petitionID , Model model) {
        Petition petition = petitionService.findPetitionByPetitionID(petitionID);
        //Check if user has signed it, or if user is the creator
        boolean isSigned = false;
        boolean isCreator = false;

        User u = userService.getCurrentUser();
        if (petition.getSigners().contains(u)) {
            isSigned = true;
        }

        if (petition.getPetitionCreator().equals(u)) {
            isCreator = true;
        }

        model.addAttribute("isSigned", isSigned);
        model.addAttribute("isCreator", isCreator);
        model.addAttribute("petition", petition);

        return "viewPetition";
    }

    @PostMapping("/signPetition/{petitionID}")
    @ResponseBody
    public String signPetition(@PathVariable("petitionID") String petitionID) {
        System.out.println("Signing petition");

        User u = userService.getCurrentUser();
        Petition p = petitionService.findPetitionByPetitionID(Integer.parseInt(petitionID));
        petitionService.signPetition(p.getPetitionID(), u.getUserEmail());
        return "Success";
    }

}
