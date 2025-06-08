package com.example.cw2;

import com.example.cw2.models.BioID;
import com.example.cw2.models.Petition;
import com.example.cw2.models.User;
import com.example.cw2.services.BioIDService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

@SpringBootApplication
public class Cw2Application implements CommandLineRunner {

    @Autowired
    private com.example.cw2.repositories.userRepository userRepo;

    @Autowired
    private com.example.cw2.repositories.petitionRepository petitionRepo;

    @Autowired
    private BioIDService bioIDService;

    public static void main(String[] args) {
        SpringApplication.run(Cw2Application.class, args);
    }


    @Override
    public void run(String... args) throws Exception {
        //The hardcoded admin account
        User admin = new User();
        admin.setUserEmail("admin@petition.parliament.sr");
        admin.setFullname("Admin");
        admin.setPasswordHash(new BCryptPasswordEncoder().encode("2025%shangrila"));
        admin.setRole("ROLE_ADMIN");
        userRepo.save(admin);

        //Create bio ids:
        BioID b1 = new BioID("K1YL8VA2HG");
        BioID b2 = new BioID("7DMPYAZAP2");
        BioID b3 = new BioID("D05HPPQNJ4");
        BioID b4 = new BioID("2WYIM3QCK9");
        BioID b5 = new BioID("DHKFIYHMAZ");
        BioID b6 = new BioID("LZK7P0X0LQ");
        BioID b7 = new BioID("H5C98XCENC");
        BioID b8 = new BioID("6X6I6TSUFG");
        BioID b9 = new BioID("QTLCWUS8NB");
        BioID b10 = new BioID("Y4FC3F9ZGS");
        BioID b11 = new BioID("V30EPKZQI2");
        BioID b12 = new BioID("O3WJFGR5WE");
        BioID b13 = new BioID("SEIQTS1H16");
        BioID b14 = new BioID("X16V7LFHR2");
        BioID b15 = new BioID("TLFDFY7RDG");
        BioID b16 = new BioID("PGPVG5RF42");
        BioID b17 = new BioID("FPALKDEL5T");
        BioID b18 = new BioID("2BIB99Z54V");
        BioID b19 = new BioID("ABQYUQCQS2");
        BioID b20 = new BioID("9JSXWO4LGH");
        BioID b21 = new BioID("QJXQOUPTH9");
        BioID b22 = new BioID("GOYWJVDA8A");
        BioID b23 = new BioID("6EBQ28A62V");
        BioID b24 = new BioID("30MY51J1CJ");
        BioID b25 = new BioID("FH6260T08H");
        BioID b26 = new BioID("JHDCXB62SA");
        BioID b27 = new BioID("O0V55ENOT0");
        BioID b28 = new BioID("F3ATSRR5DQ");
        BioID b29 = new BioID("1K3JTWHA05");
        BioID b30 = new BioID("FINNMWJY0G");
        BioID b31 = new BioID("CET8NUAE09");
        BioID b32 = new BioID("VQKBGSE3EA");
        BioID b33 = new BioID("E7D6YUPQ6J");
        BioID b34 = new BioID("BPX8O0YB5L");
        BioID b35 = new BioID("AT66BX2FXM");
        BioID b36 = new BioID("1PUQV970LA");
        BioID b37 = new BioID("CCU1D7QXDT");
        BioID b38 = new BioID("TTK74SYYAN");
        BioID b39 = new BioID("4HTOAI9YKO");
        BioID b40 = new BioID("PD6XPNB80J");
        BioID b41 = new BioID("BZW5WWDMUY");
        BioID b42 = new BioID("340B1EOCMG");
        BioID b43 = new BioID("CG1I9SABLL");
        BioID b44 = new BioID("49YFTUA96K");
        BioID b45 = new BioID("V2JX0IC633");
        BioID b46 = new BioID("C7IFP4VWIL");
        BioID b47 = new BioID("RYU8VSS4N5");
        BioID b48 = new BioID("S22A588D75");
        BioID b49 = new BioID("88V3GKIVSF");
        BioID b50 = new BioID("8OLYIE2FRC");

        //Save the bio ids
        bioIDService.save(b1);
        bioIDService.save(b2);
        bioIDService.save(b3);
        bioIDService.save(b4);
        bioIDService.save(b5);
        bioIDService.save(b6);
        bioIDService.save(b7);
        bioIDService.save(b8);
        bioIDService.save(b9);
        bioIDService.save(b10);
        bioIDService.save(b11);
        bioIDService.save(b12);
        bioIDService.save(b13);
        bioIDService.save(b14);
        bioIDService.save(b15);
        bioIDService.save(b16);
        bioIDService.save(b17);
        bioIDService.save(b18);
        bioIDService.save(b19);
        bioIDService.save(b20);
        bioIDService.save(b21);
        bioIDService.save(b22);
        bioIDService.save(b23);
        bioIDService.save(b24);
        bioIDService.save(b25);
        bioIDService.save(b26);
        bioIDService.save(b27);
        bioIDService.save(b28);
        bioIDService.save(b29);
        bioIDService.save(b30);
        bioIDService.save(b31);
        bioIDService.save(b32);
        bioIDService.save(b33);
        bioIDService.save(b34);
        bioIDService.save(b35);
        bioIDService.save(b36);
        bioIDService.save(b37);
        bioIDService.save(b38);
        bioIDService.save(b39);
        bioIDService.save(b40);
        bioIDService.save(b41);
        bioIDService.save(b42);
        bioIDService.save(b43);
        bioIDService.save(b44);
        bioIDService.save(b45);
        bioIDService.save(b46);
        bioIDService.save(b47);
        bioIDService.save(b48);
        bioIDService.save(b49);
        bioIDService.save(b50);

//       //Mock data below
//
//        User user9 = new User();
//        user9.setUserEmail("user@user");
//        user9.setFullname("Alice");
//        user9.setPasswordHash(new BCryptPasswordEncoder().encode("user"));
//        user9.setRole("ROLE_CITIZEN");
//        userRepo.save(user9);
//
//        //Create a list of users
//        User u1 = new User();
//        u1.setUserEmail("user1@user");
//        u1.setFullname("Bob");
//        u1.setPasswordHash(new BCryptPasswordEncoder().encode("user"));
//        u1.setRole("ROLE_CITIZEN");
//        userRepo.save(u1);
//
//        User u2 = new User();
//        u2.setUserEmail("user2@user");
//        u2.setFullname("Charlie");
//        u2.setPasswordHash(new BCryptPasswordEncoder().encode("user"));
//        u2.setRole("ROLE_CITIZEN");
//        userRepo.save(u2);
//
//        User u3 = new User();
//        u3.setFullname("Daniel");
//        u3.setUserEmail("user3@user");
//        u3.setPasswordHash(new BCryptPasswordEncoder().encode("user"));
//        u3.setRole("ROLE_CITIZEN");
//        userRepo.save(u3);
//
//
//        //Create a list of petitions
//        Petition p1 = new Petition();
//        p1.setContent("I am the first petition");
//        p1.setTitle("Petition 1");
//        p1.setSignatureCount(15);
//        p1.setPetitionCreator(user9);
//        p1.setPetitionCreatorEmail("user@user");
//        p1.setStatus("closed");
//        p1.setPetitionID(1);
//        p1.setResponse("This is the response to the first petition");
//        petitionRepo.save(p1);
//
//        Petition p2 = new Petition();
//        p2.setContent("I am the second petition");
//        p2.setTitle("Petition 2");
//        p2.setSignatureCount(10);
//        p2.setPetitionCreator(u1);
//        p2.setPetitionCreatorEmail("user1@user");
//        p2.setStatus("closed");
//        p2.setPetitionID(2);
//        p2.setResponse("This is the response to the second petition");
//        petitionRepo.save(p2);
//
//        Petition p3 = new Petition();
//        p3.setContent("I am the third petition");
//        p3.setTitle("Petition 3");
//        p3.setSignatureCount(5);
//        p3.setPetitionCreator(u2);
//        p3.setPetitionCreatorEmail("user2@user");
//        p3.setStatus("open");
//        p3.setPetitionID(3);
//        petitionRepo.save(p3);

//        user9.setBioID(b1);
//        userRepo.save(user9);

    }
}
