MyTHiCaL
mythical4774
Invisible

Zaytoon — 06/04/2025 20:16
Je suis là aussi
Naro — 06/04/2025 20:19
J’ai pas encore prier 😭😂
10min et je suis là
Naro — 09/04/2025 11:43
Quand est-ce qu’on devait montrer nos codes sql¿
MyTHiCaL — 09/04/2025 12:14
Jamais
(C'est olive qui q écrit ça)
(Pas vrai)
(Si c'est la vérité)
MyTHiCaL — 16/04/2025 19:53
Hello j'ai push ce que j'ai fais
il me reste 1 table
Aïssatou — 16/04/2025 19:53
Okay je vais compléter
MyTHiCaL — 16/04/2025 19:54
Okk
Apres que tt le monde finisse sa partie on doit reverifier les types des attributs et genre comment on veut que les ids soit
Par exemple le id_emprunt je l'ai mis de la forme 'E123'
Aïssatou — 16/04/2025 21:27
Okayyy
Aïssatou — Hier à 03:45
J’ai fais l’interface avec Hibernate et fini la base de données je suis en train d’essayer d’afficher le resulta des requêtes et ca devrait etre bon apres
J’enverrais les requêtes en algebre pour Naromba le mette sur le rapport
MyTHiCaL — Hier à 12:07
Push les stp
Zaytoon — Hier à 12:52
Allô
J'étais en train de faire mes tables dans le projet, mais j'ai vu qu'il y avait quelques incohérences (comme le fait que Naromba et moi devions tous 2 faire une table exemplaire par exemple) donc j'ai décidé de revérifier ce qu'on avait fait
Zaytoon — Hier à 13:07
L'un des trucs sur lesquels il y a problème c'est sur nombre exemplaire:
on a mis: livre(ISBN, titre, genre, auteur) et exemplaire(id_exemp, #ISBN, nb_exemplaire)

Mais selon moi, ça ne fait pas trop de sens car c'est plutôt avec les livres que je peux connaitre le nombre d'exemplaires non?
Genre je me dis que si dans ma base de données je regarde le livre, je vois qu'il a x exemplaires
Alors que si je prends un exemplaire, je ne peux pas voir le nombre d'exemplaires 

Une autre solution serait aussi de retirer cet attribut car si on veut le nombre d'exemplaires on pourrai juste faire un count non?
Désolé de ramener ça sur la table, mais j'ai vraiment besoin de comprendre pour continuer😅
MyTHiCaL — Hier à 13:12
Je suis d'accord avec les 2 idées
Aïssatou — Hier à 13:16
Ecrit les 2 table ici je vois stpp
Aïssatou — Hier à 13:16
Oui tinquiete je veux juste en finir et je le ferai ce soir normalement
Zaytoon — Hier à 13:18
ça c'est ce qu'on a:
livre(ISBN, titre, genre, auteur) 
exemplaire(id_exemp, #ISBN, nb_exemplaire)

Selon moi il faudrait:
livre(ISBN, titre, genre, auteur, nb_exemplaire) 
exemplaire(id_exemp, #ISBN)

ou 

livre(ISBN, titre, genre, auteur) 
exemplaire(id_exemp, #ISBN)
Aïssatou — Hier à 13:20
Les deux dernieres tables pour moi c’est bon
Zaytoon — Hier à 13:20
Sans le nb_exemplaire?
Aïssatou — Hier à 13:20
Ouii car je fais un count dans mes méthodes
MyTHiCaL — Hier à 13:21
On est good alors?
Zaytoon — Hier à 13:21
I guess yes
Naro — Hier à 13:22
ouais ça me semble logique
Zaytoon — Hier à 13:39
Selon vous, lequel des id_emp est une clé étrangère? 
Image
MyTHiCaL — Hier à 13:43
J'ai pas compris la question
Zaytoon — Hier à 13:44
On a Id_emp dans détail_emprunt
On a Id_emp dans emprunt

Est-ce que c'est celui de detail_umprunt qui est une clé étrangère?
MyTHiCaL — Hier à 13:45
Oui je pense
Zaytoon — Hier à 13:46
Ok merci
Aïssatou — Hier à 17:08
Je ferai de mon mieux pour terminer le tout ce soir inshallah
Aïssatou — Hier à 22:22
Vous êtes disponibles pour un appel?
J’ai bientôt fini et j’aimerais vous expliquer un peu ce que j’ai fais ou pas besoin ?
😂
Zaytoon — Hier à 22:23
Je viens car j'ai des trucs à expliquer et demander aussi
Zaytoon — Hier à 23:07
Image
Aïssatou — 01:53
1. Situation des adhérents
SQL :
SELECT a.nom, COUNT(e), SUM(CASE WHEN ... THEN 1 ELSE 0 END)
FROM Emprunt e JOIN Adherant a ON e.ID = a.ID
GROUP BY a.nom;
Afficher plus
message.txt
4 Ko
CREATE SCHEMA IF NOT EXISTS bibliotheque;
SET search_path TO bibliotheque;
-- 1) Code postal
CREATE TABLE Code_postal (
  code_postal  VARCHAR(6)  PRIMARY KEY,
  ville        VARCHAR(50) NOT NULL,
  pays         VARCHAR(50) NOT NULL
);

-- 2) Adhérents
CREATE TABLE Adherant (
  ID                 SERIAL      PRIMARY KEY,
  nom                VARCHAR(100) NOT NULL,
  prenom             VARCHAR(50),
  courriel           VARCHAR(100) NOT NULL UNIQUE,
  telephone          VARCHAR(15),
  nombre_emprunt     INT         NOT NULL DEFAULT 0,
  jour_inscription   INT         NOT NULL CHECK (jour_inscription BETWEEN 1 AND 31),
  mois_inscription   INT         NOT NULL CHECK (mois_inscription   BETWEEN 1 AND 12),
  annee_inscription  INT         NOT NULL
);

-- 3) Adresses des adhérents
CREATE TABLE Adresse (
  ID             INT         NOT NULL,
  numero_maison  VARCHAR(10) NOT NULL,
  rue            VARCHAR(100) NOT NULL,
  code_postal    VARCHAR(6)  NOT NULL,
  PRIMARY KEY (ID, numero_maison, rue),
  FOREIGN KEY (ID)          REFERENCES Adherant(ID)       ON DELETE CASCADE,
  FOREIGN KEY (code_postal) REFERENCES Code_postal(code_postal)
);

-- 4) Prénoms (multi‑valué)
CREATE TABLE Prenom (
  ID     INT         NOT NULL,
  prenom VARCHAR(50) NOT NULL,
  PRIMARY KEY (ID, prenom),
  FOREIGN KEY (ID) REFERENCES Adherant(ID) ON DELETE CASCADE
);

-- 5) Livres
CREATE TABLE Livre (
  ISBN   VARCHAR(13) PRIMARY KEY,
  titre  VARCHAR(200) NOT NULL,
  genre  VARCHAR(50),
  auteur VARCHAR(100) NOT NULL
);

-- 6) Auteurs (plusieurs par livre)
CREATE TABLE Auteur (
  ISBN       VARCHAR(13) NOT NULL,
  nom_auteur VARCHAR(100) NOT NULL,
  PRIMARY KEY (ISBN, nom_auteur),
  FOREIGN KEY (ISBN) REFERENCES Livre(ISBN) ON DELETE CASCADE
);

