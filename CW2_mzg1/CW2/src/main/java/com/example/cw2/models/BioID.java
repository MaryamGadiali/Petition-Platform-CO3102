package com.example.cw2.models;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.*;

@Entity
public class BioID {

    @Id
    @Column
    private String code;


    @OneToOne(mappedBy = "bioID")
    private User user = null; //null by default to show non used

    public BioID(String code) {
        this.code = code;
    }

    public BioID() {

    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }
}
