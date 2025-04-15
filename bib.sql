
drop schema if exists bib cascade;
create schema bib;
set search_path to bib;

-- Creation des tables

-- ====================================================
-- [1] Table Adherent 
-- ====================================================
-- Représente les adhérents de la bibliothèque.

CREATE TABLE IF NOT EXISTS Adherent (
	id_ad 			   INT primary key,
	nom 			   VARCHAR(20),
	email 			   VARCHAR(100),
	tel				   CHAR(9),
    num	               VARCHAR(10),
    rue                VARCHAR(100),
    cp                 VARCHAR(10),       -- code postal
    ville              VARCHAR(50),
    pays 			   VARCHAR(50)

);



-- ====================================================
-- [2] Table Prenom
-- ====================================================
-- Comme "prenom" est multi-valué, on le stocke dans une table à part
-- en reliant chaque prénom à l’ID de l’adhérent.

CREATE TABLE IF NOT EXISTS Prenom (
	id_ad 	INT not null,
	prenom 	VARCHAR(50),
	
    -- Clé primaire composée (1 adhérent peut avoir plusieurs prénoms)
    constraint prnm primary key (id_ad, prenom),
    
    -- Clé étrangère vers Adherent
    CONSTRAINT fk_adherent
    	foreign KEY (id_ad)
    	references Adherent(id_ad)
    	on delete cascade
    	on update cascade 
);

-- ====================================================
-- [0] Table Livre (minimal : juste ISBN)
-- J'AI FAIS LA TABLE PARCE QU J'EN VAIS BESOIN POUR EXEMPLAIRES
-- ====================================================
CREATE TABLE IF NOT EXISTS Livre (
    ISBN 	VARCHAR(13) PRIMARY key,
    titre  	VARCHAR(100),
    genre  	VARCHAR(50),
    auteur  VARCHAR(100)  -- ICI JE N'AI PAS GERER LE CAS OU ON A PLUSIEURS AUTEURS
);

    

-- ====================================================
-- [3] Table Exemplaire
-- ====================================================
-- Représente les exemplaires de livres

CREATE TABLE IF NOT EXISTS Exemplaire (
	id_exemp 		VARCHAR(13) primary key,
	isbn 			VARCHAR(13),
	nb_exemplaires 	INT not null,
	
	-- Clé étrangère vers la table des livres
	constraint fk_livre
		foreign key (isbn)
		references Livre(ISBN)
		on delete cascade
		on update cascade 
	
);

	
-- ====================================================
--  Insertions de données
-- ====================================================
--Adherent
INSERT INTO Adherent
values
	 (1,'Dupont', 'jean.dup@example.com', '514123456', '123', 'Rue Principale', 'H2X1Y4', 'Montréal', 'Canada'),
	 (2,'Martin', 'sophie.mar@example.com', '438987654', '456', 'Boulevard Centre', 'H3Z2A2', 'Québec', 'Canada'),
	 (3,'Coll',    'naro.con@example.com', '438555999', '789', 'Avenue Royale', 'H7K3G3', 'Laval', 'Canada'),
	 (4,'Nguyen', 'julie.ngu@example',  '514999888', '22',  'Rue St-Denis',    'H2X3L1', 'Montréal', 'Canada'),
	 (5,'Smith',  'will.smit@example',  '450101202', '999', 'Chemin Royal',    'J7Y4G7', 'Terrebonne','Canada');


--Prenoms
INSERT INTO Prenom
VALUES
	(1, 'Jean'),
	(2, 'Sophie'),
	(2, 'Marie'),
	(2, 'Elodie'),
	(3, 'Nar'),
	(4, 'Julie'),
	(4, 'Fatou'),
	(4, 'James'),
	(5, 'Will');

--Livres
INSERT INTO Livre
values
	('9781234567897', 'Le Petit Prince',     'Conte',         'Antoine de Saint-Exupéry'),
	('9789876543210', 'L’Ombre du vent',     'Roman',         'Carlos Ruiz Zafón'),
	('9789999999999', 'Introduction à SQL',  'Informatique',  'John Doe'),
	('9783456789012', 'Dune',                'Science-Fiction','Frank Herbert'),
	('9787654321098', '1984',                'Dystopie',      'George Orwell');

--Exemplaires
INSERT INTO Exemplaire
VALUES
	('1','9781234567897', 3),
	('2','9789876543210', 2),
	('3','9789999999999', 2),
	('4','9783456789012', 3),
	('5','9787654321098', 1);









	

