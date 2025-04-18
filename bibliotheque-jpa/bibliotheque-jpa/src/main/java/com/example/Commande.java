package com.example;

import javax.persistence.*;

@Entity
@Table(name = "commande", schema = "bibliotheque")
public class Commande {

    @Id
    @Column(name = "numero_commande")
    private String numeroCommande;

    @Column(name = "etat")
    private String etat;

    @Column(name = "jour_commandee")
    private int jourCommandee;

    @Column(name = "mois_commandee")
    private int moisCommandee;

    @Column(name = "annee_commandee")
    private int anneeCommandee;

    @Column(name = "id_exemplaire")
    private String idExemplaire;

    @Column(name = "ISBN")
    private String isbn;

    @ManyToOne
    @JoinColumn(name = "ID")
    private Adherant adherant;

    // --- GETTERS ---
    public String getNumeroCommande() {
        return numeroCommande;
    }

    public String getEtat() {
        return etat;
    }

    public int getJourCommandee() {
        return jourCommandee;
    }

    public int getMoisCommandee() {
        return moisCommandee;
    }

    public int getAnneeCommandee() {
        return anneeCommandee;
    }

    public String getIdExemplaire() {
        return idExemplaire;
    }

    public String getIsbn() {
        return isbn;
    }

    public Adherant getAdherant() {
        return adherant;
    }

    // --- SETTERS ---
    public void setNumeroCommande(String numeroCommande) {
        this.numeroCommande = numeroCommande;
    }

    public void setEtat(String etat) {
        this.etat = etat;
    }

    public void setJourCommandee(int jourCommandee) {
        this.jourCommandee = jourCommandee;
    }

    public void setMoisCommandee(int moisCommandee) {
        this.moisCommandee = moisCommandee;
    }

    public void setAnneeCommandee(int anneeCommandee) {
        this.anneeCommandee = anneeCommandee;
    }

    public void setIdExemplaire(String idExemplaire) {
        this.idExemplaire = idExemplaire;
    }

    public void setIsbn(String isbn) {
        this.isbn = isbn;
    }

    public void setAdherant(Adherant adherant) {
        this.adherant = adherant;
    }
}
