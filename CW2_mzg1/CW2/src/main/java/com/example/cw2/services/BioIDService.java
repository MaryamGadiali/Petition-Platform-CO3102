package com.example.cw2.services;

import com.example.cw2.models.BioID;
import com.example.cw2.repositories.BioIDRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class BioIDService {

    @Autowired
    private BioIDRepository repo;

    public BioID findBioID(String bioID) {
        return repo.findByCode(bioID);
    }

    public void save(BioID b) {
        repo.save(b);
    }


}