-- 7) Exemplaires
CREATE TABLE Exemplaire (
  id_exemplaire     VARCHAR(10) NOT NULL,
  ISBN              VARCHAR(13) NOT NULL,
  nombre_exemplaire INT         NOT NULL,
  PRIMARY KEY (id_exemplaire, ISBN),
  FOREIGN KEY (ISBN) REFERENCES Livre(ISBN) ON DELETE CASCADE
);

-- 8) Emprunts
CREATE TABLE Emprunt (
  id_emprunt    VARCHAR(10)  PRIMARY KEY,
  jour_debut    INT          NOT NULL CHECK (jour_debut    BETWEEN 1 AND 31),
  mois_debut    INT          NOT NULL CHECK (mois_debut    BETWEEN 1 AND 12),
  annee_debut   INT          NOT NULL,
  jour_retour   INT          CHECK (jour_retour   BETWEEN 1 AND 31),
  mois_retour   INT          CHECK (mois_retour   BETWEEN 1 AND 12),
  annee_retour  INT,
  ID            INT          NOT NULL,
  id_exemplaire VARCHAR(10)  NOT NULL,
  ISBN          VARCHAR(13)  NOT NULL,
  FOREIGN KEY (ID)            REFERENCES Adherant(ID),
  FOREIGN KEY (id_exemplaire, ISBN)
    REFERENCES Exemplaire(id_exemplaire, ISBN),
  -- pas de retour le même jour
  CHECK (
    (annee_retour * 10000 + mois_retour * 100 + jour_retour) 
    > 
    (annee_debut  * 10000 + mois_debut  * 100 + jour_debut)
  ),
  -- durée max 14 jours
  CHECK (
    ((annee_retour  - annee_debut) * 365
   + (mois_retour   - mois_debut) * 30 
   + (jour_retour   - jour_debut)) <= 14
  )
);

