begin transaction;

drop schema if exists bib cascade;
create schema bib;
set search_path to bib;

CREATE DOMAIN email_dom AS TEXT
CHECK (
  VALUE ~ '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'
);


-- Creation des tables

-- ====================================================
-- [1] Table Adherent 
-- ====================================================
-- Représente les adhérents de la bibliothèque.

CREATE TABLE IF NOT EXISTS Adherent (
	id_ad 			   INT primary key,
	nom 			   VARCHAR(20),
	email 			   email_dom,
	tel				   CHAR(9),
    num	               VARCHAR(4),
    rue                VARCHAR(100),
    cp                 VARCHAR(6),       -- code postal
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
	id_exemp 		VARCHAR(13),
	isbn 			VARCHAR(13),
	nb_exemplaires 	INT not null,
	
	primary key (id_exemp,isbn),
	
	-- Clé étrangère vers la table des livres
	constraint fk_livre
		foreign key (isbn)
		references Livre(ISBN)
		on delete cascade
		on update cascade 
	
);

create table if not exists details_emprunt (

	id_emprunt text not null,
	id_ad INT not null,
	id_exemp varchar(13),
	isbn varchar(13),
	primary key (id_ad,id_exemp,isbn),
	
	constraint fk_id_ad
    foreign KEY (id_ad)
   		references Adherent(id_ad)
    	on delete cascade
   		on update cascade,
	
	constraint fk_id_exp
	foreign KEY (id_exemp,isbn)
		references Exemplaire(id_exemp, isbn)
	   	on delete cascade
	   	on update cascade
);

create table if not exists details_commande (

	id_commande text not null,
	id_ad INT not null,
	id_exemp varchar(13),
	isbn varchar(13),
	primary key (id_ad,id_exemp,isbn),
	
	constraint fk_id_ad
    foreign KEY (id_ad)
   		references Adherent(id_ad)
    	on delete cascade
   		on update cascade,
	
	constraint fk_id_exp
	foreign KEY (id_exemp,isbn)
		references Exemplaire(id_exemp, isbn)
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
	 (3,'Coll',    'naro.con@example.ca', '438555999', '789', 'Avenue Royale', 'H7K3G3', 'Laval', 'Canada'),
	 (4,'Nguyen', 'julie.ngu@example.ca',  '514999888', '22',  'Rue St-Denis',    'H2X3L1', 'Montréal', 'Canada'),
	 (5,'Smith',  'will.smit@example.ca',  '450101202', '999', 'Chemin Royal',    'J7Y4G7', 'Terrebonne','Canada');


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

INSERT INTO details_emprunt
VALUES
    ('E001', 1, '1', '9781234567897'),
    ('E002', 2, '2', '9789876543210'),
    ('E003', 3, '3', '9789999999999'),
    ('E004', 4, '4', '9783456789012'),
    ('E005', 5, '5', '9787654321098'),
    ('E006', 2, '1', '9781234567897'),  -- Same exemplaire borrowed by another adherent
    ('E007', 1, '2', '9789876543210');  

INSERT INTO details_commande
VALUES
    ('C001', 1, '1', '9781234567897'),  -- Dupont orders Le Petit Prince
    ('C002', 2, '2', '9789876543210'),  -- Martin orders L’Ombre du vent
    ('C003', 3, '4', '9783456789012'),  -- Coll orders Dune
    ('C004', 4, '3', '9789999999999'),  -- Nguyen orders Introduction à SQL
    ('C005', 5, '5', '9787654321098'),  -- Smith orders 1984
    ('C006', 1, '2', '9789876543210'),  -- Dupont orders another book
    ('C007', 2, '1', '9781234567897');  -- Martin orders Le Petit Prince

commit;
	
