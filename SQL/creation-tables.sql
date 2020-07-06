/*Avant de créer des tables , on va d'abord supprimer toutes les tables et les vues correpondantes*/

DROP TABLE IF EXISTS Vehicule CASCADE ;
DROP TABLE IF EXISTS moto CASCADE ;
DROP TABLE IF EXISTS SAMU CASCADE ;
DROP TABLE IF EXISTS pompier CASCADE ;
DROP TABLE IF EXISTS police CASCADE ;
DROP TABLE IF EXISTS voiture CASCADE ;
DROP TABLE IF EXISTS camion CASCADE ;
DROP TABLE IF EXISTS transporter CASCADE ;
DROP TABLE IF EXISTS travaux_routiers CASCADE ;
DROP TABLE IF EXISTS detection_materiel_controle_routier CASCADE ;
DROP TABLE IF EXISTS Alertes_meteos CASCADE ;
DROP TABLE IF EXISTS Accidents CASCADE ;
DROP TABLE IF EXISTS Capteur CASCADE ;
DROP TABLE IF EXISTS Commune CASCADE ;
DROP TABLE IF EXISTS Station_de_base CASCADE ;
DROP TABLE IF EXISTS info_ItoI CASCADE ;
DROP TABLE IF EXISTS info_ItoV CASCADE ;
DROP TABLE IF EXISTS info_VtoI CASCADE ;
DROP TABLE IF EXISTS evenement CASCADE ;


-- Vehicules

CREATE TABLE Vehicule (
    num_de_imma CHAR(9) PRIMARY KEY,
    marque VARCHAR(50) NOT NULL,
    modele varchar(50) NOT NULL,
    annee_de_production integer
);

CREATE TABLE moto (
    num_de_imma_vehi CHAR(9) PRIMARY KEY,
    capacite_moteur INTEGER NOT NULL,
    FOREIGN KEY (num_de_imma_vehi) REFERENCES Vehicule (num_de_imma)
);

CREATE TABLE SAMU(
    num_de_imma_vehi CHAR(9) PRIMARY KEY,
    FOREIGN KEY (num_de_imma_vehi) REFERENCES Vehicule (num_de_imma)
);

CREATE TABLE pompier(
    num_de_imma_vehi CHAR(9) PRIMARY KEY,
    FOREIGN KEY (num_de_imma_vehi) REFERENCES Vehicule (num_de_imma)
);

CREATE TABLE police(
    num_de_imma_vehi CHAR(9) PRIMARY KEY,
    FOREIGN KEY (num_de_imma_vehi) REFERENCES Vehicule (num_de_imma)
);

CREATE TABLE voiture(
    num_de_imma_vehi CHAR(9) PRIMARY KEY,
    FOREIGN KEY (num_de_imma_vehi) REFERENCES Vehicule (num_de_imma)
);

CREATE TABLE camion(
    num_de_imma_vehi CHAR(9) PRIMARY KEY,
    capacite_max INTEGER,
    FOREIGN KEY (num_de_imma_vehi) REFERENCES Vehicule (num_de_imma)
);

CREATE TABLE transporter(
    num_de_imma_vehi_voiture CHAR(9),
    num_de_imma_vehi_camion CHAR(9),
    PRIMARY KEY (num_de_imma_vehi_voiture,num_de_imma_vehi_camion),   
    FOREIGN KEY (num_de_imma_vehi_voiture) REFERENCES voiture (num_de_imma_vehi),
    FOREIGN KEY (num_de_imma_vehi_camion) REFERENCES camion (num_de_imma_vehi)
);

-- occurrence

CREATE TABLE travaux_routiers(
    temps_reel TIMESTAMP PRIMARY KEY,
    longitude VARCHAR(10) NOT NULL,
    latitude VARCHAR(10) NOT NULL,
    UNIQUE(longitude,latitude)
);

CREATE TABLE detection_materiel_controle_routier(
    temps_reel TIMESTAMP PRIMARY KEY,
    longitude VARCHAR(10) NOT NULL,
    latitude VARCHAR(10) NOT NULL,
    survitess BOOLEAN NOT NULL,
    griller_feurouge BOOLEAN NOT NULL,
    UNIQUE(longitude,latitude)
);

CREATE TABLE Alertes_meteos(
    temps_reel TIMESTAMP PRIMARY KEY,
    temps varchar(15) NOT NULL CHECK (temps IN ('pluie', 'neige', 'brouillard')),
    temperature INTEGER NOT NULL
);

-- JSON
CREATE TABLE Accidents(
    temps_reel TIMESTAMP PRIMARY KEY,
    gravite varchar(5) NOT NULL CHECK (gravite IN ('petit', 'moyen', 'grave')),
    nombre_vehicule INTEGER NOT NULL,
    type_vehicule JSON NOT NULL
);

-- Capteur