-- optimiser la jointure ID → Emprunt
CREATE INDEX idx_emprunt_id ON Emprunt(ID);

-- 9) Détails d’emprunt (n–à–n)
CREATE TABLE Detail_emprunt (
... (228lignes restantes)
Réduire
Script.sql
13 Ko
je n'arrive pas a push sur le git
Type de fichier joint : archive
bibliotheque-jpa.zip
23.21 KB
mais voici le tout
finalement j'ai pas change les tables car ca repondait vraiment aux requetes complexe qu'on peut faire
reste juste a faire la video et le rapport thecnique
Aïssatou — 02:01
j'ai envoyer les requetes en algebre et en sql avec l'optimisation
Je croix on est bon normalement
﻿
CREATE SCHEMA IF NOT EXISTS bibliotheque;
SET search_path TO bibliotheque;
-- 1) Code postal
CREATE TABLE Code_postal (
  code_postal  VARCHAR(6)  PRIMARY KEY,
  ville        VARCHAR(50) NOT NULL,
  pays         VARCHAR(50) NOT NULL
);

-- 2) Adhérents
CREATE TABLE Adherant (
  ID                 SERIAL      PRIMARY KEY,
  nom                VARCHAR(100) NOT NULL,
  prenom             VARCHAR(50),
  courriel           VARCHAR(100) NOT NULL UNIQUE,
  telephone          VARCHAR(15),
  nombre_emprunt     INT         NOT NULL DEFAULT 0,
  jour_inscription   INT         NOT NULL CHECK (jour_inscription BETWEEN 1 AND 31),
  mois_inscription   INT         NOT NULL CHECK (mois_inscription   BETWEEN 1 AND 12),
  annee_inscription  INT         NOT NULL
);

-- 3) Adresses des adhérents
CREATE TABLE Adresse (
  ID             INT         NOT NULL,
  numero_maison  VARCHAR(10) NOT NULL,
  rue            VARCHAR(100) NOT NULL,
  code_postal    VARCHAR(6)  NOT NULL,
  PRIMARY KEY (ID, numero_maison, rue),
  FOREIGN KEY (ID)          REFERENCES Adherant(ID)       ON DELETE CASCADE,
  FOREIGN KEY (code_postal) REFERENCES Code_postal(code_postal)
);

-- 4) Prénoms (multi‑valué)
CREATE TABLE Prenom (
  ID     INT         NOT NULL,
  prenom VARCHAR(50) NOT NULL,
  PRIMARY KEY (ID, prenom),
  FOREIGN KEY (ID) REFERENCES Adherant(ID) ON DELETE CASCADE
);

