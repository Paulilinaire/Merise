-- Affichage des données
SELECT * FROM contrat;
SELECT * FROM Produit;
SELECT * FROM offre;
SELECT * FROM fournisseur;
SELECT * FROM offre_fournisseur;

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


-- 6 - Afficher les contrats signés par chaque fournisseur avec la date de signature.

-- 7 - Lister les offres avec les noms des produits correspondants.

-- 8 - Trouver le fournisseur qui a effectué le plus d'offres.

-- 9 - Calculer le montant total des contrats par produit.

-- 10 - Trouver les offres qui n'ont pas été signées avant leur date de clôture et les fournisseurs responsables.