package com.example;

import javax.persistence.*;

@Entity
@Table(name = "livre", schema = "bibliotheque")
public class Livre {

    @Id
    private String ISBN;

    private String titre;
    private String genre;
    private String auteur;

    // --- GETTERS ---
    public String getISBN() {
        return ISBN;
    }

    public String getTitre() {
        return titre;
    }

    public String getGenre() {
        return genre;
    }

    public String getAuteur() {
        return auteur;
    }

    // --- SETTERS ---
    public void setISBN(String ISBN) {
        this.ISBN = ISBN;
    }

    public void setTitre(String titre) {
        this.titre = titre;
    }

    public void setGenre(String genre) {
        this.genre = genre;
    }

    public void setAuteur(String auteur) {
        this.auteur = auteur;
    }
}