-- 5) Livres
CREATE TABLE Livre (
  ISBN   VARCHAR(13) PRIMARY KEY,
  titre  VARCHAR(200) NOT NULL,
  genre  VARCHAR(50),
  auteur VARCHAR(100) NOT NULL
);

-- 6) Auteurs (plusieurs par livre)
CREATE TABLE Auteur (
  ISBN       VARCHAR(13) NOT NULL,
  nom_auteur VARCHAR(100) NOT NULL,
  PRIMARY KEY (ISBN, nom_auteur),
  FOREIGN KEY (ISBN) REFERENCES Livre(ISBN) ON DELETE CASCADE
);

-- 7) Exemplaires
CREATE TABLE Exemplaire (
  id_exemplaire     VARCHAR(10) NOT NULL,
  ISBN              VARCHAR(13) NOT NULL,
  nombre_exemplaire INT         NOT NULL,
  PRIMARY KEY (id_exemplaire, ISBN),
  FOREIGN KEY (ISBN) REFERENCES Livre(ISBN) ON DELETE CASCADE
);

-- 8) Emprunts
CREATE TABLE Emprunt (
  id_emprunt    VARCHAR(10)  PRIMARY KEY,
  jour_debut    INT          NOT NULL CHECK (jour_debut    BETWEEN 1 AND 31),
  mois_debut    INT          NOT NULL CHECK (mois_debut    BETWEEN 1 AND 12),
  annee_debut   INT          NOT NULL,
  jour_retour   INT          CHECK (jour_retour   BETWEEN 1 AND 31),
  mois_retour   INT          CHECK (mois_retour   BETWEEN 1 AND 12),
  annee_retour  INT,
  ID            INT          NOT NULL,
  id_exemplaire VARCHAR(10)  NOT NULL,
  ISBN          VARCHAR(13)  NOT NULL,
  FOREIGN KEY (ID)            REFERENCES Adherant(ID),
  FOREIGN KEY (id_exemplaire, ISBN)
    REFERENCES Exemplaire(id_exemplaire, ISBN),
  -- pas de retour le même jour
  CHECK (
    (annee_retour * 10000 + mois_retour * 100 + jour_retour) 
    > 
    (annee_debut  * 10000 + mois_debut  * 100 + jour_debut)
  ),
  -- durée max 14 jours
  CHECK (
    ((annee_retour  - annee_debut) * 365
   + (mois_retour   - mois_debut) * 30 
   + (jour_retour   - jour_debut)) <= 14
  )
);

-- optimiser la jointure ID → Emprunt
CREATE INDEX idx_emprunt_id ON Emprunt(ID);

-- 9) Détails d’emprunt (n–à–n)
CREATE TABLE Detail_emprunt (
  ID             INT         NOT NULL,
  id_exemplaire  VARCHAR(10) NOT NULL,
  ISBN           VARCHAR(13) NOT NULL,
  id_emprunt     VARCHAR(10) NOT NULL,
  PRIMARY KEY (ID, id_exemplaire, ISBN, id_emprunt),
  FOREIGN KEY (ID)                   REFERENCES Adherant(ID)    ON DELETE CASCADE,
  FOREIGN KEY (id_exemplaire, ISBN)  REFERENCES Exemplaire(id_exemplaire, ISBN),
  FOREIGN KEY (id_emprunt)            REFERENCES Emprunt(id_emprunt)
);

-- 10) Commandes
CREATE TABLE Commande (
  numero_commande VARCHAR(10) PRIMARY KEY,
  Etat            VARCHAR(20) NOT NULL,
  jour_commandee  INT         NOT NULL CHECK (jour_commandee BETWEEN 1 AND 31),
  mois_commandee  INT         NOT NULL CHECK (mois_commandee BETWEEN 1 AND 12),
  annee_commandee INT         NOT NULL,
  ID              INT         NOT NULL,
  id_exemplaire   VARCHAR(10) NOT NULL,
  ISBN            VARCHAR(13) NOT NULL,
  FOREIGN KEY (ID)            REFERENCES Adherant(ID),
  FOREIGN KEY (id_exemplaire, ISBN)
    REFERENCES Exemplaire(id_exemplaire, ISBN)
);

