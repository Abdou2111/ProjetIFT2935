package com.example;

import javax.persistence.*;
import javax.swing.JOptionPane;

import java.util.List;

public class DemoQueries {
    private static final EntityManagerFactory emf = Persistence.createEntityManagerFactory("bibliothequePU");

    public static void showAdherantSituation() {
        EntityManager em = emf.createEntityManager();

        List<Object[]> results = em.createQuery(
            "SELECT a.nom, COUNT(e), SUM(CASE WHEN " +
            "FUNCTION('make_date', e.anneeRetour, e.moisRetour, e.jourRetour) > " +
            "FUNCTION('make_date', e.anneeDebut, e.moisDebut, e.jourDebut) + 14 THEN 1 ELSE 0 END) " +
            "FROM Emprunt e JOIN e.adherant a GROUP BY a.nom", Object[].class)
            .getResultList();
    
        StringBuilder message = new StringBuilder("📚 Situation des adhérents :\n\n");
    
        for (Object[] row : results) {
            String nom = (String) row[0];
            Long nbEmprunts = (Long) row[1];
            Long retards = (row[2] != null) ? (Long) row[2] : 0L;
            message.append("• ").append(nom)
                   .append(" | Emprunts : ").append(nbEmprunts)
                   .append(" | Retards : ").append(retards).append("\n");
        }
    
        em.close();
    
        JOptionPane.showMessageDialog(null, message.toString(), "Résultat - Situation des adhérents", JOptionPane.INFORMATION_MESSAGE);
    }
    

    public static void showGenreEmprunts() {
        EntityManager em = emf.createEntityManager();
        List<Object[]> results = em.createQuery(
            "SELECT l.genre, COUNT(e) FROM Emprunt e JOIN Livre l ON e.isbn = l.ISBN GROUP BY l.genre ORDER BY COUNT(e) DESC",
            Object[].class).getResultList();

            StringBuilder message = new StringBuilder("📊 Répartition des emprunts par genre :\n\n");

            for (Object[] row : results) {
                String genre = (String) row[0];
                Long count = (Long) row[1];
                message.append("• ").append(genre).append(" : ").append(count).append(" emprunt(s)\n");
            }
        
            em.close();
        
            JOptionPane.showMessageDialog(null, message.toString(), "Statistiques par genre", JOptionPane.INFORMATION_MESSAGE);
    }

    public static void showTopLivres() {
        EntityManager em = emf.createEntityManager();

    List<Object[]> results = em.createQuery(
        "SELECT l.titre, COUNT(e) FROM Emprunt e JOIN Livre l ON e.isbn = l.ISBN GROUP BY l.titre ORDER BY COUNT(e) DESC",
        Object[].class)
        .setMaxResults(3)
        .getResultList();

    StringBuilder message = new StringBuilder("🏆 Top 3 livres les plus empruntés :\n\n");

    for (Object[] row : results) {
        String titre = (String) row[0];
        Long count = (Long) row[1];
        message.append("• ").append(titre).append(" : ").append(count).append(" emprunt(s)\n");
    }

    em.close();

    JOptionPane.showMessageDialog(null, message.toString(), "Top Livres", JOptionPane.INFORMATION_MESSAGE);
    }

    public static void showCommandesParEtat() {
        EntityManager em = emf.createEntityManager();

        List<Object[]> results = em.createQuery(
            "SELECT c.etat, COUNT(c) FROM Commande c GROUP BY c.etat ORDER BY COUNT(c) DESC",
            Object[].class).getResultList();
    
        StringBuilder message = new StringBuilder("📦 Répartition des commandes par état :\n\n");
    
        for (Object[] row : results) {
            String etat = (String) row[0];
            Long count = (Long) row[1];
            message.append("• ").append(etat).append(" : ").append(count).append(" commande(s)\n");
        }
    
        em.close();
    
        JOptionPane.showMessageDialog(null, message.toString(), "Commandes par état", JOptionPane.INFORMATION_MESSAGE);
    }

    public static void showEmpruntsParAnneeInscription() {
        EntityManager em = emf.createEntityManager();

        List<Object[]> results = em.createQuery(
            "SELECT a.anneeInscription, COUNT(e) " +
            "FROM Emprunt e JOIN e.adherant a " +
            "GROUP BY a.anneeInscription ORDER BY a.anneeInscription",
            Object[].class
        ).getResultList();

        StringBuilder message = new StringBuilder("\uD83D\uDCCA Emprunts par année d’inscription :\n\n");
        for (Object[] row : results) {
            Integer annee = (Integer) row[0];
            Long total = (Long) row[1];
            message.append("• ").append(annee).append(" → ").append(total).append(" emprunts\n");
        }

        em.close();

        JOptionPane.showMessageDialog(null, message.toString(), "Statistiques - Emprunts par année", JOptionPane.INFORMATION_MESSAGE);
    }

    public static void showAdherantsAvec3Commandes() {
        EntityManager em = emf.createEntityManager();
    
        List<Object[]> results = em.createQuery(
            "SELECT a.nom, COUNT(c) FROM Commande c JOIN c.adherant a " +
            "GROUP BY a.nom HAVING COUNT(c) = 3", Object[].class)
            .getResultList();
    
        StringBuilder message = new StringBuilder("📦 Adhérents avec 3 commandes :\n\n");
    
        for (Object[] row : results) {
            String nom = (String) row[0];
            Long total = (Long) row[1];
            message.append("• ").append(nom)
                   .append(" → ").append(total).append(" commandes\n");
        }
    
        em.close();
    
        JOptionPane.showMessageDialog(null, message.toString(), "Résultat - 3 Commandes", JOptionPane.INFORMATION_MESSAGE);
    }

    public static void showEmpruntsParGenreEtAnneeInscription() {
        EntityManager em = emf.createEntityManager();
        List<Object[]> results = em.createQuery(
            "SELECT a.anneeInscription, l.genre, COUNT(e) FROM Emprunt e JOIN e.adherant a JOIN Livre l ON e.isbn = l.ISBN GROUP BY a.anneeInscription, l.genre ORDER BY a.anneeInscription, COUNT(e) DESC",
            Object[].class).getResultList();

        StringBuilder message = new StringBuilder("📈 Emprunts par genre et année d'inscription :\n\n");
        for (Object[] row : results) {
            message.append("• Année: ").append(row[0])
                   .append(" | Genre: ").append(row[1])
                   .append(" | Emprunts: ").append(row[2]).append("\n");
        }
        em.close();

        JOptionPane.showMessageDialog(null, message.toString(), "Résultat - Genre & Année", JOptionPane.INFORMATION_MESSAGE);
    }
    
}
    

