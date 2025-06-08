package com.example.cw2.repositories;

import com.example.cw2.models.BioID;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface BioIDRepository extends CrudRepository<BioID, String> {

    BioID findByCode(String code);
}
