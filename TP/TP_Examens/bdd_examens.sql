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
   nom VARCHAR(50),
   date_examen DATE,
   PRIMARY KEY(id_examen)
);

CREATE TABLE Epreuve(
   id_epreuve INT,
   nom VARCHAR(50),
   coefficient INT,
   date_epreuve DATE,
   PRIMARY KEY(id_epreuve)
);

CREATE TABLE inscrire(
   code_etablissement INT,
   code_eleve INT,
   PRIMARY KEY(code_etablissement, code_eleve),
   FOREIGN KEY(code_etablissement) REFERENCES Etablissement(code_etablissement),
   FOREIGN KEY(code_eleve) REFERENCES Eleve(code_eleve)
);

CREATE TABLE corriger(
   matricule_enseignant INT,
   id_epreuve INT,
   PRIMARY KEY(matricule_enseignant, id_epreuve),
   FOREIGN KEY(matricule_enseignant) REFERENCES Enseignant(matricule_enseignant),
   FOREIGN KEY(id_epreuve) REFERENCES Epreuve(id_epreuve)
);

CREATE TABLE rédiger(
   matricule_enseignant INT,
   id_epreuve INT,
   PRIMARY KEY(matricule_enseignant, id_epreuve),
   FOREIGN KEY(matricule_enseignant) REFERENCES Enseignant(matricule_enseignant),
   FOREIGN KEY(id_epreuve) REFERENCES Epreuve(id_epreuve)
);

CREATE TABLE passer(
   code_eleve INT,
   id_examen INT,
   PRIMARY KEY(code_eleve, id_examen),
   FOREIGN KEY(code_eleve) REFERENCES Eleve(code_eleve),
   FOREIGN KEY(id_examen) REFERENCES Examen(id_examen)
);

CREATE TABLE travailler(
   matricule_enseignant INT,
   code_etablissement INT,
   PRIMARY KEY(matricule_enseignant, code_etablissement),
   FOREIGN KEY(matricule_enseignant) REFERENCES Enseignant(matricule_enseignant),
   FOREIGN KEY(code_etablissement) REFERENCES Etablissement(code_etablissement)
);

CREATE TABLE contenir(
   id_examen INT,
   id_epreuve INT,
   PRIMARY KEY(id_examen, id_epreuve),
   FOREIGN KEY(id_examen) REFERENCES Examen(id_examen),
   FOREIGN KEY(id_epreuve) REFERENCES Epreuve(id_epreuve)
);

CREATE TABLE effectuer(
   code_eleve INT,
   id_epreuve INT,
   note DECIMAL(4,2),
   PRIMARY KEY(code_eleve, id_epreuve),
   FOREIGN KEY(code_eleve) REFERENCES Eleve(code_eleve),
   FOREIGN KEY(id_epreuve) REFERENCES Epreuve(id_epreuve)
);


-- Insertion d'enseignants
INSERT INTO Enseignant VALUES (101, 'Professeur Dubois', '1234567890', '123 Rue Principale', 'Paris');
INSERT INTO Enseignant VALUES (102, 'Professeur Martin', '9876543210', '456 Avenue du Chene', 'Lyon');
INSERT INTO Enseignant VALUES (103, 'Professeur Leroux', '5551234567', '789 Chemin des Pins', 'Marseille');
INSERT INTO Enseignant VALUES (104, 'Professeur Lambert', '9878765432', '321 Rue du Cedre', 'Bordeaux');

-- Insertion de dossiers d'inscription
INSERT INTO Dossier_inscription VALUES (201);
INSERT INTO Dossier_inscription VALUES (202);
INSERT INTO Dossier_inscription VALUES (203);
INSERT INTO Dossier_inscription VALUES (204);

