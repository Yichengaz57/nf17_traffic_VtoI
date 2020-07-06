# Note de clarification

## Description générale

L'idée est de créer une base de données qui contiendrait des informations qui circulent dans l'infrastructure V2I (Vehicle-TO-Infrastructure) dans un réseau de véhiclues de nouvelle génération.

## Livrables attendus

README

Note de clarification ici déclarée au format markdown

attention:  

* détails sur le choix de l'association important  
* détails sur le choix des transforamtion des héritages
* détails sur les contraintes,contraintes complexes  

Modele conceptuel de donnée (MCD) au format plantuml

Modele logique de donnée (MLD) relationnel au format plain text  
attention:  

* exprimer les vues
* réaliser les normalisaitons

BDD(SQL) : tables et vues, données de test, questions attendues (vues)  
attention :  

* clés candidates manquantes  
  
## Description des Objets, de leurs propriétés

### Les Véhicules

On représentera  des **véhicules** ayant un *numero de_imma* **(clé primaire)**, une *marque*, un *modèle*, un *annee_de_production*.  

Ces **véhicules** se diviseront en plusieurs catégories : les **voitures** et les **motos** et les **camions** et les **voitures spéciales**--les **pompiers** les **polices** et les **SAMU**

#### Véhicule

| Attributs | Contraintes |
| -------- | -------- |
| num_de_imma | unique, not null |
| marque | not null |
| modele | not null |
| annee_de_production | not null |

Comme cartains camions peuvent trasnporter des voitures et possèdent une capacité maximale. donc on peux ajouter un attribut(**capacite_max**) dans les camions.  

* Et ce attrivut peut-être null.
* ajouter une assosciation transporter entre les voitures et les camions
* Les motos ont la capacité du moteur, on peux ajouter un attribut(**capacite_moteur**)  

#### transporter

| Attributs | Contraintes |
| -------- | -------- |
| num_de_imma_1 | unique, not null |
| num_de_imma_2 | unique, not null |

**Contraintes:**  
Comme il y a des associations entre camions et voitures, dont l'héritage n'est pas ni complet ni presque complet.

#### Camion (fille de Vécule)

| Attributs | Contraintes |
| -------- | -------- |
| capacite_max     |   |

#### Moto (fille de Vécule)

| Attributs | Contraintes |
| -------- | -------- |
| capacite_moteur     |not null   |

### Les Stations de base

On représentera  des **Stations de base** ayant un *id_I unique* **(clé primaire)**, une *longitude*, une *latitude*
il est lié à une commune dont une associationd
et avec(longitude,latitude) unique

* Les véhiclues peuvent envoyer des informations vers l'infrastructure.dont on ajoute info_VtoI en tanq aue classe d'association
* Les stations de base peuvent communiquent entre elles et ainsi qu'envoyer des informations aux véhicules. dont on ajouter info_ItoI et info_ItoV en tanq que classe d'association

#### Info_VtoIs

Les véhiclues communiquent aux staions de base les  **informations**concernant *leur position geographique* ,*annee_de_production*,une *marque_de_voiture*, un*modele_de_voiture*,une*marque_de_capteur*,un*modele_de_capteur*

#### Info_VtoI

| Attributs | Contraintes |
| -------- | -------- |
| longitude|  not null |
| latitude | not null |
| annee_de_production|not null|
| marque_V|not null|
| modele_V|not null|
| modele_C|not null|
| num_serie_C|not null|

#### info_ItoI

| Attributs | Contraintes |
| -------- | -------- |

#### Info_ItoV

| Attributs | Contraintes |
| -------- | -------- |

#### Station_de_base

| Attributs | Contraintes |
| -------- | -------- |
| id_I| unique, not null |
| longitude | not null |
| latitude | not null |

Avec(longitude,latitude) unique

#### Commune

| Attributs | Contraintes |
| -------- | -------- |
| nom|  not null |
| code_postal | not null ||

Avec(nom,code_postal)unique, parceque ce code_postal est principal

### Les Capteurs

On représentera  des **Capteurs** ayant un *modele* *num_de_serie* **(modele,num_de_serie)clé primaire**,

#### Capteur

| Attributs | Contraintes |
| -------- | -------- |
| modele|  not null |
| num_de_serie | not null |

Avec(modele,num_de_serie) unique

### occurence

| Attributs | Contraintes |
| -------- | -------- |
| temps_reel| unique not null |

### Alertes_meteos

On représentera des **Alertes_meteos** ayant un *temps* *temperature*

| Attributs | Contraintes |
| -------- | -------- |
| temps|  not null |
| temperature| not null |

