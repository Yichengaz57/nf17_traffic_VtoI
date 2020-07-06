
/*
Lister tous les véhicules dans une région
Lister toutes les communications liées à une véhicule ou à une station de base
Trouver le véhicule le plus proche d'un certain type, par exemple, un camion de pompiers, véhicule SAMU, etc. ou un certain modèle : toutes les Citroën C5, ...
Calculer les statistiques de passage de véhicules : par zone, par type, ...
Supprimer de la base toutes les communications qui concernent un certain modèle du capteur (par exemple, dont le mal-fonctionnement a été démontré).
Supprimer de la base toutes les communications qui concernent une station de base particulière (modèle défaillant)*/


-- SELECT liste d''attributs de partionnement à projeter et de fonctions de calcul
-- FROM liste de relations
-- WHERE condition à appliquer avant calcul de l''agrégat
-- GROUP BY  liste ordonnée d''attributs de partionnement


CREATE VIEW Vvehicules_weihai AS 
SELECT nom,code_postal,Vehicule.num_de_imma,marque,modele,annee_de_production
FROM evenement,Vehicule
WHERE (evenement.code_postal='264200' AND evenement.num_de_imma = Vehicule.num_de_imma);

CREATE VIEW VcommuniVehicule_AB343CA_VtoI AS 
SELECT * 
FROM info_VtoI
WHERE (info_VtoI.num_de_imma='AB-343-CA');

CREATE VIEW VcommuniVehicule_AB343CA_ItoV AS
SELECT *
FROM info_ItoV
WHERE(info_ItoV.num_de_imma='AB-343-CA');

CREATE VIEW VcommuniStation_VtoI AS 
SELECT * 
FROM info_VtoI
WHERE (info_VtoI.id_i='1');

CREATE VIEW VcommuniStation_ItoV AS 
SELECT *
FROM info_ItoV
WHERE(info_ItoV.id_i='1');

CREATE VIEW VcommuniStation_ItoI AS 
SELECT *
FROM info_ItoI
WHERE(info_ItoI.id_ia='1' OR info_ItoI.id_ib='1');

CREATE VIEW Vvehicules_AudiQ3 AS
SELECT *
FROM Vehicule 
WHERE(Vehicule.marque='Audi' AND Vehicule.modele='Q3');

CREATE VIEW Vcount_vehi_264200 AS
SELECT num_de_imma,COUNT(temps_reel)
FROM evenement
WHERE (evenement.code_postal='264200')
GROUP BY num_de_imma;


-- JSON SELECT

CREATE VIEW vAccident_type_vehecule_20200122031407 AS
SELECT gravite,nombre_vehicule,t_v.*
FROM Accidents ac, JSON_ARRAY_ELEMENTS(ac.type_vehicule) t_v
WHERE ac.temps_reel='2020-01-22 03:14:07';

DELETE 
FROM info_VtoI
WHERE(modele_C='HQ'AND num_serie_C='A1');

DELETE
FROM info_VtoI
WHERE(id_i='2');
DELETE
FROM info_ItoV
WHERE(id_i='2');
DELETE
FROM info_ItoI
WHERE(id_ia='2' OR id_ib='2');