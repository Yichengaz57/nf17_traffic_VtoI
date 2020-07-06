DELETE FROM  info_ItoI;
DELETE FROM  info_ItoV;
DELETE FROM  info_VtoI;
DELETE FROM  evenement;
DELETE FROM  transporter;
DELETE FROM  moto;
DELETE FROM  SAMU;
DELETE FROM  pompier;
DELETE FROM  police;
DELETE FROM  voiture;
DELETE FROM  camion;
DELETE FROM  Capteur;
DELETE FROM  Vehicule;
DELETE FROM  travaux_routiers;
DELETE FROM  detection_materiel_controle_routier;
DELETE FROM  Alertes_meteos;
DELETE FROM  Accidents;
DELETE FROM  Station_de_base;
DELETE FROM  Commune;


--------------------------------Vehicule--------------------------------
INSERT INTO Vehicule (num_de_imma, marque, modele, annee_de_production)
    VALUES ('AB-343-CA', 'BMW', 'X5', '2019');
INSERT INTO Vehicule (num_de_imma, marque, modele, annee_de_production)
    VALUES ('AB-344-CA', 'Audi', 'S5', '2019');
INSERT INTO Vehicule (num_de_imma, marque, modele, annee_de_production)
    VALUES ('AB-455-CA', 'Audi', 'Q3', '2020');
INSERT INTO Vehicule (num_de_imma, marque, modele, annee_de_production)
    VALUES ('AB-345-CA', 'ducati', 'Monster797', '2018');
INSERT INTO Vehicule (num_de_imma, marque, modele, annee_de_production)
    VALUES ('AB-346-CA', 'citroen', 'xx', '2017');
INSERT INTO Vehicule (num_de_imma, marque, modele, annee_de_production)
    VALUES ('AB-347-CA', 'citroen', 'ss', '2017');
INSERT INTO Vehicule (num_de_imma, marque, modele, annee_de_production)
    VALUES ('AB-348-CA', 'citroen', 'sq', '2017');
INSERT INTO Vehicule (num_de_imma, marque, modele, annee_de_production)
    VALUES ('AB-349-CA', 'renault', 'df', '2017');
INSERT INTO voiture(num_de_imma_vehi)
    VALUES('AB-343-CA');
INSERT INTO voiture(num_de_imma_vehi)
    VALUES('AB-344-CA');
INSERT INTO voiture(num_de_imma_vehi)
    VALUES('AB-455-CA');
INSERT INTO moto(num_de_imma_vehi,capacite_moteur)
    VALUES('AB-345-CA','1700');
INSERT INTO SAMU(num_de_imma_vehi)
    VALUES('AB-346-CA');
INSERT INTO pompier(num_de_imma_vehi)
    VALUES('AB-347-CA');
INSERT INTO police(num_de_imma_vehi)
    VALUES('AB-348-CA');
INSERT INTO camion(num_de_imma_vehi,capacite_max)
    VALUES('AB-349-CA','20');

INSERT INTO transporter(num_de_imma_vehi_voiture,num_de_imma_vehi_camion)
    VALUES('AB-344-CA','AB-349-CA');
INSERT INTO transporter(num_de_imma_vehi_voiture,num_de_imma_vehi_camion)
    VALUES('AB-343-CA','AB-349-CA');

-------------------------------- occurrence--------------------------------

INSERT INTO travaux_routiers(temps_reel,longitude,latitude)
    VALUES('2020-01-19 03:14:07','122.1204','37.5131');
INSERT INTO detection_materiel_controle_routier(temps_reel,longitude,latitude,survitess,griller_feurouge)
    VALUES('2020-01-20 03:14:07','2.3522','48.8566',TRUE,FALSE);
INSERT INTO Alertes_meteos(temps_reel,temps,temperature)
    VALUES('2020-01-21 03:14:07','pluie','10');

    -- JSON
INSERT INTO Accidents
    VALUES(
    '2020-01-22 03:14:07',
    'moyen',
    '2',
    '["ducati","renault"]'
    );

INSERT INTO detection_materiel_controle_routier(temps_reel,longitude,latitude,survitess,griller_feurouge)
    VALUES('2020-01-23 03:14:07','122.1396','37.6213',FALSE,TRUE);

-------------------------------- Capteur--------------------------------

INSERT INTO Capteur(modele,num_de_serie,num_de_imma,temps_reel_tr)
    VALUES('HQ','A1','AB-343-CA','2020-01-19 03:14:07');
INSERT INTO Capteur(modele,num_de_serie,num_de_imma,temps_reel_am)
    VALUES('HQ','A2','AB-346-CA','2020-01-21 03:14:07');
