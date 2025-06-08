package com.example.cw2.controllers;

import com.example.cw2.models.Petition;

import com.example.cw2.services.PetitionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class SLPPController {

    @Autowired
    private PetitionService petitionService;

    //Return the details of all and open petitions
    @GetMapping("/slpp/petitions")
    public @ResponseBody Object getOpenPetitions(@RequestParam(value = "status",defaultValue = "all")String status ) {
        if(status.equals("all")){
            List<Petition> o = petitionService.findAllPetitions();
            Map<String, Object> response = new HashMap<>();
            response.put("petitions", o);
            return response;
        }
        else if (status.equals("open")){
            List<Petition> o = petitionService.findOpenPetitions();
            Map<String, Object> response = new HashMap<>();
            response.put("petitions", o);
            return response;
        }
        else{
            return "Invalid request";
        }
    }

}