CREATE TABLE Capteur(
    modele VARCHAR(50) NOT NULL,
    num_de_serie VARCHAR(50) NOT NULL,
    num_de_imma CHAR(9) NOT NULL,
    temps_reel_tr TIMESTAMP,
    temps_reel_dmcr TIMESTAMP,
    temps_reel_am TIMESTAMP,
    temps_reel_ac TIMESTAMP,
    PRIMARY KEY(modele,num_de_serie),
    FOREIGN KEY(num_de_imma) REFERENCES Vehicule(num_de_imma),
    FOREIGN KEY(temps_reel_tr) REFERENCES travaux_routiers(temps_reel),
    FOREIGN KEY(temps_reel_dmcr) REFERENCES detection_materiel_controle_routier(temps_reel),
    FOREIGN KEY(temps_reel_am) REFERENCES Alertes_meteos(temps_reel),
    FOREIGN KEY(temps_reel_ac) REFERENCES Accidents(temps_reel),
    CHECK ((temps_reel_tr IS NOT NULL AND temps_reel_dmcr IS NULL AND temps_reel_am IS  NULL AND temps_reel_ac IS NULL) OR (temps_reel_tr IS NULL AND temps_reel_dmcr IS NOT NULL AND temps_reel_am IS NULL AND temps_reel_ac IS NULL)OR(temps_reel_tr IS NULL AND temps_reel_dmcr IS NULL AND temps_reel_am IS NOT NULL AND temps_reel_ac IS NULL
)OR(temps_reel_tr IS NULL AND temps_reel_dmcr IS NULL AND temps_reel_am IS NULL AND temps_reel_ac IS NOT NULL))

    );

--Commune

CREATE TABLE Commune(
    nom VARCHAR(50),
    code_postal iNTEGER,
    PRIMARY KEY(nom,code_postal)
);

-- Station_de_base

CREATE TABLE Station_de_base(
    id_I VARCHAR PRIMARY KEY,
    longitude VARCHAR(50),
    latitude VARCHAR(50),
    nom VARCHAR(50) NOT NULL,
    code_postal INTEGER NOT NULL,
    UNIQUE(longitude,latitude),
    FOREIGN KEY(nom,code_postal) REFERENCES Commune(nom,code_postal)
);

-- les info

CREATE TABLE info_ItoI(
    id_Ia VARCHAR NOT NULL,
    id_Ib VARCHAR NOT NULL,
    FOREIGN KEY(id_Ia) REFERENCES Station_de_base(id_I),
    FOREIGN KEY(id_Ib) REFERENCES Station_de_base(id_I)
);

CREATE TABLE info_ItoV(
    id_I VARCHAR NOT NULL,
    num_de_imma VARCHAR NOT NULL,
    FOREIGN KEY(id_I) REFERENCES Station_de_base(id_I),
    FOREIGN KEY(num_de_imma) REFERENCES Vehicule(num_de_imma)
);

CREATE TABLE info_VtoI(
    id_I VARCHAR NOT NULL,
    num_de_imma CHAR(9) NOT NULL,
    longitude VARCHAR(50),
    latitude VARCHAR(50),
    annee_de_production INTEGER NOT NULL,
    marque_V VARCHAR(50) NOT NULL,
    modele_V VARCHAR(50) NOT NULL,
    modele_C VARCHAR(50) NOT NULL,
    num_serie_C VARCHAR(50) NOT NULL,
    UNIQUE(longitude,latitude),
    FOREIGN KEY(id_I) REFERENCES Station_de_base(id_I),
    FOREIGN KEY(num_de_imma) REFERENCES Vehicule(num_de_imma)
);

--evenement

CREATE TABLE evenement(
    temps_reel TIMESTAMP PRIMARY KEY,
    identifiant_S VARCHAR NOT NULL,
    num_de_imma CHAR(9) NOT NULL,
    type_echange varchar(50) NOT NULL CHECK (type_echange IN ('Alertes_meteos', 'Accidents', 'travaux_routiers','detection_materiel_controle_routier')),
    longitude_tr VARCHAR,
    latitude_tr VARCHAR,
    longitude_dmcr VARCHAR,
    latitude_dmcr VARCHAR,
    survitess BOOLEAN,
    griller_feurouge BOOLEAN,
    temps VARCHAR CHECK (temps IN ('pluie', 'neige', 'brouillard')),
    temperature INTEGER,
    gravite VARCHAR CHECK(gravite IN ('petit','moyen','grave')),
    nombre_vehicule INTEGER,
    type_vehicule JSON,
    nom VARCHAR(50) NOT NULL,
    code_postal INTEGER NOT NULL,
    FOREIGN KEY(nom,code_postal) REFERENCES Commune(nom,code_postal),
    CHECK((type_echange = 'travaux_routiers' AND longitude_tr IS NOT NULL AND latitude_tr IS NOT NULL AND longitude_dmcr IS NULL AND latitude_dmcr IS NULL AND survitess IS NULL AND griller_feurouge IS NULL AND temps IS NULL AND temperature IS NULL AND gravite IS NULL AND nombre_vehicule IS NULL AND type_vehicule IS NULL) 
    OR (type_echange = 'detection_materiel_controle_routier' AND longitude_dmcr IS NOT NULL AND latitude_dmcr IS NOT NULL AND survitess IS NOT NULL AND griller_feurouge IS NOT NULL AND longitude_tr IS NULL AND latitude_tr IS NULL AND temps IS NULL AND temperature IS NULL AND gravite IS NULL AND nombre_vehicule IS NULL AND type_vehicule IS NULL)
    OR (type_echange = 'Alertes_meteos' AND temps IS NOT NULL AND temperature IS NOT NULL AND longitude_tr IS NULL AND latitude_tr IS NULL AND longitude_dmcr IS NULL AND latitude_dmcr IS NULL AND survitess IS NULL AND griller_feurouge IS NULL AND gravite IS NULL AND nombre_vehicule IS NULL AND type_vehicule IS NULL)
    OR (type_echange = 'Accidents' AND gravite IS NOT NULL AND nombre_vehicule IS NOT NULL AND type_vehicule IS NOT NULL AND longitude_tr IS NULL AND latitude_tr IS NULL AND longitude_dmcr IS NULL AND latitude_dmcr IS NULL AND survitess IS NULL AND griller_feurouge IS NULL AND temps IS NULL AND temperature IS NULL ))
);