-- 11) Détails de commande (n–à–n)
CREATE TABLE Detail_commande (
  ID               INT         NOT NULL,
  id_exemplaire    VARCHAR(10) NOT NULL,
  ISBN             VARCHAR(13) NOT NULL,
  numero_commande  VARCHAR(10) NOT NULL,
  PRIMARY KEY (ID, id_exemplaire, ISBN, numero_commande),
  FOREIGN KEY (ID)               REFERENCES Adherant(ID)    ON DELETE CASCADE,
  FOREIGN KEY (id_exemplaire, ISBN)
    REFERENCES Exemplaire(id_exemplaire, ISBN),
  FOREIGN KEY (numero_commande)
    REFERENCES Commande(numero_commande)
);




-- 3) Peuplement des tables avec au moins 10 tuples chacune

-- 3.1 Code_postal (12 enregistrements)
INSERT INTO Code_postal (code_postal, ville, pays) VALUES
  ('H2X1Y4','Montréal','Canada'),
  ('H3Z2A2','Québec','Canada'),
  ('H7K3G3','Laval','Canada'),
  ('H2X3L1','Montréal','Canada'),
  ('J7Y4G7','Terrebonne','Canada'),
  ('G1R5M3','Gatineau','Canada'),
  ('A1A1A1','St. John''s','Canada'),
  ('B2B2B2','Halifax','Canada'),
  ('C3C3C3','Toronto','Canada'),
  ('D4D4D4','Vancouver','Canada'),
  ('E5E5E5','Calgary','Canada'),
  ('F6F6F6','Edmonton','Canada');

-- 3.2 Adherant (11 enregistrements)
INSERT INTO Adherant (ID, nom, prenom, courriel, telephone, nombre_emprunt, jour_inscription, mois_inscription, annee_inscription) VALUES
  (1, 'Dupont', 'Jean',    'jean.dup@example.com',     '514123456', 2,  1,  1, 2020),
  (2, 'Martin', 'Sophie',  'sophie.mar@example.com',  '438987654', 1, 15,  2, 2021),
  (3, 'Coll',   'Nar',     'nar.coll@example.ca',     '438555999', 3, 20,  3, 2022),
  (4, 'Nguyen', 'Julie',   'julie.ngu@example.ca',    '514999888', 0, 10,  4, 2023),
  (5, 'Smith',  'Will',    'will.smit@example.ca',    '450101202', 1,  5,  5, 2024),
  (6, 'Olsson', 'Anna',    'anna.ol@example.com',     '514111222', 0, 12,  6, 2024),
  (7, 'Khan',   'Ali',     'ali.khan@example.com',    '514333444', 2, 23,  7, 2023),
  (8, 'Zhang',  'Li',      'li.zhang@example.cn',     '514555666', 1, 30,  8, 2022),
  (9, 'Garcia', 'Maria',   'maria.garcia@example.mx', '514777888', 4,  8,  9, 2021),
  (10,'Lee',    'Min',     'min.lee@example.kr',      '514999000', 0, 17, 10, 2020),
  (11,'Ng',     'Siti',    'siti.ng@example.my',      '514222333', 1, 25, 11, 2024);

-- 3.3 Adresse (11 enregistrements)
INSERT INTO Adresse (ID, numero_maison, rue, code_postal) VALUES
  (1,'123','Rue Principale','H2X1Y4'),
  (2,'456','Boulevard Centre','H3Z2A2'),
  (3,'789','Avenue Royale','H7K3G3'),
  (4,'22','Rue St‑Denis','H2X3L1'),
  (5,'999','Chemin Royal','J7Y4G7'),
  (6,'11','Rue du Lac','G1R5M3'),
  (7,'77','Rue Wellington','A1A1A1'),
  (8,'88','Rue Bedford','B2B2B2'),
  (9,'55','Rue King','C3C3C3'),
  (10,'33','Rue Granville','D4D4D4'),
  (11,'44','Rue Centre','E5E5E5');

