package com.example.cw2.services;

import com.example.cw2.models.Petition;
import com.example.cw2.models.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.example.cw2.repositories.petitionRepository;

import java.util.List;

@Service
public class PetitionService {

    @Autowired
    private petitionRepository petitionRepository;

    @Autowired
    private UserService uService;


    public List<Petition> findAllPetitions(){
        return (List<Petition>) petitionRepository.findAll();
    }

    public void savePetition(Petition petition) {
        petitionRepository.save(petition);
    }

    public Petition findPetitionByPetitionID(int petitionId) {
        return petitionRepository.findPetitionByPetitionID(petitionId);
    }

    public List<Petition> findTop5OpenPetitionsBySignatures() {
        //get all petitions, sort by signatures, return top 5
        List<Petition> allOpenPetitions = (List<Petition>) petitionRepository.findAllByStatus("open");
        allOpenPetitions.sort((p1, p2) -> p2.getSignatureCount() - p1.getSignatureCount());
        if (allOpenPetitions.size() < 5) {
            return allOpenPetitions;
        }
        return allOpenPetitions.subList(0, 5);
    }

    public long countOpenPetitionsAboveThreshold() {
       return petitionRepository.countByStatusAndSignatureCountGreaterThanEqual("open", Petition.signatureThreshold);
    }


    public long countOpenPetitionsBelowThreshold() {
        return petitionRepository.countByStatusAndSignatureCountLessThan("open",Petition.signatureThreshold);
    }

    public List<Petition> findOpenPetitions() {
        return petitionRepository.findAllByStatus("open");
    }

    public void signPetition(int petitionId, String userEmail) {
        Petition p = findPetitionByPetitionID(petitionId);
        User u = uService.findByUserEmail(userEmail);
        p.addSigner(u);
        u.addSignedPetition(p);
        p.increaseSignatureCount();
        savePetition(p);
        uService.save(u);
    }
}
