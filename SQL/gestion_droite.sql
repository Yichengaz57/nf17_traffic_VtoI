CREATE USER c1;
CREATE USER c2;
CREATE USER admin1;
CREATE USER admin2;
CREATE GROUP Client WITH USER c1, c2;
CREATE GROUP ADMIN WITH USER admin1, admin2;
GRANT ALL PRIVILEGES ON
Vehicule,moto,SAMU,pompier,police,voiture,camion,transporter,travaux_routiers,detection_materiel_controle_routier,Alertes_meteos,Accidents,Capteur,Commune,Station_de_base,info_ItoI,info_ItoV,info_VtoI,evenement TO ADMIN;
GRANT SELECT, UPDATE, INSERT ON Vehicule,moto,SAMU,pompier,police,voiture,camion,Capteur,Commune,Station_de_base,info_ItoI,info_ItoV,info_VtoI TO Client;
GRANT SELECT  ON Vehicule,moto,SAMU,pompier,police,voiture,camion,transporter,travaux_routiers,detection_materiel_controle_routier,Alertes_meteos,Accidents,Capteur,Commune,Station_de_base,info_ItoI,info_ItoV,info_VtoI,evenement TO Public; 