INSERT INTO Capteur(modele,num_de_serie,num_de_imma,temps_reel_dmcr)
    VALUES('AG','A3','AB-455-CA','2020-01-23 03:14:07');

INSERT INTO Capteur(modele,num_de_serie,num_de_imma,temps_reel_ac)
    VALUES('AG','A4','AB-455-CA','2020-01-22 03:14:07');



-------------------------------- Commune--------------------------------

INSERT INTO Commune(nom,code_postal)
    VALUES('weihai','264200');
INSERT INTO Commune(nom,code_postal)
    VALUES('yantai','264000');
INSERT INTO Commune(nom,code_postal)
    VALUES('beijing','100000');

-------------------------------- Station_de_base--------------------------------

INSERT INTO Station_de_base(id_I,longitude,latitude,nom,code_postal)
    VALUES('1','122.1209','37.5129','weihai','264200');
INSERT INTO Station_de_base(id_I,longitude,latitude,nom,code_postal)
    VALUES('2','123.1209','37.6129','yantai','264000');
INSERT INTO Station_de_base(id_I,longitude,latitude,nom,code_postal)
    VALUES('3','116.4074','39.9042','beijing','100000');

-------------------------------- les info--------------------------------

INSERT INTO info_ItoI(id_Ia,id_Ib)
    VALUES('1','2');
INSERT INTO info_ItoI(id_Ia,id_Ib)
    VALUES('1','3');


INSERT INTO info_ItoV(id_I,num_de_imma)
    VALUES('2','AB-346-CA');
INSERT INTO info_ItoV(id_I,num_de_imma)
    VALUES('1','AB-343-CA');
INSERT INTO info_ItoV(id_I,num_de_imma)
    VALUES('1','AB-455-CA');




INSERT INTO info_VtoI(id_I,num_de_imma,longitude,latitude,annee_de_production,marque_V,modele_V,modele_C,num_serie_C)
    VALUES('1','AB-343-CA','124.3366','38.6633','2017','BMW','X5','HQ','A1');
INSERT INTO info_VtoI(id_I,num_de_imma,longitude,latitude,annee_de_production,marque_V,modele_V,modele_C,num_serie_C)
    VALUES('1','AB-455-CA','122.1396','37.6213','2020','Audi','Q3','AG','A3');
INSERT INTO info_VtoI(id_I,num_de_imma,longitude,latitude,annee_de_production,marque_V,modele_V,modele_C,num_serie_C)
    VALUES('1','AB-455-CA','122.1966','37.3333','2020','Audi','Q3','AG','A4');

-------------------------------- evenement--------------------------------
INSERT INTO evenement(temps_reel,identifiant_S,num_de_imma,type_echange,longitude_tr, latitude_tr, longitude_dmcr,latitude_dmcr,survitess,griller_feurouge, temps, temperature,gravite, nombre_vehicule, type_vehicule, nom,code_postal)
    VALUES('2020-01-19 03:14:07','1','AB-343-CA','travaux_routiers','122.1204','37.5131',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'weihai','264200');
INSERT INTO evenement(temps_reel,identifiant_S,num_de_imma,type_echange,longitude_tr, latitude_tr, longitude_dmcr,latitude_dmcr,survitess,griller_feurouge, temps, temperature,gravite, nombre_vehicule, type_vehicule, nom,code_postal)
    VALUES('2020-01-21 03:14:07','2','AB-346-CA','Alertes_meteos',NULL,NULL,NULL,NULL,NULL,NULL,'pluie','10',NULL,NULL,NULL,'yantai','264000');
INSERT INTO evenement(temps_reel,identifiant_S,num_de_imma,type_echange,longitude_tr, latitude_tr, longitude_dmcr,latitude_dmcr,survitess,griller_feurouge, temps, temperature,gravite, nombre_vehicule, type_vehicule, nom,code_postal)
    VALUES('2020-01-23 03:14:07','1','AB-455-CA','detection_materiel_controle_routier',NULL,NULL,'122.1396','37.6213',FALSE,TRUE,NULL,NULL,NULL,NULL,NULL,'weihai','264200');
-- JSON
INSERT INTO evenement(temps_reel,identifiant_S,num_de_imma,type_echange,longitude_tr, latitude_tr, longitude_dmcr,latitude_dmcr,survitess,griller_feurouge, temps, temperature,gravite, nombre_vehicule, type_vehicule, nom,code_postal)
    VALUES('2020-01-22 03:14:07','1','AB-455-CA','Accidents',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,
    'moyen',
    '2',
    '["ducati","renault"]',
    'weihai',
    '264200');