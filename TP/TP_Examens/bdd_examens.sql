CREATE DATABASE tp_examens;
-- DROP DATABASE tp_examens;
USE tp_examens;

CREATE TABLE Enseignant(
   matricule_enseignant INT,
   nom VARCHAR(50),
   telephone VARCHAR(10),
   adresse VARCHAR(100),
   ville VARCHAR(30),
   PRIMARY KEY(matricule_enseignant)
);

CREATE TABLE Dossier_inscription(
   id_dossier INT,
   PRIMARY KEY(id_dossier)
);

CREATE TABLE Etablissement(
   code_etablissement INT,
   nom VARCHAR(50),
   adresse VARCHAR(100),
   ville VARCHAR(30),
   PRIMARY KEY(code_etablissement)
);

CREATE TABLE Eleve(
   code_eleve INT,
   nom VARCHAR(50),
   adresse VARCHAR(100),
   date_naissance DATE,
   id_dossier INT NOT NULL,
   PRIMARY KEY(code_eleve),
   FOREIGN KEY(id_dossier) REFERENCES Dossier_inscription(id_dossier)
);

CREATE TABLE Examen(
   id_examen INT,
   PRIMARY KEY(id_examen)
);

CREATE TABLE Epreuve(
   id_epreuve INT,
   note DECIMAL(2,2),
   coefficient INT,
   PRIMARY KEY(id_epreuve)
);
