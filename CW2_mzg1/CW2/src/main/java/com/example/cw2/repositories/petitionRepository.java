package com.example.cw2.repositories;

import com.example.cw2.models.Petition;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface petitionRepository extends CrudRepository<Petition, Integer> {

    Petition findPetitionByPetitionID(int petitionId);

    List<Petition> findAllByStatus(String status);

    long countByStatusAndSignatureCountGreaterThanEqual(String open, int signatureThreshold);

    long countByStatusAndSignatureCountLessThan(String status, int signatureCountIsLessThan);
}
