# Schema relationnel

## Vehicules

Choix de l'héritage:  

* Comme il y a des associations entre camions et voitures, dont l'héritage n'est pas ni complet ni presque complet. donc on élimine la façon de transmettre par la classe mère
* et pour la classe mère il y a beaucoup de associations, et un véhicule peut installer plusieurs capteur

Donc on va le transmettre par référence

Vehicule(#num_de_imma : VARCHAR, marque :VARCHAR, modele :VARCHAR, annee_de_production :ENTIER)

moto(#num_de_imma_vehi=>Vehicule, capacite_moteur: ENTIER)

SAMU(#num_de_imma_vehi=>Vehicule)

pompier(#num_de_imma_vehi=>Vehicule)

police(#num_de_imma_vehi=>Vehicule)

voiture(#num_de_imma_vehi=>Vehicule)

camion(#num_de_imma_vehi=>Vehicule, capacite_max:ENTIER)

transporter(#num_de_imma_vehi_voiture=>voiture,#num_de_imma_vehi_camion=>camion)

### les vues pour l'héritage par référence

vmoto = jointure(Vehicule,moto,num_de_imma=num_de_imma_vehi)
vSAMU = jointure(Vehicule,SAMU,num_de_imma=num_de_imma_vehi)
vpompier = jointure(Vehicule,pompier,num_de_imma=num_de_imma_vehi)
vpolice = jointure(Vehicule,police,num_de_imma=num_de_imma_vehi)
vvoiture = jointure(Vehicule,voiture,num_de_imma=num_de_imma_vehi)
vcamion = jointure(Vehicule,camion,num_de_imma=num_de_imma_vehi)

### Normalisation sur Vehicule

* Toutes les attributs sont atomiques=>1NF
* l'attribut num_de_imma_vehi  détermine toutes les autres atrributes=> 2NF
* les attributs qui ne appartiennent à clé candicate sont dépendantes les unes des autres =>3NF

### Normalisation sur moto,SAMU,pompier,police,voiture,camion,transporter,etc

* cas simple 3NF(il n'a qu'une attribut ou deux attributs)

### contrainte sur l'héritage par référence

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

*UNION(UNION(UNION(UNION(UNION(PROJECTION(moto, num_de_imma_vehi),PROJECTION(voiture, num_de_imma_vehi)),PROJECTION(camion, num_de_imma_vehi)),PROJECTION(SAMU,num_de_imma_vehi)),PROJECTION(pompier,num_de_imma_vehi)),PROJECTION(police,num_de_imma_vehi))=PROJECTION(Vehicule, num_de_imma)

## occurrence

Choix de l'héritage:

* l'héritage non compet

on va prendre l'héritage par les classes filles

travaux_routiers(#temps_reel:VARCHAR, longitude:VARCHAR,latitude:VARCHAR)AVEC (longitude,latitude) UNIQUE

detection_materiel_controle_routier(#temps_reel:VARCHAR,longitude:VARCHAR,latitude:VARCHAR,survitesse: BOOLEAN,griller_feurouge:BOOLEAN)AVEC (longitude,latitude) UNIQUE

Alertes_meteos(#temps_reel:VARCHAR,temps : {'pluie', 'neige', 'brouillard'},temperature:ENTIER)

Accidents(#temps_reel:VARCHAR,gravite :{'petit','moyen','grave'}, nombre_vehicule:ENTIER,type_vehicule:JSON)

### normalisation sur accidents

type_vehicule est multivalués, donc c'est 0NF. //par JSON

### normalisation sur les occurrences saut accidents

**on suppose qu'il n'y a pas de occurences qui vont avoir lieu à meme timestamp**

* cas simple 2NF (l'attribut temps_reel peut déternimer toutes les autres attributs)
* et  les attributs qui ne appartiennent à clé candicate sont dépendantes les unes des autres =>3NF

## Capteur

Capteur(#modele: VARCHAR, #num_de_serie: VARCHAR, num_de_imma=>Vehicule,temps_reel_tr=>travaux_routiers,temps_reel_dmcr=>detection_materiel_controle_routier,temps_reels_am=>Alertes_meteos,
temps_reels_ac=>Accidents)  

### normalisation sur capteur

* Toutes les attributs sont atomiques=>1NF
* la clé primaire(modele,num_de_serie) détermine toutes les autres atrributes=> 2NF
* les attributs qui ne appartiennent à clé candicate sont dépendantes les unes des autres =>3NF

### Contrainte de Capteur

* contranite sur l'association de type1--0..*:
  * Capteur.num_de_imma NOT NULL

### vue pour l'héritage par les classes filles

vOccurrence =Union(Projection(Accidents,temps_reel), Union(Projection(Altertes_meteos,temps_reel),Union(Projection(travaux_routiers,temps_reel),Projection(dectection_matieriel_controle,temps_reel))))

### contrainte complexe sur l'héritage par les classes filles(association'detecter' sur la classe mère)

* temps_reel_tr XOR temps_reel_dmcr XOR temps_reel_am XOR temps_reel_ac
* PROJECTION(Capteur,temps_reel_tr) = PROJECTION(travaux_routiers, temps_reel) AND PROJECTION(Capteur,timstamp_dmcr) = PROJECTION(detection_materiel_controle_routier, temps_reel)AND PROJECTION(Capteur,timstamp_am) = PROJECTION(Alertes_meteos, temps_reel)AND PROJECTION(Capteur,timstamp_ac) = PROJECTION(Accidents, temps_reel)

La solution consiste à ajouter autant de clés étrangères que de classes filles et à gérer le fait que ces clés ne peuvent pas être co-valuées.

## Commune

Commune(#nom:VARCHAR, #code_postal:ENTIER)

### normalisation sur commune

cas simple 3NF---clé primaire (nom,code_postal)

## Station_de_base

Station_de_base(#id_I: ENTIER, longitude:VARCHAR, latitude:VARCHAR,nom:VARCHAR=>Commune, code_postal:ENTIER=>Commune)
AVEC (longitude,latitude)UNIQUE AND(nom,code_postal)UNIQUE et Not NULL

### normalisation sur station_de_base

* Toutes les attributs sont atomiques=>1NF
* l'attribut id_I détermine toutes les autres atrributes=> 2NF
* les attributs qui ne appartiennent à clé candicate sont dépendantes les unes des autres =>3NF

## info_ItoI

info_ItoV(#id_Ia=>Station_de_base,#id_Ib=>Station_de_base)

## info_ItoV

info_ItoV(#id_I=>Station_de_base,#num_de_imma=>Vehicule)

## info_VtoI

info_VtoI(#id_I=>Station_de_base, #num_de_imma=>Vehicule, latitude:VARCHAR, longitude:VARCHAR, annee_de_production:ENTIER, marque_V:VARCHAR, modele_V:VARCHAR, modele_C:VARCHAR, num_serie_C:VARCHAR)

### normalisation sur les infos

ce sont les classes d'association  simplement =>3NF

### Contrainte sur l'info_VtoI

PROJECTION(info_VtoI,annee_de_production)=PROJECTION(Vehicule,annee_de_production)AND PROJECTION(info_VtoI,marque_V)=PROJECTION(Vehicule,marque)AND PROJECTION(info_VtoI,modele_V)=PROJECTION(Vehicule,modele)

## evenement

evenement(#temps_reel:VARCHAR,identifiant_S:VARCHARI,num_de_imma:VARCHAR, type_echange :{'Alertes_meteo','Accidents','travaux_routiers','detection_materiel_controle_routier',},longitude_tr:VARCHAR,latitude_tr:VARCHAR,longitude_dmcr:VARCHAR,latitude_dmcr:VARCHAR,survitesse:BOOLEAN,griller_feurouge:VARCHAR,temps: {'pluie', 'neige', 'brouillard'},temperature:ENTIER,gravite :{'petit','moyen','grave'},nombre_vehicule:ENTIER,type_vehicule:JSON,nom=>Commune,code_postal=>Commune)
Avec (nom,code_postal)UNIQUE ET NOT NULL

### normalisation sur l'évènement

**on suppose qu'il n'y a pas de evenements qui vont  avoir lieu à meme timestamp**

* cas simple 2NF (l'attribut temps_reel peut déternimer toutes les autres attributs)
* et  les attributs qui ne appartiennent à clé candicate sont dépendantes les unes des autres =>3NF

### CONTRAINTE POUR l'évènement

CHECK((type_echange = 'travaux_toutiers' AND longitude_tr IS NOT NULL AND latitude_tr IS NOT NULL AND longitude_dmcr IS NULL AND latitude_dmcr IS NULL AND survitess IS NULL AND griller_feurouge IS NULL AND temps IS NULL AND temperature IS NULL AND gravite IS NULL AND nombre_vehicule IS NULL AND type_vehicule IS NULL) 
    OR (type_echange = 'detection_materiel_controle_routier' AND longitude_dmcr IS NOT NULL AND latitude_dmcr IS NOT NULL AND survitess IS NOT NULL AND griller_feurouge IS NOT NULL AND longitude_tr IS NULL AND latitude_tr IS NULL AND temps IS NULL AND temperature IS NULL AND gravite IS NULL AND nombre_vehicule IS NULL AND type_vehicule IS NULL)
    OR (type_echange = 'Alertes_meteo' AND temps IS NOT NULL AND temperature IS NOT NULL AND longitude_tr IS NULL AND latitude_tr IS NULL AND longitude_dmcr IS NULL AND latitude_dmcr IS NULL AND survitess IS NULL AND griller_feurouge IS NULL AND gravite IS NULL AND nombre_vehicule IS NULL AND type_vehicule IS NULL)
    OR (type_echange = 'Accidents' AND gravite IS NOT NULL AND nombre_vehicule IS NOT NULL AND type_vehicule IS NOT NULL AND longitude_tr IS NULL AND latitude_tr IS NULL AND longitude_dmcr IS NULL AND latitude_dmcr IS NULL AND survitess IS NULL AND griller_feurouge IS NULL AND temps IS NULL AND temperature IS NULL ))

## les vues pour consulter // méthodes en algèbre relationnel

* Lister tous les véhicules dans une région(code_postal = 264200)
  
  Je peux retirer les voitures dans la classe èvenement.

R1 = restriction(evenement,code_postal=264200)
R2 = projection(R1,num_de_imma)
R3 = jointure(R2,Vehicule,R2.num_de_imma=Vehicule.num_de_imma)
R4 = projection(R3,num_de_imma,marque,modele,annee_de_production)

* Lister toutes les communications liées à une véhicule ou à une station de base

//véhicule(num_de_imma='AB-343-CA')
R1 = restriction(info_VtoI,num_de_imma='AB-343-CA')
R2 = projection(R1,*)

R1 = restriction(info_ItoV,num_de_imma='AB-343-CA')
R2 = projection(R3,*)

//sation de base
R1 = restriction(info_VtoI,id_i='1')
R2 = projection(R1,*)

R1 = restriction(info_ItoV,id_i='1')
R2 = projection(R1,*)

R1 = restriction(info_ItoI,id_ia='1'or id_ib ='1')
R2 = projection(R1,*)

* Trouver le véhicule le plus proche d'un certain type, par exemple, un camion de pompiers, véhicule SAMU, etc. ou un certain modèle : toutes les Citroën C5, ...

R1 = restriction(Vehicule,marque =Audi,modele=Q3)
R2 = projection(R1,num_de_imma,marque,modele,annee_de_production)

* Calculer les statistiques de passage de véhicules : par zone, par type, ...

//par zone
R1 = restriction(evenement,code_postal=264200)
R2 = projection(R1,num_de_imma)
=>agrégation fonction de regroupment: COUNT()

* Supprimer de la base toutes les communications qui concernent un certain modèle du capteur (par exemple, dont le mal-fonctionnement a été démontré).

R1=restriction(info_VtoI,modele_C='HQ',num_serie_C='A1')
EN SQL : DELETE...FROM...

* Supprimer de la base toutes les communications qui concernent une station de base particulière (modèle défaillant)

R1 =restriction(info_VtoI,id_i='2')
EN SQL : DELETE...FROM...
R2 =restriction(info_ItoV,id_i='2')
EN SQL : DELETE...FROM...
R3 =restriction(info_ItoI,id_ia='2'or id_in='2')
EN SQL : DELETE...FROM...

## La gestion des droits

Gestion de droit
Nous allons créer  trois groupes pour l'ensemble du système:Client, Admin
CREATE GROUP Client WITH USER c1, c2;
CREATE GROUP ADMIN WITH USER admin1, admin2;

Admin: a la plus haute autorité sur toutes les tables
Client: a des droits sauf  les occurences et les evenements qui sont dédectés par les capteurs

GRANT ALL PRIVILEGES ON
Vehicule,moto,SAMU,pompier,police,voiture,camion,transporter,travaux_routiers,detection_materiel_controle_routier,Alertes_meteos,Accidents,Capteur,Commune,Station_de_base,info_ItoI,info_ItoV,info_VtoI,evenement TO ADMIN;

GRANT SELECT, UPDATE, INSERT ON Vehicule,moto,SAMU,pompier,police,voiture,camion,Capteur,Commune,Station_de_base,info_ItoI,info_ItoV,info_VtoI TO Client;

GRANT SELECT  ON Vehicule,moto,SAMU,pompier,police,voiture,camion,transporter,travaux_routiers,detection_materiel_controle_routier,Alertes_meteos,Accidents,Capteur,Commune,Station_de_base,info_ItoI,info_ItoV,info_VtoI,evenement TO Public;
```plantuml
skinparam classAttributeIconSiwe 0
class Fraction {
	-numerateur : int
		- denominateur : int

		- simplification()
		+ Fraction(int n = 0, int d = 1)
		+ getNumerateur() : int
		+ getDenominateur() : int
		+ setFraction(int n, int d);
		+ somme(Fraction& f):Fraction
};
```
