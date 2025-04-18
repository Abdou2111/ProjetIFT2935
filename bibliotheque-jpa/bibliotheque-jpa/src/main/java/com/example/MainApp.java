package com.example;

import javax.swing.*;

public class MainApp {
    public static void main(String[] args) {
        JFrame frame = new JFrame("Bibliothèque - Requêtes");
        frame.setSize(420, 400);
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setLayout(null);

        JButton btn1 = new JButton("Situation des adhérents");
        JButton btn2 = new JButton("Répartition des emprunts");
        JButton btn3 = new JButton("Livres les plus empruntés");
        JButton btn4 = new JButton("Commandes par état");
        JButton btn5 = new JButton("Emprunts par année d’inscription");
        JButton btn6 = new JButton("Adhérents avec 3 commandes");
        JButton btn7 = new JButton("Emprunts par genre et année d'inscription");

        btn1.setBounds(50, 30, 300, 30);
        btn2.setBounds(50, 70, 300, 30);
        btn3.setBounds(50, 110, 300, 30);
        btn4.setBounds(50, 150, 300, 30);
        btn5.setBounds(50, 190, 300, 30);
        btn6.setBounds(50, 230, 300, 30);
        btn7.setBounds(50,270,300,30);
        

        frame.add(btn1);
        frame.add(btn2);
        frame.add(btn3);
        frame.add(btn4);
        frame.add(btn5);
        frame.add(btn6);
        frame.add(btn7);



        btn1.addActionListener(e -> DemoQueries.showAdherantSituation());
        btn2.addActionListener(e -> DemoQueries.showGenreEmprunts());
        btn3.addActionListener(e -> DemoQueries.showTopLivres());
        btn4.addActionListener(e -> DemoQueries.showCommandesParEtat());
        btn5.addActionListener(e -> DemoQueries.showEmpruntsParAnneeInscription());
        btn6.addActionListener(e -> DemoQueries.showAdherantsAvec3Commandes());
        btn7.addActionListener(e -> DemoQueries.showEmpruntsParGenreEtAnneeInscription());


        frame.setVisible(true);
    }
}