-- Insertion d'établissements (Lycées et Universités)
INSERT INTO Etablissement VALUES (301, 'Lycée Victor Hugo', '789 Rue de lErable', 'Paris');
INSERT INTO Etablissement VALUES (302, 'Lycée Marcel Proust', '321 Avenue du Pin', 'Lyon');
INSERT INTO Etablissement VALUES (303, 'Lycée Jeanne dArc', '555 Chemin des Chenes', 'Marseille');
INSERT INTO Etablissement VALUES (304, 'Lycée Gustave Eiffel', '123 Rue de lErable', 'Bordeaux');
INSERT INTO Etablissement VALUES (401, 'Université de Paris', '456 Boulevard Saint-Michel', 'Paris');
INSERT INTO Etablissement VALUES (402, 'Université de Lyon', '789 Avenue des Quais', 'Lyon');

-- Insertion d'élèves avec certains n'ayant pas passé d'épreuve
INSERT INTO Eleve VALUES (501, 'Jeanne Dupont', '456 Chemin du Bouleau', '2000-05-15', 201);
INSERT INTO Eleve VALUES (502, 'Pierre Leroux', '789 Rue du Cedre', '1999-08-20', 202);
INSERT INTO Eleve VALUES (503, 'Marie Lefevre', '321 Avenue Erable', '2001-02-10', 203);
INSERT INTO Eleve VALUES (504, 'Antoine Martin', '555 Chemin du Pin', '2002-11-25', 204);
INSERT INTO Eleve VALUES (601, 'Jeanne SansEpreuve', '456 Chemin du Bouleau', '2000-05-15', 201);

-- Insertion d'examens avec note
INSERT INTO Examen VALUES (701, 'Baccalauréat', '2023-06-25');
INSERT INTO Examen VALUES (702, 'Autre Examen', '2023-06-25');
INSERT INTO Examen VALUES (703, 'Licence', '2023-06-25');
INSERT INTO Examen VALUES (704, 'Master', '2023-06-25');

-- Insertion d'épreuves
INSERT INTO Epreuve VALUES (801, 'Mathematiques', 3, '2023-06-27');
INSERT INTO Epreuve VALUES (802, 'Francais', 2, '2023-06-28');
INSERT INTO Epreuve VALUES (803, 'Histoire-Geographie', 4, '2023-06-30');
INSERT INTO Epreuve VALUES (804, 'Sciences', 3, '2023-06-22');

-- Insertion dans la table inscrire
INSERT INTO inscrire VALUES (301, 501);
INSERT INTO inscrire VALUES (302, 502);
INSERT INTO inscrire VALUES (303, 503);
INSERT INTO inscrire VALUES (304, 504);

-- Insertion dans la table corriger et rédiger
INSERT INTO corriger VALUES (101, 801);
INSERT INTO corriger VALUES (102, 802);
INSERT INTO corriger VALUES (104, 803);
INSERT INTO corriger VALUES (104, 804);

INSERT INTO rédiger VALUES (102, 801);
INSERT INTO rédiger VALUES (102, 802);
INSERT INTO rédiger VALUES (103, 803);
INSERT INTO rédiger VALUES (104, 803);
INSERT INTO rédiger VALUES (104, 804);

-- Insertion dans la table passer
INSERT INTO passer VALUES (501, 701);
INSERT INTO passer VALUES (502, 702);
INSERT INTO passer VALUES (503, 703);
INSERT INTO passer VALUES (503, 702);
INSERT INTO passer VALUES (503, 701);
-- L'élève 601 n'a pas passé d'examen

-- Insertion dans la table travailler
INSERT INTO travailler VALUES (101, 301);
INSERT INTO travailler VALUES (102, 302);
INSERT INTO travailler VALUES (103, 303);
INSERT INTO travailler VALUES (104, 304);

-- Insertion dans la table contenir
INSERT INTO contenir VALUES (701, 801);
INSERT INTO contenir VALUES (702, 802);
INSERT INTO contenir VALUES (703, 803);
INSERT INTO contenir VALUES (704, 804);

-- Insertion des relations effectuer
INSERT INTO effectuer VALUES (501, 801, 14.5);
INSERT INTO effectuer VALUES (502, 802, 18.2);
INSERT INTO effectuer VALUES (503, 803, 12.8);
INSERT INTO effectuer VALUES (504, 804, 16.7);



