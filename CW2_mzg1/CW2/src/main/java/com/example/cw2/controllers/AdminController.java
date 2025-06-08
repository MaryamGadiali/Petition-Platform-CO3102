package com.example.cw2.controllers;

import com.example.cw2.models.Petition;
import com.example.cw2.models.User;
import com.example.cw2.services.PetitionService;
import com.example.cw2.services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private PetitionService petitionService;

    @Autowired
    private UserService userService;

    @ModelAttribute("userName")
    public String getCurrentUserName() {
        User currentUser = userService.getCurrentUser();
        return currentUser != null ? currentUser.getFullname() : "Guest"; //shouldn't be guest, but just a placeholder
    }

    @GetMapping("/petitionsCommitteeDashboard")
    public String petitionsCommitteeDashboard(Model model) {
        //Passes in the signature threshold value
        model.addAttribute("signatureThreshold", Petition.signatureThreshold);

        //Passes in all petitions
        List<Petition> allPetitions = petitionService.findAllPetitions();
        model.addAttribute("allPetitions", allPetitions);

        //Passes in top 5 open petitions by signatures
        List<Petition> top5OpenPetitions = petitionService.findTop5OpenPetitionsBySignatures();
        model.addAttribute("top5OpenPetitions", top5OpenPetitions);

        //Passes in 2 model attributes, one for the amount of open petitions above the threshold, and one for the amount of open petitions below the threshold
        long openPetitionsAboveThreshold = petitionService.countOpenPetitionsAboveThreshold();
        long openPetitionsBelowThreshold = petitionService.countOpenPetitionsBelowThreshold();
        model.addAttribute("openPetitionsAboveThreshold", openPetitionsAboveThreshold);
        model.addAttribute("openPetitionsBelowThreshold", openPetitionsBelowThreshold);
        return "petitionsCommitteeDashboard";
    }

    @PostMapping("/updateSignatureThresholdValue")
    @ResponseBody
    public String updateSignatureThresholdValue(@RequestParam("newSignatureThreshold") int newSignatureThreshold) {
        System.out.println("New threshold value: " + newSignatureThreshold);
        Petition.signatureThreshold = newSignatureThreshold;
        return "Success";
    }

    @GetMapping("/petition/{petitionID}")
    public String viewPetition(@PathVariable("petitionID") int petitionID , Model model) {
        Petition petition = petitionService.findPetitionByPetitionID(petitionID);
        model.addAttribute("petition", petition);
        return "adminViewPetition";
    }

    @PostMapping("/petition/{petitionID}/sendResponse")
    @ResponseBody
    public String sendResponse(@PathVariable("petitionID") int petitionID, @RequestParam("responseText") String responseText) {
        Petition petition = petitionService.findPetitionByPetitionID(petitionID);
        petition.setResponse(responseText);
        petition.setStatus("closed");
        petitionService.savePetition(petition);
        return "Success";
    }


}
