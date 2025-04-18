package com.example;

import javax.persistence.*;

@Entity
@Table(name = "emprunt", schema = "bibliotheque")
public class Emprunt {

    @Id
    @Column(name = "id_emprunt")
    private String idEmprunt;

    @Column(name = "jour_debut")
    private int jourDebut;

    @Column(name = "mois_debut")
    private int moisDebut;

    @Column(name = "annee_debut")
    private int anneeDebut;

    @Column(name = "jour_retour")
    private Integer jourRetour;

    @Column(name = "mois_retour")
    private Integer moisRetour;

    @Column(name = "annee_retour")
    private Integer anneeRetour;

    @ManyToOne
    @JoinColumn(name = "ID")
    private Adherant adherant;

    @Column(name = "id_exemplaire")
    private String idExemplaire;

    @Column(name = "ISBN")
    private String isbn;

    // ✅ Getters nécessaires pour que Hibernate accède aux données
    public String getIdEmprunt() {
        return idEmprunt;
    }

    public int getJourDebut() {
        return jourDebut;
    }

    public int getMoisDebut() {
        return moisDebut;
    }

    public int getAnneeDebut() {
        return anneeDebut;
    }

    public Integer getJourRetour() {
        return jourRetour;
    }

    public Integer getMoisRetour() {
        return moisRetour;
    }

    public Integer getAnneeRetour() {
        return anneeRetour;
    }

    public Adherant getAdherant() {
        return adherant;
    }

    public String getIdExemplaire() {
        return idExemplaire;
    }

    public String getIsbn() { 
        return isbn;
    }

    public void setIsbn(String isbn) {
        this.isbn = isbn;
    }
    
}
