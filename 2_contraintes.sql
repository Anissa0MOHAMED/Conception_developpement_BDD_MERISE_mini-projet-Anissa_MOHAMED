-- CONTRAINTES SUR MODELE
-- Vérifient que les grandeurs soient positives 
ALTER TABLE Modele
ADD CONSTRAINT chk_Modele_Dimensions 
CHECK (envergure > 0 AND longueur_ > 0 AND hauteur > 0);

-- verifie que la masse maximale au décollage est supérieure ou égale à la masse à vide
ALTER TABLE Modele
ADD CONSTRAINT chk_Modele_Masses 
CHECK (masse_vide > 0 AND masse_max >= masse_vide);

-- La catégorie de l'avion doit faire partie des secteurs métiers définis
ALTER TABLE Modele
ADD CONSTRAINT chk_Modele_Categorie 
CHECK (Categorie IN ('Civil', 'Militaire', 'AVSIMAR'));

-- la vitesse en Mach doit être supérieure à 0 et limite de Mach est 4
ALTER TABLE Modele
ADD CONSTRAINT chk_Modele_Vitesse 
CHECK (vitesse_mach > 0 AND vitesse_mach < 4.0);

-- CONTRAINTES SUR CONTRAT
-- Le taux de disponibilité garanti dans un contrat puisse s'exprimer en pourcentage (0 à 100)
ALTER TABLE CONTRAT
ADD CONSTRAINT chk_Contrat_Dispo 
CHECK (taux_de_dispo >= 0 AND taux_de_dispo <= 100);

-- CONTRAINTES SUR VOL
-- La durée de vol enregistrée ne peut pas être négative
ALTER TABLE VOL
ADD CONSTRAINT chk_Vol_Duree 
CHECK (duree_vol_minutes >= 0);

-- Le pourcentage de carburant d'aviation durable (SAF) est compris entre 0 et 100
ALTER TABLE VOL
ADD CONSTRAINT chk_Vol_CarburantVert 
CHECK (pourcentage_carburant_vert >= 0 AND pourcentage_carburant_vert <= 100);

-- L'aéroport de départ (code OACI) doit comporter exactement 4 caractères
ALTER TABLE VOL
ADD CONSTRAINT chk_Vol_AeroDepart 
CHECK (CHAR_LENGTH(aeroport_depart) = 4);

-- CONTRAINTES SUR PAYS 
-- Le code pays doit être saisi en majuscules (ex: 'FR', 'US')
ALTER TABLE Pays
ADD CONSTRAINT chk_Pays_Code 
CHECK (code_pays = UPPER(code_pays));

-- Contrainte d'unicité sur la flotte
-- Un numéro de série (Tail Number) est unique au monde de manière absolue
ALTER TABLE AVION
ADD CONSTRAINT uq_Avion_NumSerie UNIQUE (Num_serie);






