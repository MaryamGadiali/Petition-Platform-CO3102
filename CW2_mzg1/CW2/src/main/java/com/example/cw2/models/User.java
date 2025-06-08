package com.example.cw2.models;

import com.fasterxml.jackson.annotation.JsonIgnore;

import javax.persistence.*;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

@Entity
public class User {

    @Id
    @Column
    private String userEmail;

    @Column
    private String fullname;

    @Column
    private Date dateOfBirth;

    @Column
    private String passwordHash;

    @Column
    private String role;

    @OneToOne
    @JoinColumn(name = "bioID")
    private BioID bioID;

    @ManyToMany(mappedBy = "signers")
    @JsonIgnore
    private List<Petition> signedPetitions = new ArrayList<>();

    @OneToMany(mappedBy = "petitionCreator")
    @JsonIgnore
    private List<Petition> createdPetitions = new ArrayList<>();


    public String getUserEmail() {
        return userEmail;
    }

    public void setUserEmail(String userEmail) {
        this.userEmail = userEmail;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public Date getDateOfBirth() {
        return dateOfBirth;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public void setDateOfBirth(Date dateOfBirth) {
        this.dateOfBirth = dateOfBirth;
    }

    public String getPasswordHash() {
        return passwordHash;
    }

    public void setPasswordHash(String passwordHash) {
        this.passwordHash = passwordHash;
    }

    public BioID getBioID() {
        return bioID;
    }

    public void setBioID(BioID bioID) {
        this.bioID = bioID;
    }

    public List<Petition> getSignedPetitions() {
        return signedPetitions;
    }

    public void setSignedPetitions(List<Petition> signedPetitions) {
        this.signedPetitions = signedPetitions;
    }

    public List<Petition> getCreatedPetitions() {
        return createdPetitions;
    }

    public void setCreatedPetitions(List<Petition> createdPetitions) {
        this.createdPetitions = createdPetitions;
    }

    //add to created petitions
    public void addCreatedPetition(Petition petition){
        this.createdPetitions.add(petition);
    }

    //add to signed petitions
    public void addSignedPetition(Petition petition){
        this.signedPetitions.add(petition);
    }
}
