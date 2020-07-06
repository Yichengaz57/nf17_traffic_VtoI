-- ### contrainte sur l'héritage par référence
/*
* INTERSECTION(PROJECTION(moto, num_de_imma_vehi),PROJECTION(voiture, num_de_imma_vehi))={}
* INTERSECTION(PROJECTION(moto, num_de_imma_vehi),PROJECTION(camion, num_de_imma_vehi))={}
* INTERSECTION(PROJECTION(moto, num_de_imma_vehi),PROJECTION(SAMU, num_de_imma_vehi))={}
* INTERSECTION(PROJECTION(moto, num_de_imma_vehi),PROJECTION(pompier, num_de_imma_vehi))={}
* INTERSECTION(PROJECTION(moto, num_de_imma_vehi),PROJECTION(police, num_de_imma_vehi))={}
* INTERSECTION(PROJECTION(voiture, num_de_imma_vehi),PROJECTION(camion, num_de_imma_vehi))={}
* INTERSECTION(PROJECTION(voiture, num_de_imma_vehi),PROJECTION(SAMU, num_de_imma_vehi))={}
* INTERSECTION(PROJECTION(voiture, num_de_imma_vehi),PROJECTION(pompier, num_de_imma_vehi))={}
* INTERSECTION(PROJECTION(voiture, num_de_imma_vehi),PROJECTION(police, num_de_imma_vehi))={}
* INTERSECTION(PROJECTION(camion, num_de_imma_vehi),PROJECTION(SAMU, num_de_imma_vehi))={}
* INTERSECTION(PROJECTION(camion, num_de_imma_vehi),PROJECTION(pompier, num_de_imma_vehi))={}
* INTERSECTION(PROJECTION(camion, num_de_imma_vehi),PROJECTION(police, num_de_imma_vehi))={}
* INTERSECTION(PROJECTION(SAMU, num_de_imma_vehi),PROJECTION(pompier, num_de_imma_vehi))={}
* INTERSECTION(PROJECTION(SAMU, num_de_imma_vehi),PROJECTION(police, num_de_imma_vehi))={}
* INTERSECTION(PROJECTION(pompier, num_de_imma_vehi),PROJECTION(police, num_de_imma_vehi))={}
*/

-- CREATE VIEW  <nom de vue> <nom des colonnes>

-- AS <spécification de question>

CREATE VIEW  VMotoExclutVoiture AS
    SELECT num_de_imma_vehi FROM moto
    INTERSECT 
    SELECT num_de_imma_vehi FROM voiture;

CREATE VIEW  VMotoExclutCamion AS
    SELECT num_de_imma_vehi FROM moto
    INTERSECT 
    SELECT num_de_imma_vehi FROM camion;

CREATE VIEW  VMotoExclutSAMU AS
    SELECT num_de_imma_vehi FROM moto
    INTERSECT 
    SELECT num_de_imma_vehi FROM SAMU;

CREATE VIEW  VMotoExclutPompier AS
    SELECT num_de_imma_vehi FROM moto
    INTERSECT 
    SELECT num_de_imma_vehi FROM pompier;

CREATE VIEW  VMotoExclutPolice AS
    SELECT num_de_imma_vehi FROM moto
    INTERSECT 
    SELECT num_de_imma_vehi FROM police;

CREATE VIEW  VVoitureExclutCamion AS
    SELECT num_de_imma_vehi FROM voiture
    INTERSECT 
    SELECT num_de_imma_vehi FROM camion;

CREATE VIEW  VVoitureExclutSAMU AS
    SELECT num_de_imma_vehi FROM voiture
    INTERSECT 
    SELECT num_de_imma_vehi FROM SAMU;

CREATE VIEW  VVoitureExclutPompier AS
    SELECT num_de_imma_vehi FROM voiture
    INTERSECT 
    SELECT num_de_imma_vehi FROM pompier;

CREATE VIEW  VVoitureExclutPolice AS
    SELECT num_de_imma_vehi FROM voiture
    INTERSECT 
    SELECT num_de_imma_vehi FROM police;

CREATE VIEW  VCamionExclutSAMU AS
    SELECT num_de_imma_vehi FROM camion
    INTERSECT 
    SELECT num_de_imma_vehi FROM SAMU;

CREATE VIEW  VCamionExclutPompier AS
    SELECT num_de_imma_vehi FROM camion
    INTERSECT 
    SELECT num_de_imma_vehi FROM pompier;

CREATE VIEW  VCamionExclutPolice AS
    SELECT num_de_imma_vehi FROM camion
    INTERSECT 
    SELECT num_de_imma_vehi FROM police;

CREATE VIEW  VSAMUExclutPompier AS
    SELECT num_de_imma_vehi FROM SAMU
    INTERSECT 
    SELECT num_de_imma_vehi FROM pompier;

CREATE VIEW  VSAMUExclutPolice AS
    SELECT num_de_imma_vehi FROM SAMU
    INTERSECT 
    SELECT num_de_imma_vehi FROM police;

CREATE VIEW  VPompierExclutPolice AS
    SELECT num_de_imma_vehi FROM pompier
    INTERSECT 
    SELECT num_de_imma_vehi FROM police;

/*UNION(UNION(UNION(UNION(UNION(PROJECTION(moto, num_de_imma_vehi),PROJECTION(voiture, num_de_imma_vehi)),PROJECTION(camion, num_de_imma_vehi)),PROJECTION(SAMU,num_de_imma_vehi)),PROJECTION(pompier,num_de_imma_vehi)),PROJECTION(police,num_de_imma_vehi))=PROJECTION(Vehicule, num_de_imma)*/

