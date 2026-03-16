-- Obtenir la liste des codes aéroports uniques depuis lesquels nos avions ont décollé, par ordre alphabétique.
-- Utilité : Cartographier les aéroports de départ habituels de la flotte.
SELECT DISTINCT aeroport_depart 
FROM VOL 
ORDER BY aeroport_depart ASC;

-- Trouver tous les modèles d'avions dont le nom contient "Falcon".
-- Utilité : Isoler la gamme de jets d'affaires civils du catalogue.
SELECT nom_modele, Categorie, Autonomie 
FROM Modele 
WHERE nom_modele LIKE '%Falcon%';

-- Lister les vols enregistrés dont la durée est comprise entre 2h (120 min) et 5h (300 min).
-- Utilité : Analyser les vols moyen-courriers pour les cycles d'usure des moteurs.
SELECT id_vol, Num_serie, date_vol, duree_vol_minutes 
FROM VOL 
WHERE duree_vol_minutes BETWEEN 120 AND 300;

-- Afficher les clients qui sont basés soit en France ('FR') soit aux Etats-Unis ('US').
-- Utilité : Cibler les communications de support sur nos deux marchés principaux.
SELECT nom_client, code_pays 
FROM CLIENT 
WHERE code_pays IN ('FR', 'US');

-- Afficher les avions de configuration "Tactique" ou "Surveillance", triés par pays puis par client.
-- Utilité : Préparer un rapport sur les flottes dédiées aux missions militaires et spéciales.
SELECT Num_serie, configuration_cabine, code_pays 
FROM AVION 
WHERE configuration_cabine IN ('Tactique', 'Surveillance') 
ORDER BY code_pays DESC, id_client ASC;

-- Calculer le temps de vol total accumulé par chaque avion physique (qui a volé plus de 200 minutes au total).
-- Utilité : Identifier les cellules nécessitant une révision approfondie (calcul du MTBF).

SELECT Num_serie, SUM(duree_vol_minutes) / 60.0 as Total_Heures_Vol
FROM VOL 
GROUP BY Num_serie 
HAVING SUM(duree_vol_minutes) > 200;

-- Trouver le pourcentage moyen de carburant vert (SAF) utilisé par numéro de série, pour ceux ayant une moyenne supérieure à 10%.
-- Utilité : Récompenser les opérateurs respectant les engagements écologiques.
SELECT Num_serie, AVG(pourcentage_carburant_vert) as Moyenne_SAF 
FROM VOL 
GROUP BY Num_serie 
HAVING AVG(pourcentage_carburant_vert) > 10;

-- Compter le nombre d'interventions réalisées par chaque centre de maintenance, pour les centres ayant fait au moins 2 interventions.
-- Utilité : Évaluer la charge de travail et répartir les effectifs mécaniciens.
SELECT id_centre, COUNT(num_intervention_avion) as Nombre_Interventions 
FROM INTERVENTION 
GROUP BY id_centre 
HAVING COUNT(num_intervention_avion) >= 2;

-- Obtenir la masse vide moyenne des modèles par catégorie d'avion, uniquement pour les catégories pesant en moyenne plus de 10 000 kg.
-- Utilité : Analyser l'évolution des gabarits industriels.
SELECT Categorie, AVG(masse_vide) as Poids_Moyen_Kg 
FROM Modele 
GROUP BY Categorie 
HAVING AVG(masse_vide) > 10000;

-- Compter le nombre d'avions physiques associés à chaque contrat, en ne gardant que les contrats couvrant plus d'un avion.
-- Utilité : Identifier les contrats de gestion de flotte majeurs.
SELECT id_contrat_, COUNT(Num_serie) as Nombre_Avions_Couverts 
FROM AVION 
GROUP BY id_contrat_ 
HAVING COUNT(Num_serie) > 1;

-- Lier chaque avion physique au nom commercial de son modèle théorique.
-- Utilité : Obtenir un inventaire lisible de la flotte matérielle.
SELECT a.Num_serie, m.nom_modele, a.configuration_cabine 
FROM AVION a 
INNER JOIN Modele m ON a.Id_modele = m.Id_modele;

-- Lister tous les modèles du catalogue, avec les avions physiques produits s'ils existent (même les modèles encore en projet sans avion physique).
-- Utilité : Comparer le catalogue de vente avec la réalité de la production en usine.
SELECT m.nom_modele, a.Num_serie 
FROM Modele m 
LEFT OUTER JOIN AVION a ON m.Id_modele = a.Id_modele;

