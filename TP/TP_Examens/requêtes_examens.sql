CREATE DATABASE IF NOT EXISTS examens;
    
USE examens;

-- Création des tables

CREATE TABLE Etablissement (
    code_etablissement INT PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    adresse VARCHAR(100),
    ville VARCHAR(50)
);

CREATE TABLE Eleve (
    code_eleve INT PRIMARY KEY,
    nom VARCHAR(50) NOT NULL,
    prenom VARCHAR(50) NOT NULL,
    date_naissance DATE,
    code_etablissement INT,
    FOREIGN KEY (code_etablissement) REFERENCES Etablissement(code_etablissement)
);

CREATE TABLE Examen (
    id_examen INT PRIMARY KEY,
    nom VARCHAR(50) NOT NULL
);

CREATE TABLE Epreuve (
    id_epreuve INT PRIMARY KEY,
    nom VARCHAR(50) NOT NULL,
    coefficient INT,
    date_epreuve DATE
);

CREATE TABLE Enseignant (
    matricule_enseignant INT PRIMARY KEY,
    nom VARCHAR(50) NOT NULL,
    telephone VARCHAR(20),
    adresse VARCHAR(100),
    ville VARCHAR(50),
    code_etablissement INT,
    FOREIGN KEY (code_etablissement) REFERENCES Etablissement(code_etablissement)
);

CREATE TABLE Inscription (
    numero_inscription INT PRIMARY KEY,
    code_eleve INT,
    id_examen INT,
    date_inscription DATE,
    FOREIGN KEY (code_eleve) REFERENCES Eleve(code_eleve),
    FOREIGN KEY (id_examen) REFERENCES Examen(id_examen)
);

CREATE TABLE Redaction (
    matricule_enseignant INT,
    id_epreuve INT,
    date_redaction DATE,
    PRIMARY KEY (matricule_enseignant, id_epreuve),
    FOREIGN KEY (matricule_enseignant) REFERENCES Enseignant(matricule_enseignant),
    FOREIGN KEY (id_epreuve) REFERENCES Epreuve(id_epreuve)
);

CREATE TABLE Correction (
    matricule_enseignant INT,
    id_epreuve INT,
    date_correction DATE,
    PRIMARY KEY (matricule_enseignant, id_epreuve),
    FOREIGN KEY (matricule_enseignant) REFERENCES Enseignant(matricule_enseignant),
    FOREIGN KEY (id_epreuve) REFERENCES Epreuve(id_epreuve)
);

CREATE TABLE Note (
    code_eleve INT,
    id_epreuve INT,
    note FLOAT,
    PRIMARY KEY (code_eleve, id_epreuve),
    FOREIGN KEY (code_eleve) REFERENCES Eleve(code_eleve),
    FOREIGN KEY (id_epreuve) REFERENCES Epreuve(id_epreuve)
);

-- Insertion de données d'exemple

INSERT INTO Etablissement (code_etablissement, nom, adresse, ville) VALUES
(1, 'Lycée A', '123 Rue A', 'Paris'),
(2, 'Lycée B', '456 Rue B', 'Lyon');

INSERT INTO Eleve (code_eleve, nom, prenom, date_naissance, code_etablissement) VALUES
(1, 'Durand', 'Jean', '2005-05-15', 1),
(2, 'Martin', 'Sophie', '2006-06-20', 2);

INSERT INTO Examen (id_examen, nom) VALUES
(1, 'Baccalauréat');

INSERT INTO Epreuve (id_epreuve, nom, coefficient, date_epreuve) VALUES
(1, 'Mathématiques', 4, '2024-06-01'),
(2, 'Physique', 3, '2024-06-02');

INSERT INTO Enseignant (matricule_enseignant, nom, telephone, adresse, ville, code_etablissement) VALUES
(1, 'Lemoine', '0102030405', '789 Rue C', 'Paris', 1),
(2, 'Dupont', '0607080910', '101 Rue D', 'Lyon', 2);

INSERT INTO Inscription (numero_inscription, code_eleve, id_examen, date_inscription) VALUES
(1, 1, 1, '2023-12-01'),
(2, 2, 1, '2023-12-02');

INSERT INTO Redaction (matricule_enseignant, id_epreuve, date_redaction) VALUES
(1, 1, '2024-04-01'),
(2, 2, '2024-04-02');

INSERT INTO Correction (matricule_enseignant, id_epreuve, date_correction) VALUES
(1, 1, '2024-06-02'),
(2, 2, '2024-06-03');