-- 3.4 Prenom (12 enregistrements)
INSERT INTO Prenom (ID, prenom) VALUES
  (1,'Jean'),   (1,'Pierre'),
  (2,'Sophie'), (2,'Marie'),
  (3,'Nar'),
  (4,'Julie'),  (4,'Fatou'),
  (5,'Will'),
  (6,'Anna'),
  (7,'Ali'),    (7,'Hassan'),
  (8,'Li'),
  (9,'Maria'),
  (10,'Min'),
  (11,'Siti');

-- 3.5 Livre (11 enregistrements)
INSERT INTO Livre (ISBN, titre, genre, auteur) VALUES
  ('9780000000001','Le Petit Prince','Conte','Antoine de Saint‑Exupéry'),
  ('9780000000002','Dune','Science‑Fiction','Frank Herbert'),
  ('9780000000003','1984','Dystopie','George Orwell'),
  ('9780000000004','L''Ombre du vent','Roman','Carlos Ruiz Zafón'),
  ('9780000000005','Fondation','Science‑Fiction','Isaac Asimov'),
  ('9780000000006','Harry Potter à l''école des sorciers','Fantasy','J.K. Rowling'),
  ('9780000000007','Le Meilleur des mondes','Dystopie','Aldous Huxley'),
  ('9780000000008','Le Comte de Monte‑Cristo','Aventure','Alexandre Dumas'),
  ('9780000000009','La Peste','Roman','Albert Camus'),
  ('9780000000010','Crime et Châtiment','Roman','Fiodor Dostoïevski'),
  ('9780000000011','Germinal','Roman','Émile Zola');

-- 3.6 Auteur (12 enregistrements, un co‑auteur pour ISBN 6)
INSERT INTO Auteur (ISBN, nom_auteur) VALUES
  ('9780000000001','Antoine de Saint‑Exupéry'),
  ('9780000000002','Frank Herbert'),
  ('9780000000003','George Orwell'),
  ('9780000000004','Carlos Ruiz Zafón'),
  ('9780000000005','Isaac Asimov'),
  ('9780000000006','J.K. Rowling'),
  ('9780000000006','John Tiffany'),
  ('9780000000007','Aldous Huxley'),
  ('9780000000008','Alexandre Dumas'),
  ('9780000000009','Albert Camus'),
  ('9780000000010','Fiodor Dostoïevski'),
  ('9780000000011','Émile Zola');

-- 3.7 Exemplaire (11 enregistrements)
INSERT INTO Exemplaire (id_exemplaire, ISBN, nombre_exemplaire) VALUES
 ('EX1','9780000000001',3),
  ('EX2','9780000000002',2),
  ('EX3','9780000000003',4),
  ('EX4','9780000000004',1),
  ('EX5','9780000000005',5),
  ('EX6','9780000000006',6),
  ('EX7','9780000000007',2),
  ('EX8','9780000000008',3),
  ('EX9','9780000000009',2),
  ('EX10','9780000000010',1),
  ('EX11','9780000000011',2);
-- 3.8 Emprunt (11 enregistrements)
SET search_path TO bibliotheque;