### Accidents

On représentera des **Accidents** ayant un *gravite*, *nombre_vehicule*, *type_vehicule*

| Attributs | Contraintes |
| -------- | -------- |
| gravite|  not null |
| nombre_vehicule| not null |
| type_vehicule| not null |

### travaux_routiers

On représentera des **travaux_routiers** ayant un *longitude*, *latitude*

| Attributs | Contraintes |
| -------- | -------- |
| longitude|  not null |
| latitude| not null |

### detection_materiel_controle_routier

On représentera des **detection_materiel_controle_routier** ayant un *longitude*, *latitude*,*survitesse*,*griller_feurouge*

| Attributs | Contraintes |
| -------- | -------- |
| longitude|  not null |
| latitude| not null |
| survitesse|  |
| griller_feurouge|  |

### les evenements

On représentera des **evenemtns** ayant un *temps_reel* *identifiants des entitées communicantes* *type_de_echange* *contenu_de_echange*. Il est lié avec commune.
avec(id_I,numero_de_imma)unique,

#### evenement

| Attributs | Contraintes |
| -------- | -------- |
| temps_reel|  not null |
| id_I | not null |
| numero de_imma| not null |
| type_echange| not null |
| longitude_tr|  |
| latitude_tr|  |
| longitude_dmcr_tr|  |
| latitude_dmcr_tr|  |
| survitesse|  null |
| griller_feurouge|  null |
| temps| not null |
| temperature| not null |
| gravite| not null |
| nombre_vehicule| not null |
| type_vehicule| not null | --JSON--MULTIVALUÉ
| nom| not null |
| code_postal| not null |

## Les  contraintes associées sur les associations

* l'association 'transporter' entre camion et voiture est type de * -- *  :  
  * un camion peut transporter plusieurs voitures
  * une voiture peut-être transpoté par plusieurs camion à différents moments.  

* l'association 'installerV' entre Vehicule et Capteur est type de 1--0..*:
  * un véhicule peut installer 0 ou plusieurs Capteurs
  * un capteur est un objet physique qui est installé dans un seul obejt
* l'association 'installerS' entre Station_de_base et Captuer est type de 1--1..*:
  * une Station_de_base doit installer au moins un capteur
  * un capteur est un objet physique qui est installé dans un seul obejt
* l'association 'détecter' entre Capteur et occurence est de type * -- *:
  * un capteut peut détecter 0 ou plusiuers occurrence
  * une occurence peut-être détecté par 0 ou différents Capteurs
* l'association de classe  'info_ItoI' entre des Staions_de_base est de type * -- *:
  * une sation_de_base peut transformer les informations à 0 ou plusieurs Staions_de_base
* l'association 'est_liée_de' entre Station_de_base et Commune est de type 1--1
  * je suppose que une commune est correspondant à une station_de_base
* l'association 'avoir lieu' entre Commune et evenement est de type 1--*
  * un évènement  est forcément dans un seul commune
  * mais dans une commune, 0 ou plusieurs évènements peut avoir lieu
* l'association de classe 'info_ItoV' entre Station_de_base et Vehicule est de type *--*
  * Une station_de_base va transformer les informations à  plusieurs véhicules
  * une véhicule reçoit les information des plusieurs stations_de_base à différents moments
* l'association de classe 'info_VtoI' entre Véhicule et Station_de_base est de type *--*
  * une vehicucle peut  transmettre les informations à plusiuers sation_de_base
  * une Sation_de_base peut recevoire les inforamtions des plusieurs véhicules
* l'association 'ItoV_produit' entre info_ItoV et evenement est de type 1--1
  * une information_ItoV est correspondant à un seul évènement
* l'association 'VtoI_produit' entre info_VtoI et evenement est de type 1--1
  * une information_VtoI est correspondant à un seul évènement

## Méthodes à concevoir

un capteur peut être ajouté transféré ou supprimé sur un noeud

## vues

* Lister tous les véhicules dans une région
* Lister toutes les communications liées à une véhicule ou à une station de base
* Trouver le véhicule le plus proche d'un certain type, par exemple, un camion de pompiers, véhicule SAMU, etc. ou un certain modèle : toutes les Citroën C5, ...
* Calculer les statistiques de passage de véhicules : par zone, par type, ...
* Supprimer de la base toutes les communications qui concernent un certain modèle du capteur (par exemple, dont le mal-fonctionnement a été démontré).
* Supprimer de la base toutes les communications qui concernent une station de base particulière (modèle défaillant)
  
## Liste des utilisateurs

on suppose qu'il y a deux utilistateurs  

* client
* administrateur
  