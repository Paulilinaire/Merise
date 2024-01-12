-- Affichage des données
SELECT * FROM Enseignant;
SELECT * FROM Epreuve;
SELECT * FROM corriger;
SELECT * FROM rédiger;
SELECT * FROM Examen;
SELECT * FROM travailler;
SELECT * FROM Eleve;

--  1 - Sélectionner tous les élèves et leurs dates de naissance.
SELECT nom, date_naissance FROM Eleve;

-- 2 - Trouver la note moyenne pour l'examen 'Baccalauréat'.
SELECT AVG(note) AS moyenne_bac
FROM effectuer
JOIN epreuve ON effectuer.id_epreuve = epreuve.id_epreuve
JOIN contenir ON epreuve.id_epreuve = contenir.id_epreuve
JOIN examen ON contenir.id_examen = examen.id_examen
WHERE examen.nom = 'Baccalauréat';

--  3 - Lister tous les enseignants travaillant à 'Paris'.
SELECT *
FROM enseignant
JOIN travailler ON enseignant.matricule_enseignant = travailler.matricule_enseignant
JOIN etablissement ON travailler.code_etablissement = etablissement.code_etablissement
WHERE etablissement.ville = 'Paris';

--  4 - Compter le nombre d'élèves inscrits dans chaque établissement.
SELECT etablissement.nom AS nom_etablissement, COUNT(inscrire.code_eleve) AS nombre_eleves_inscrits
FROM etablissement
LEFT JOIN inscrire ON etablissement.code_etablissement = inscrire.code_etablissement
GROUP BY etablissement.code_etablissement;

--  5 - Obtenir les noms de tous les élèves ayant passé un examen avec une note supérieure à 15.
SELECT nom, note
FROM Eleve
JOIN effectuer ON eleve.code_eleve = effectuer.code_eleve
WHERE effectuer.note > 15;

-- 6 - Afficher les examens et les noms des épreuves correspondantes avec leurs coefficients.
SELECT examen.nom AS nom_examen, epreuve.nom AS nom_epreuve, epreuve.coefficient
FROM examen
JOIN contenir ON examen.id_examen = contenir.id_examen
JOIN epreuve ON contenir.id_epreuve = epreuve.id_epreuve;

--  7 - Lister les établissements avec le nombre d'examens différents pris, triés par le nombre d'examens.
SELECT etablissement.nom, examen.nom
FROM etablissement
JOIN epreuve