INSERT INTO Emprunt (id_emprunt, jour_debut, mois_debut, annee_debut,
                     jour_retour, mois_retour, annee_retour, ID, id_exemplaire, ISBN) VALUES
   ('EMP1',  1,  4, 2025,  8,  4, 2025, 1,'EX1','9780000000001'),
  ('EMP2', 10,  3, 2025, 20,  3, 2025, 2,'EX2','9780000000002'),
  ('EMP3',  5,  2, 2025, 19,  2, 2025, 3,'EX3','9780000000003'),
  ('EMP4', 20,  1, 2025,  3,  2, 2025, 4,'EX4','9780000000004'),
  ('EMP5', 15, 12, 2024, 27, 12, 2024, 5,'EX5','9780000000005'),
  ('EMP6', 15, 11, 2024, 27, 11, 2024, 6,'EX6','9780000000006'),
  ('EMP7',  2, 10, 2024, 16, 10, 2024, 7,'EX7','9780000000007'),
  ('EMP8', 12,  9, 2024, 26,  9, 2024, 8,'EX8','9780000000008'),
  ('EMP9', 30,  8, 2024, 11,  9, 2024, 9,'EX9','9780000000009'),
  ('EMP10',18,  7, 2024,  1,  8, 2024,10,'EX10','9780000000010');


-- 3.9 Detail_emprunt (11 enregistrements)
INSERT INTO Detail_emprunt (ID, id_exemplaire, ISBN, id_emprunt) VALUES
  (1,'EX1','9780000000001','EMP1'),
  (2,'EX2','9780000000002','EMP2'),
  (3,'EX3','9780000000003','EMP3'),
  (4,'EX4','9780000000004','EMP4'),
  (5,'EX5','9780000000005','EMP5'),
  (6,'EX6','9780000000006','EMP6'),
  (7,'EX7','9780000000007','EMP7'),
  (8,'EX8','9780000000008','EMP8'),
  (9,'EX9','9780000000009','EMP9'),
  (10,'EX10','9780000000010','EMP10');

-- 3.10 Commande (11 enregistrements)
INSERT INTO Commande (numero_commande, Etat, jour_commandee, mois_commandee, annee_commandee, ID, id_exemplaire, ISBN) VALUES
  ('CMD01','en_attente',  2,  5, 2025, 1,'EX1','9780000000001'),
  ('CMD02','honoree',    12,  3, 2025, 2,'EX2','9780000000002'),
  ('CMD03','annulee',     6,  2, 2025, 3,'EX3','9780000000003'),
  ('CMD04','en_attente', 21,  1, 2025, 4,'EX4','9780000000004'),
  ('CMD05','honoree',     8, 12, 2024, 5,'EX5','9780000000005'),
  ('CMD06','annulee',    11, 11, 2024, 6,'EX6','9780000000006'),
  ('CMD07','en_attente', 26, 10, 2024, 7,'EX7','9780000000007'),
  ('CMD08','honoree',     4,  9, 2024, 8,'EX8','9780000000008'),
  ('CMD09','annulee',    13,  8, 2024, 9,'EX9','9780000000009'),
  ('CMD10','en_attente', 31,  7, 2024,10,'EX10','9780000000010');

-- 3.11 Detail_commande (11 enregistrements)
INSERT INTO Detail_commande (ID, id_exemplaire, ISBN, numero_commande) VALUES
  (1,'EX1','9780000000001','CMD01'),
  (2,'EX2','9780000000002','CMD02'),
  (3,'EX3','9780000000003','CMD03'),
  (4,'EX4','9780000000004','CMD04'),
  (5,'EX5','9780000000005','CMD05'),
  (6,'EX6','9780000000006','CMD06'),
  (7,'EX7','9780000000007','CMD07'),
  (8,'EX8','9780000000008','CMD08'),
  (9,'EX9','9780000000009','CMD09'),
  (10,'EX10','9780000000010','CMD10');



SELECT
  a.nom,
  COUNT(e.id_emprunt) AS total_emprunts,
  SUM(
    CASE 
      WHEN make_date(e.annee_retour, e.mois_retour, e.jour_retour) > make_date(e.annee_debut, e.mois_debut, e.jour_debut) + INTERVAL '14 days'
      THEN 1
      ELSE 0
    END
  ) AS retards
FROM bibliotheque.Adherant a
JOIN bibliotheque.Emprunt e ON a.ID = e.ID
GROUP BY a.nom;

SELECT * FROM bibliotheque.Exemplaire WHERE id_exemplaire = 'EX1' AND isbn = '9780000000008';


