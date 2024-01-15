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
SELECT
    o.num_offre,
    o.date_offre,
    o.date_cloture,
    f.num_fournisseur,
    f.nom_fournisseur,
    ct.date_signature
FROM
    offre o
JOIN
    offre_fournisseur off ON o.num_offre = off.num_offre
JOIN
    fournisseur f ON off.num_fournisseur = f.num_fournisseur
LEFT JOIN
    contracter ct ON off.num_fournisseur = ct.num_fournisseur
WHERE
    ct.num_contrat IS NULL OR
    ct.num_contrat NOT IN (
        SELECT num_contrat
        FROM contracter
        WHERE date_signature > o.date_cloture
    );
    





