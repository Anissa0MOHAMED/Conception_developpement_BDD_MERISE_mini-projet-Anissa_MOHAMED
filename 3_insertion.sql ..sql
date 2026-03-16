-- Fichier : 3_insertion.sql

-- 1. Tables sans clés étrangères
INSERT INTO Pays (code_pays, nom_pays) VALUES 
('FR', 'France'),
('US', 'Etats-Unis'),
('EG', 'Egypte'),
('IN', 'Inde');

INSERT INTO CONTRAT (id_contrat_, nom_contrat, formule, taux_de_dispo) VALUES 
(1, 'FalconCare', 'Premium', 99),
(2, 'MCO Rafale France', 'Standard', 95),
(3, 'Support Export', 'Basique', 90);

INSERT INTO Modele (Id_modele, nom_modele, envergure, longueur_, hauteur, masse_vide, masse_max, capacite_emport, Categorie, Autonomie, vitesse_mach, nom_moteur) VALUES 
(1, 'Rafale', 10.86, 15.27, 5.34, 10000, 24500, 9500, 'Militaire', 1759, 1.80, 'Snecma M88'),
(2, 'Falcon 10X', 33.60, 33.40, 8.40, 23451, 52163, 0, 'Civil', 13890, 0.92, 'Rolls-Royce Pearl 10X'),
(3, 'Mirage 2000 D', 9.13, 14.55, 5.15, 7500, 17000, 6000, 'Militaire', 1550, 2.20, 'Snecma M53-P2'),
(4, 'Falcon 8X', 26.29, 24.46, 7.94, 18598, 33113, 0, 'Civil', 11945, 0.90, 'Pratt & Whitney PW307D'),
(5, 'Falcon Albatros', 21.38, 20.23, 7.11, 13472, 19414, 2000, 'AVSIMAR', 7408, 0.86, 'Pratt & Whitney PW308C');

-- 2. Tables avec 1 niveau de dépendance
INSERT INTO VILLE (code_pays, id_ville, nom_ville) VALUES 
('FR', 1, 'Paris'),
('FR', 2, 'Merignac'),
('FR', 3, 'Istres'),
('US', 4, 'Little Rock'),
('EG', 5, 'Le Caire');

INSERT INTO CLIENT (code_pays, id_client, nom_client) VALUES 
('FR', 1, 'Armee de l Air et de l Espace'),
('FR', 2, 'Marine Nationale'),
('US', 3, 'Global Private Jets Inc'),
('EG', 4, 'Force Aerienne Egyptienne');

-- 3. Tables avec 2 niveaux de dépendances
INSERT INTO AVION (Id_modele, Num_serie, configuration_cabine, id_contrat_, code_pays, id_client) VALUES 
(1, 'B301', 'Tactique', 2, 'FR', 1),
(1, 'B302', 'Tactique', 2, 'FR', 1),
(1, 'EM01', 'Tactique', 3, 'EG', 4),
(2, 'F10X-001', 'VIP 14 pax', 1, 'US', 3),
(2, 'F10X-002', 'VIP 19 pax', 1, 'US', 3),
(3, 'M2K-601', 'Tactique', 2, 'FR', 1),
(4, 'F8X-101', 'VIP 12 pax', 1, 'US', 3),
(4, 'F8X-102', 'VIP 14 pax', 1, 'FR', 1),
(5, 'ALB-01', 'Surveillance', 2, 'FR', 2),
(5, 'ALB-02', 'Surveillance', 2, 'FR', 2);

INSERT INTO CENTRE_MAINTENANCE (code_pays, id_ville, id_centre, nom_centre, code_pays_principal, id_ville_principal, id_centre_principal) VALUES 
('FR', 2, 'DFS-MER', 'Dassault Falcon Service Merignac', NULL, NULL, NULL),
('FR', 3, 'BA125', 'Atelier Maintenance Istres', NULL, NULL, NULL),
('US', 4, 'DFJ-LR', 'Dassault Falcon Jet Little Rock', 'FR', 2, 'DFS-MER');

-- 4. Tables avec 3 niveaux de dépendances
INSERT INTO VOL (Id_modele, Num_serie, id_vol, date_vol, duree_vol_minutes, aeroport_depart, aeroport_arrivee, reduc_co2, pourcentage_carburant_vert) VALUES 
(1, 'B301', 'V-1001', '2026-01-10', 120, 'LFMI', 'LFMI', 5, 10),
(1, 'B302', 'V-1002', '2026-01-15', 180, 'LFMI', 'LFPG', 0, 0),
(2, 'F10X-001', 'V-2001', '2026-02-01', 450, 'KJFK', 'LFPG', 15, 20),
(2, 'F10X-002', 'V-2002', '2026-02-05', 300, 'KLAX', 'KJFK', 20, 30),
(3, 'M2K-601', 'V-3001', '2026-02-10', 90, 'LFBD', 'LFMI', 0, 0),
(4, 'F8X-101', 'V-4001', '2026-02-12', 400, 'OMDB', 'LFPG', 10, 15),
(4, 'F8X-102', 'V-4002', '2026-02-14', 150, 'LFPG', 'LSGG', 25, 50),
(5, 'ALB-01', 'V-5001', '2026-02-20', 360, 'LFRD', 'LFRD', 5, 10),
(5, 'ALB-02', 'V-5002', '2026-02-22', 240, 'LFRD', 'LFMI', 5, 10),
(1, 'EM01', 'V-6001', '2026-03-01', 150, 'HECA', 'HECA', 0, 0);

INSERT INTO INTERVENTION (Id_modele, Num_serie, num_intervention_avion, descriptif, date_debut, code_pays, id_ville, id_centre) VALUES 
(2, 'F10X-001', 1, 'Visite Type C et inspection cabine', '2026-03-05', 'US', 4, 'DFJ-LR'),
(1, 'B301', 1, 'Remplacement aube de turbine M88', '2026-03-10', 'FR', 3, 'BA125'),
(4, 'F8X-101', 1, 'Mise a jour avionique EASy III', '2026-03-12', 'FR', 2, 'DFS-MER'),
(3, 'M2K-601', 1, 'Maintenance radar et OSF', '2026-03-15', 'FR', 3, 'BA125'),
(5, 'ALB-01', 1, 'Inspection systemes de surveillance', '2026-03-16', 'FR', 2, 'DFS-MER');