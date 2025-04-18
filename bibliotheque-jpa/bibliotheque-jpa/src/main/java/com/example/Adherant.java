package com.example;

import javax.persistence.*;
import java.util.List;

@Entity
@Table(name = "adherant", schema = "bibliotheque")
public class Adherant {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int ID;

    private String nom;
    private String prenom;
    private String courriel;
    private String telephone;

    @Column(name = "nombre_emprunt")
    private int nombreEmprunt;

    @Column(name = "jour_inscription")
    private int jourInscription;

    @Column(name = "mois_inscription")
    private int moisInscription;

    @Column(name = "annee_inscription")
    private int anneeInscription;

    @OneToMany(mappedBy = "adherant")
    private List<Emprunt> emprunts;

    // --- GETTERS ---
    public int getID() {
        return ID;
    }

    public String getNom() {
        return nom;
    }

    public String getPrenom() {
        return prenom;
    }

    public String getCourriel() {
        return courriel;
    }

    public String getTelephone() {
        return telephone;
    }

    public int getNombreEmprunt() {
        return nombreEmprunt;
    }

    public int getJourInscription() {
        return jourInscription;
    }

    public int getMoisInscription() {
        return moisInscription;
    }

    public int getAnneeInscription() {
        return anneeInscription;
    }

    public List<Emprunt> getEmprunts() {
        return emprunts;
    }
}
