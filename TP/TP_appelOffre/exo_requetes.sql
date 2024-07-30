CREATE DATABASE IF NOT EXISTS appel_offre;
    
USE appel_offre;

-- Création des tables 
CREATE TABLE Produit (
    num_produit INT PRIMARY KEY,
    nom_produit VARCHAR(100) NOT NULL,
    prix_unitaire DECIMAL(10, 2) DEFAULT NULL
);

CREATE TABLE Offre (
    num_offre INT PRIMARY KEY,
    date_offre DATE NOT NULL,
    date_cloture DATE NOT NULL,
    quantite_produit INT NOT NULL,
    num_produit INT,
    FOREIGN KEY (num_produit) REFERENCES Produit(num_produit)
);

CREATE TABLE Fournisseur (
    num_fournisseur INT PRIMARY KEY,
    nom_fournisseur VARCHAR(100) NOT NULL,
    adresse VARCHAR(255) NOT NULL,
    cp VARCHAR(10) NOT NULL,
    ville VARCHAR(100) NOT NULL
);

CREATE TABLE Contrat (
    num_contrat INT PRIMARY KEY,
    date_contrat DATE NOT NULL,
    quantite_negociee INT NOT NULL,
    signature_acceptation BOOLEAN,
    num_produit INT,
    FOREIGN KEY (num_produit) REFERENCES Produit(num_produit)
);

CREATE TABLE Contracter (
    num_contrat INT,
    num_fournisseur INT,
    PRIMARY KEY (num_contrat, num_fournisseur),
    FOREIGN KEY (num_contrat) REFERENCES Contrat(num_contrat),
    FOREIGN KEY (num_fournisseur) REFERENCES Fournisseur(num_fournisseur)
);

-- Insertion
INSERT INTO Produit (num_produit, nom_produit, prix_unitaire) VALUES
(1, 'Produit A', 10.50),
(2, 'Produit B', 15.75);

INSERT INTO Offre (num_offre, date_offre, date_cloture, quantite_produit, num_produit) VALUES
(1, '2024-01-01', '2024-01-31', 100, 1),
(2, '2024-02-01', '2024-02-28', 200, 2);

INSERT INTO Fournisseur (num_fournisseur, nom_fournisseur, adresse, cp, ville) VALUES
(1, 'Fournisseur X', '123 Rue A', '75001', 'Paris'),
(2, 'Fournisseur Y', '456 Rue B', '69002', 'Lyon');

INSERT INTO Contrat (num_contrat, date_contrat, quantite_negociee, signature_acceptation, num_produit) VALUES
(1, '2024-03-01', 100, TRUE, 1),
(2, '2024-04-01', 200, TRUE, 2);

INSERT INTO Contracter (num_contrat, num_fournisseur) VALUES
(1, 1),
(2, 2);



-- Affichage des données
SELECT * FROM contrat;
SELECT * FROM Produit;
SELECT * FROM offre;
SELECT * FROM fournisseur;
SELECT * FROM contracter;

-- 1 - Sélectionner tous les produits avec leur prix.
SELECT nom_produit, prix_unitaire FROM produit;


-- 2 - Trouver le nombre total d'offres disponibles.
SELECT COUNT(*) AS nombre_total_offres
FROM offre;


-- 3 - Lister tous les fournisseurs situés à Paris.
SELECT * FROM fournisseur WHERE ville = 'Paris';


-- 4 - Afficher les offres et la quantité totale de produits demandés pour chaque offre.
SELECT offre.num_offre, SUM(offre.quantite_produit) AS nombre_total_produits
FROM offre
GROUP BY offre.num_offre;


-- 5 - Trouver les produits qui n'ont pas encore été inclus dans un contrat.
SELECT DISTINCT nom_produit, prix_unitaire
FROM produit
WHERE NOT EXISTS (SELECT * FROM contrat
					WHERE produit.num_produit = contrat.num_produit);


-- 6 - Afficher les contrats signés par chaque fournisseur avec la date de signature.
SELECT
    f.num_fournisseur,
    f.nom_fournisseur,
    c.num_contrat,
    c.date_contrat
FROM
    fournisseur f
JOIN contracter ct ON f.num_fournisseur = ct.num_fournisseur
JOIN contrat c ON ct.num_contrat = c.num_contrat;


-- 7 - Lister les offres avec les noms des produits correspondants.
SELECT num_offre, nom_produit
FROM produit
JOIN offre ON offre.num_produit = produit.num_produit;


-- 8 - Trouver le fournisseur qui a effectué le plus d'offres.
SELECT
    f.num_fournisseur,
    f.nom_fournisseur,
    COUNT(*) AS nombre_offres
FROM fournisseur f
JOIN offre_fournisseur off ON f.num_fournisseur = off.num_fournisseur
GROUP BY f.num_fournisseur, f.nom_fournisseur
ORDER BY nombre_offres DESC;

-- 9 - Calculer le montant total des contrats par produit.
SELECT nom_produit, SUM(quantite_produit * prix_unitaire) AS montant_total_contrat
FROM contrat
JOIN produit ON produit.num_produit = contrat.num_produit
GROUP BY produit.nom_produit;


-- 10 - Trouver les offres qui n'ont pas été signées avant leur date de clôture et les fournisseurs responsables.

    





