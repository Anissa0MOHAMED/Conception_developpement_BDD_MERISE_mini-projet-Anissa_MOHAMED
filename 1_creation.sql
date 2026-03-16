CREATE TABLE Modele (
    Id_modele INT PRIMARY KEY,
    nom_modele VARCHAR(50) NOT NULL,
    envergure DECIMAL(5,2),
    longueur_ DECIMAL(5,2),
    hauteur DECIMAL(5,2),
    masse_vide INT,
    masse_max INT,
    capacite_emport INT,
    Categorie VARCHAR(15),
    Autonomie INT,
    vitesse_mach DECIMAL(3,2),
    nom_moteur VARCHAR(50)
);

CREATE TABLE CONTRAT (
    id_contrat_ INT PRIMARY KEY,
    nom_contrat VARCHAR(50) NOT NULL,
    formule VARCHAR(20),
    taux_de_dispo INT
);

CREATE TABLE Pays (
    code_pays VARCHAR(2) PRIMARY KEY,
    nom_pays VARCHAR(50) NOT NULL
);

CREATE TABLE VILLE (
    code_pays VARCHAR(2),
    id_ville INT,
    nom_ville VARCHAR(50) NOT NULL,
    PRIMARY KEY (code_pays, id_ville),
    FOREIGN KEY (code_pays) REFERENCES Pays(code_pays) 
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE CLIENT (
    code_pays VARCHAR(2),
    id_client INT,
    nom_client VARCHAR(50) NOT NULL,
    PRIMARY KEY (code_pays, id_client),
    FOREIGN KEY (code_pays) REFERENCES Pays(code_pays) 
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE AVION (
    Id_modele INT,
    Num_serie VARCHAR(20),
    configuration_cabine VARCHAR(15),
    id_contrat_ INT NULL,
    code_pays VARCHAR(2) NULL,
    id_client INT NULL,
    PRIMARY KEY (Id_modele, Num_serie),
    FOREIGN KEY (Id_modele) REFERENCES Modele(Id_modele) 
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (id_contrat_) REFERENCES CONTRAT(id_contrat_) 
        ON DELETE SET NULL ON UPDATE CASCADE,
    FOREIGN KEY (code_pays, id_client) REFERENCES CLIENT(code_pays, id_client) 
        ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE VOL (
    Id_modele INT,
    Num_serie VARCHAR(20),
    id_vol VARCHAR(15),
    date_vol DATE,
    duree_vol_minutes INT,
    aeroport_depart VARCHAR(4),
    aeroport_arrivee VARCHAR(50),
    reduc_co2 INT,
    pourcentage_carburant_vert INT,
    PRIMARY KEY (Id_modele, Num_serie, id_vol),
    FOREIGN KEY (Id_modele, Num_serie) REFERENCES AVION(Id_modele, Num_serie) 
        ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE CENTRE_MAINTENANCE (
    code_pays VARCHAR(2),
    id_ville INT,
    id_centre VARCHAR(15),
    nom_centre VARCHAR(100) NOT NULL,
    code_pays_principal VARCHAR(2) NULL,
    id_ville_principal INT NULL,
    id_centre_principal VARCHAR(15) NULL,
    PRIMARY KEY (code_pays, id_ville, id_centre),
    FOREIGN KEY (code_pays, id_ville) REFERENCES VILLE(code_pays, id_ville) 
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (code_pays_principal, id_ville_principal, id_centre_principal) 
        REFERENCES CENTRE_MAINTENANCE(code_pays, id_ville, id_centre) 
        ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE INTERVENTION (
    Id_modele INT,
    Num_serie VARCHAR(20),
    num_intervention_avion INT,
    descriptif VARCHAR(255),
    date_debut DATE,
    code_pays VARCHAR(2),
    id_ville INT,
    id_centre VARCHAR(15),
    PRIMARY KEY (Id_modele, Num_serie, num_intervention_avion),
    FOREIGN KEY (Id_modele, Num_serie) REFERENCES AVION(Id_modele, Num_serie) 
        ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (code_pays, id_ville, id_centre) REFERENCES CENTRE_MAINTENANCE(code_pays, id_ville, id_centre) 
        ON DELETE CASCADE ON UPDATE CASCADE
);