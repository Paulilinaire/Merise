CREATE DATABASE bdd_appel_offre;
-- DROP DATABASE bdd_appel_offre;
USE bdd_appel_offre;


CREATE TABLE Produit(
   num_produit INT,
   nom_produit VARCHAR(50),
   prix_unitaire DECIMAL(15,2),
   PRIMARY KEY(num_produit)
);

CREATE TABLE offre(
   num_offre INT,
   date_offre DATE,
   date_cloture DATE,
   quantite_produit INT,
   num_produit INT NOT NULL,
   PRIMARY KEY(num_offre),
   FOREIGN KEY(num_produit) REFERENCES Produit(num_produit)
);

CREATE TABLE fournisseur(
   num_fournisseur INT,
   nom_fournisseur VARCHAR(100),
   adresse VARCHAR(100),
   code_postal VARCHAR(5),
   ville VARCHAR(50),
   PRIMARY KEY(num_fournisseur)
);

CREATE TABLE contrat(
   num_contrat INT,
   date_contrat DATE,
   quantite_produit INT,
   signature VARCHAR(50),
   num_produit INT NOT NULL,
   PRIMARY KEY(num_contrat),
   UNIQUE(num_produit),
   FOREIGN KEY(num_produit) REFERENCES Produit(num_produit)
);

CREATE TABLE offre_fournisseur(
   num_offre INT,
   num_fournisseur INT,
   PRIMARY KEY(num_offre, num_fournisseur),
   FOREIGN KEY(num_offre) REFERENCES offre(num_offre),
   FOREIGN KEY(num_fournisseur) REFERENCES fournisseur(num_fournisseur)
);

CREATE TABLE contracter(
   num_fournisseur INT,
   num_contrat INT,
   PRIMARY KEY(num_fournisseur, num_contrat),
   FOREIGN KEY(num_fournisseur) REFERENCES fournisseur(num_fournisseur),
   FOREIGN KEY(num_contrat) REFERENCES contrat(num_contrat)
);


-- INSERT statements for the 'Produit' table
INSERT INTO Produit VALUES (101, 'Ordinateur Portable', 899.99);
INSERT INTO Produit VALUES (102, 'Smartphone', 599.99);
INSERT INTO Produit VALUES (103, 'Imprimante', 129.99);
INSERT INTO Produit VALUES (104, 'Tablette', 349.99);
INSERT INTO Produit VALUES (105, 'Écran PC', 299.99);
INSERT INTO Produit VALUES (106, 'Clavier sans fil', 49.99);


-- INSERT statements for the 'offre' table
INSERT INTO offre VALUES (201, '2024-01-10', '2024-01-20', 50, 101);
INSERT INTO offre VALUES (202, '2024-02-20', '2024-02-28', 75, 102);
INSERT INTO offre VALUES (203, '2024-03-25', '2024-04-05', 100, 103);
INSERT INTO offre VALUES (204, '2024-04-15', '2024-04-25', 60, 104);
INSERT INTO offre VALUES (205, '2024-05-01', '2024-05-10', 40, 105);

-- INSERT statements for the 'fournisseur' table
INSERT INTO fournisseur VALUES (301, 'TechMart Inc.', '123 Rue de la Technologie', '75001', 'Paris');
INSERT INTO fournisseur VALUES (302, 'GadgetCo Ltd.', '456 Avenue des Gadgets', '75002', 'Paris');
INSERT INTO fournisseur VALUES (303, 'FournituresBureau SA', '789 Rue du Bureau', '69003', 'Lyon');
INSERT INTO fournisseur VALUES (304, 'MondeÉlectronique GmbH', '321 Rue Électronique', '13004', 'Marseille');
INSERT INTO fournisseur VALUES (305, 'AccessoiresTech SAS', '555 Boulevard des Accessoires', '33005', 'Bordeaux');

-- INSERT statements for the 'contrat' table
INSERT INTO contrat VALUES (401, '2024-01-01', 100, 'Signature A', 101);
INSERT INTO contrat VALUES (402, '2024-02-15', 150, 'Signature B', 102);
INSERT INTO contrat VALUES (403, '2024-03-20', 200, 'Signature C', 103);
INSERT INTO contrat VALUES (404, '2024-04-10', 120, 'Signature D', 104);
INSERT INTO contrat VALUES (405, '2024-05-05', 80, 'Signature E', 105);
INSERT INTO contrat VALUES (501, '2024-06-01', 150, 'Signature F', 101);


-- INSERT statements for the 'offre_fournisseur' table
INSERT INTO offre_fournisseur VALUES (201, 301);
INSERT INTO offre_fournisseur VALUES (202, 302);
INSERT INTO offre_fournisseur VALUES (203, 303);
INSERT INTO offre_fournisseur VALUES (204, 304);
INSERT INTO offre_fournisseur VALUES (205, 305);

-- INSERT statements for the 'contracter' table
INSERT INTO contracter VALUES (301, 401);
INSERT INTO contracter VALUES (302, 402);
INSERT INTO contracter VALUES (303, 403);
INSERT INTO contracter VALUES (304, 404);
INSERT INTO contracter VALUES (305, 405);