CREATE VIEW vmo_voi_ca_sa_pom_po AS
    SELECT num_de_imma_vehi FROM moto
    UNION    
    SELECT num_de_imma_vehi FROM voiture
    UNION
    SELECT num_de_imma_vehi FROM camion
    UNION
    SELECT num_de_imma_vehi FROM SAMU
    UNION
    SELECT num_de_imma_vehi FROM pompier
    UNION
    SELECT num_de_imma_vehi FROM police;

CREATE VIEW vVehiculeExceptUnionfilles AS
    SELECT num_de_imma FROM Vehicule
    EXCEPT
    SELECT num_de_imma_vehi FROM vmo_voi_ca_sa_pom_po;

-- ### les vues pour l'héritage par référence
/*
vmoto = jointure(Vehicule,moto,num_de_imma=num_de_imma_vehi)
vSAMU = jointure(Vehicule,SAMU,num_de_imma=num_de_imma_vehi)
vpompier = jointure(Vehicule,pompier,num_de_imma=num_de_imma_vehi)
vpolice = jointure(Vehicule,police,num_de_imma=num_de_imma_vehi)
vvoiture = jointure(Vehicule,voiture,num_de_imma=num_de_imma_vehi)
vcamion = jointure(Vehicule,camion,num_de_imma=num_de_imma_vehi)
*/

CREATE VIEW vmoto AS
    SELECT * FROM Vehicule,moto
    WHERE Vehicule.num_de_imma=moto.num_de_imma_vehi;

CREATE VIEW vSAMU AS
    SELECT * FROM Vehicule,SAMU
    WHERE Vehicule.num_de_imma=SAMU.num_de_imma_vehi;

CREATE VIEW vpompier AS
    SELECT * FROM Vehicule,pompier
    WHERE Vehicule.num_de_imma=pompier.num_de_imma_vehi;

CREATE VIEW vpolice AS
    SELECT * FROM Vehicule,police
    WHERE Vehicule.num_de_imma=police.num_de_imma_vehi;

CREATE VIEW vvoiture AS
    SELECT * FROM Vehicule,voiture
    WHERE Vehicule.num_de_imma=voiture.num_de_imma_vehi;

CREATE VIEW vcamion AS
    SELECT * FROM Vehicule,camion
    WHERE Vehicule.num_de_imma=camion.num_de_imma_vehi;


-- ### contrainte complexe sur l'héritage par les classes filles(association'detecter' sur la classe mère)
/*PROJECTION(Capteur,temps_reel_tr) = PROJECTION(travaux_routiers, temps_reel) 
AND PROJECTION(Capteur,timstamp_dmcr) = PROJECTION(detection_materiel_controle_routier, temps_reel)
AND PROJECTION(Capteur,timstamp_am) = PROJECTION(Alertes_meteos, temps_reel)
AND PROJECTION(Capteur,timstamp_ac) = PROJECTION(Accidents, temps_reel)*/

CREATE VIEW vCapExclutTr AS
    SELECT temps_reel_tr FROM Capteur
    EXCEPT 
    SELECT temps_reel FROM travaux_routiers;

CREATE VIEW vCapExclutDmcr AS
    SELECT temps_reel_dmcr FROM Capteur
    EXCEPT 
    SELECT temps_reel FROM detection_materiel_controle_routier;

CREATE VIEW vCapExclutAm AS
    SELECT temps_reel_am FROM Capteur
    EXCEPT 
    SELECT temps_reel FROM Alertes_meteos;

CREATE VIEW vCapExclutAc AS
    SELECT temps_reel_ac FROM Capteur
    EXCEPT 
    SELECT temps_reel FROM Accidents;

-- ### vue pour l'héritage par les classes filles
/*vOccurrence =Union(Projection(Accidents,temps_reel), Union(Projection(Alertes_meteos,temps_reel),Union(Projection(travaux_routiers,temps_reel),Projection(detection_materiel_controle_routier,temps_reel))))*/


CREATE VIEW vOccurence AS
    SELECT temps_reel FROM detection_materiel_controle_routier
    UNION
    SELECT temps_reel FROM travaux_routiers    
    UNION
    SELECT temps_reel FROM Alertes_meteos
    UNION
    SELECT temps_reel FROM Accidents;    

-- ### Contrainte sur l'info_VtoI
/*PROJECTION(info_VtoI,annee_de_production)=PROJECTION(Vehicule,annee_de_production)
AND PROJECTION(info_VtoI,marque_V)=PROJECTION(Vehicule,marque)
AND PROJECTION(info_VtoI,modele_V)=PROJECTION(Vehicule,modele)*/

CREATE VIEW vinfo_VtoIExclutVehicule_annee AS
    SELECT annee_de_production FROM info_VtoI
    EXCEPT 
    SELECT annee_de_production FROM Vehicule;

CREATE VIEW vinfo_VtoIExclutVehicule_marque AS
    SELECT marque_V FROM info_VtoI
    EXCEPT 
    SELECT marque FROM Vehicule;

CREATE VIEW vinfo_VtoIExclutVehicule_modele AS
    SELECT modele_V FROM info_VtoI
    EXCEPT 
    SELECT modele FROM Vehicule;