INSERT INTO Note (code_eleve, id_epreuve, note) VALUES
(1, 1, 16.5),
(2, 2, 14.0);


-- Affichage des données
SELECT * FROM Enseignant;
SELECT * FROM Epreuve;
SELECT * FROM corriger;
SELECT * FROM rédiger;
SELECT * FROM Examen;
SELECT * FROM travailler;
SELECT * FROM Eleve;

--  1 - Sélectionner tous les élèves et leurs dates de naissance :
SELECT nom, date_naissance FROM Eleve;

-- 2 - Trouver la note moyenne pour l'examen 'Baccalauréat' :
SELECT AVG(note) AS moyenne_bac
FROM effectuer
JOIN epreuve ON effectuer.id_epreuve = epreuve.id_epreuve
JOIN contenir ON epreuve.id_epreuve = contenir.id_epreuve
JOIN examen ON contenir.id_examen = examen.id_examen
WHERE examen.nom = 'Baccalauréat';

--  3 - Lister tous les enseignants travaillant à 'Paris' :
SELECT *
FROM enseignant
JOIN travailler ON enseignant.matricule_enseignant = travailler.matricule_enseignant
JOIN etablissement ON travailler.code_etablissement = etablissement.code_etablissement
WHERE etablissement.ville = 'Paris';

--  4 - Compter le nombre d'élèves inscrits dans chaque établissement :
SELECT etablissement.nom AS nom_etablissement, COUNT(inscrire.code_eleve) AS nombre_eleves_inscrits
FROM etablissement
LEFT JOIN inscrire ON etablissement.code_etablissement = inscrire.code_etablissement
GROUP BY etablissement.code_etablissement;

--  5 - Obtenir les noms de tous les élèves ayant passé un examen avec une note supérieure à 15 :
SELECT nom, note
FROM Eleve
JOIN effectuer ON eleve.code_eleve = effectuer.code_eleve
WHERE effectuer.note > 15;

-- 6 - Afficher les examens et les noms des épreuves correspondantes avec leurs coefficients : 
SELECT examen.nom AS nom_examen, epreuve.nom AS nom_epreuve, epreuve.coefficient
FROM examen
JOIN contenir ON examen.id_examen = contenir.id_examen
JOIN epreuve ON contenir.id_epreuve = epreuve.id_epreuve;

--  7 - Lister les établissements avec le nombre d'examens différents pris, triés par le nombre d'examens :
SELECT e.code_etablissement, e.nom AS nom_etablissement, COUNT(DISTINCT c.id_examen) AS nombre_examens
FROM etablissement e
LEFT JOIN travailler t ON e.code_etablissement = t.code_etablissement
LEFT JOIN enseignant en ON t.matricule_enseignant = en.matricule_enseignant
LEFT JOIN corriger co ON en.matricule_enseignant = co.matricule_enseignant
LEFT JOIN epreuve ep ON co.id_epreuve = ep.id_epreuve
LEFT JOIN contenir c ON ep.id_epreuve = c.id_epreuve
GROUP BY e.code_etablissement, e.nom
ORDER BY nombre_examens DESC;


-- 8 - Trouver tous les élèves qui n'ont passé aucun examen :
SELECT eleve.nom
FROM eleve
LEFT JOIN passer ON eleve.code_eleve = passer.code_eleve
WHERE passer.code_eleve IS NULL;


-- 9 - Identifier les enseignants qui ont à la fois rédigé et corrigé la même épreuve :
SELECT DISTINCT enseignant.nom
FROM enseignant
JOIN rediger ON rediger.matricule_enseignant = enseignant.matricule_enseignant
JOIN corriger ON corriger.matricule_enseignant = enseignant.matricule_enseignant
WHERE rediger.id_epreuve = corriger.id_epreuve;


 -- 10 - Montrer le dernier examen que chaque élève a passé, avec la date et la note :
SELECT
    e.code_eleve, e.nom,
    MAX(ep.date_epreuve) AS derniere_epreuve,
    AVG(ef.note) AS moyenne_note
FROM
    Eleve e
JOIN passer p ON e.code_eleve = p.code_eleve
JOIN Examen ex ON p.id_examen = ex.id_examen
JOIN contenir c ON ex.id_examen = c.id_examen
JOIN Epreuve ep ON c.id_epreuve = ep.id_epreuve
LEFT JOIN effectuer ef ON e.code_eleve = ef.code_eleve AND ep.id_epreuve = ef.id_epreuve
GROUP BY
    e.code_eleve;

