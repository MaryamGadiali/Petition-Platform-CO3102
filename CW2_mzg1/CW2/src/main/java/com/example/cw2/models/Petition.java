package com.example.cw2.models;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
@JsonPropertyOrder({"petition_id", "status", "petition_title", "petition_text", "petitioner", "signatures", "response"})
public class Petition {

    @Id
    @GeneratedValue
    @Column
    @JsonProperty("petition_id")
    @JsonFormat(shape = JsonFormat.Shape.STRING)
    private int petitionID;

    @JsonIgnore
    @ManyToOne
    private User petitionCreator;

    @Column
    @JsonProperty("status")
    private String status = "open"; //Default should be open

    @JsonProperty("petitioner")
    private String petitionCreatorEmail;

    @Column
    @JsonProperty("petition_title")
    private String title;

    @Column
    @JsonProperty("petition_text")
    private String content;

    @Column
    @JsonProperty("response")
    private String response=""; //Default should be null or empty

    @Column
    @JsonProperty("signatures")
    @JsonFormat(shape = JsonFormat.Shape.STRING)
    private int signatureCount;

    @JsonIgnore
    public static int signatureThreshold = 1000;

        @ManyToMany
        @JsonIgnore
        @JoinTable(name = "petition_signers", joinColumns = @JoinColumn(name = "petition_id"), inverseJoinColumns = @JoinColumn(name = "user_email"))
        private List<User> signers = new ArrayList<>();

    public int getPetitionID() {
        return petitionID;
    }

    public void setPetitionID(int petitionID) {
        this.petitionID = petitionID;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public User getPetitionCreator() {
        return petitionCreator;
    }

    public void setPetitionCreator(User petitionCreator) {
        this.petitionCreator = petitionCreator;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getResponse() {
        return response;
    }

    public void setResponse(String response) {
        this.response = response;
    }

    public int getSignatureCount() {
        return signatureCount;
    }

    public void setSignatureCount(int signatureCount) {
        this.signatureCount = signatureCount;
    }

    public List<User> getSigners() {
        return signers;
    }

    public void setSigners(List<User> signers) {
        this.signers = signers;
    }

    //increase signature count
    public void increaseSignatureCount(){
        this.signatureCount++;
    }

    //add to signers
    public void addSigner(User user){
        this.signers.add(user);
    }

    @JsonIgnore
    public int getSignatureThreshold() {
        return signatureThreshold;
    }

    public void setSignatureThreshold(int signatureThreshold) {
        this.signatureThreshold = signatureThreshold;
    }


    public String getPetitionCreatorEmail() {
        return petitionCreatorEmail;
    }

    public void setPetitionCreatorEmail(String petitionCreatorEmail) {
        this.petitionCreatorEmail = petitionCreatorEmail;
    }
}
