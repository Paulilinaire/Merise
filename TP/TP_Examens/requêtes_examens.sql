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
SELECT
    e.code_eleve,
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