-- Connaître le détail complet d'un vol : l'identifiant du vol, le nom du modèle de l'avion, son numéro de série, et le nom du client propriétaire.
-- Utilité : Tracer la responsabilité d'un vol spécifique en cas d'incident.

SELECT v.id_vol, m.nom_modele, a.Num_serie, c.nom_client 
FROM VOL v 
INNER JOIN AVION a ON v.Id_modele = a.Id_modele AND v.Num_serie = a.Num_serie
INNER JOIN Modele m ON a.Id_modele = m.Id_modele
INNER JOIN CLIENT c ON a.code_pays = c.code_pays AND a.id_client = c.id_client;

-- Afficher toutes les villes enregistrées et les centres de maintenance qui s'y trouvent, même si une ville n'a pas (encore) de centre.
-- Utilité : Préparer l'expansion immobilière du support logistique mondial.
SELECT v.nom_ville, cm.nom_centre 
FROM CENTRE_MAINTENANCE cm 
RIGHT OUTER JOIN VILLE v ON cm.code_pays = v.code_pays AND cm.id_ville = v.id_ville;

-- Trouver quels sont les centres de maintenance "antennes" et afficher le nom de leur centre principal associé de rattachement.
-- Utilité : Visualiser la hiérarchie du réseau mondial de maintenance.
SELECT secondaire.nom_centre as Centre_Antenne, principal.nom_centre as Centre_Directeur 
FROM CENTRE_MAINTENANCE secondaire 
INNER JOIN CENTRE_MAINTENANCE principal 
ON secondaire.code_pays_principal = principal.code_pays 
AND secondaire.id_ville_principal = principal.id_ville 
AND secondaire.id_centre_principal = principal.id_centre;

-- Lister le nom des clients qui possèdent au moins un modèle d'avion de la catégorie 'Militaire'.
-- Utilité : Filtrer la base de données client pour des communications de niveau secret défense.
SELECT DISTINCT c.nom_client 
FROM CLIENT c
INNER JOIN AVION a ON c.code_pays = a.code_pays AND c.id_client = a.id_client
INNER JOIN Modele m ON a.Id_modele = m.Id_modele
WHERE m.Categorie = 'Militaire';

-- Trouver les numéros de série des avions qui n'ont ENCORE JAMAIS subi d'intervention de maintenance.
-- Utilité : Détecter les avions sortis récemment d'usine ou ceux qui ne respectent pas le calendrier de révision.
SELECT a.Num_serie 
FROM AVION a 
WHERE NOT EXISTS (
    SELECT 1 
    FROM INTERVENTION i 
    WHERE i.Id_modele = a.Id_modele 
    AND i.Num_serie = a.Num_serie
);

-- Identifier les modèles d'avions dont l'autonomie est strictement supérieure à l'autonomie de TOUS les avions de catégorie 'AVSIMAR'.
-- Utilité : Prouver à un client quel modèle de la flotte est le champion absolu de la distance franchissable.
SELECT nom_modele, Autonomie 
FROM Modele 
WHERE Autonomie > ALL (
    SELECT Autonomie 
    FROM Modele 
    WHERE Categorie = 'AVSIMAR'
);

-- Trouver les contrats dont le taux de disponibilité est inférieur à n'importe quel contrat ayant la formule 'Premium'.
-- Utilité : Vérifier qu'aucun contrat standard n'offre de meilleures garanties qu'un contrat Premium.
SELECT nom_contrat, taux_de_dispo 
FROM CONTRAT 
WHERE taux_de_dispo < ANY (
    SELECT taux_de_dispo 
    FROM CONTRAT 
    WHERE formule = 'Premium'
);

-- Trouver les modèles d'avions (nom et catégorie) pour lesquels il y a eu au moins un vol enregistré avec plus de 20% de réduction CO2.
-- Utilité : Faire une plaquette marketing sur les modèles les plus performants en écologie.
SELECT m.nom_modele, m.Categorie 
FROM Modele m 
WHERE EXISTS (
    SELECT 1 
    FROM AVION a 
    INNER JOIN VOL v ON a.Id_modele = v.Id_modele AND a.Num_serie = v.Num_serie 
    WHERE a.Id_modele = m.Id_modele 
    AND v.reduc_co2 > 20
);
