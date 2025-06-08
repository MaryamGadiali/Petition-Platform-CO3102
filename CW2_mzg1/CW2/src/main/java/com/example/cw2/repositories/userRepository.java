package com.example.cw2.repositories;

import com.example.cw2.models.Petition;
import com.example.cw2.models.User;
import org.springframework.stereotype.Repository;
import org.springframework.data.repository.CrudRepository;

@Repository
public interface userRepository extends CrudRepository<User, String>{

    public User findByUserEmail(String email);

}
