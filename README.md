# Conception_developpement_BDD_MERISE_mini-projet-Anissa_MOHAMED
Projet de conception de base de données (méthode MERISE) pour la maintenance aéronautique (MRO), inspiré de Dassault Aviation. Il contient l'analyse des besoins via prompt IA (RICARDO), le dictionnaire de données optimisé et un MCD normé (3FN, entité faible, association récursive). Réalisé pour le module Base de données 1 : concepts de base 


# Mini-Projet : Conception et développement d'une base de données - PARTIE 1
**Module :** TI404 – Bases de données 1 : Concepts de base  
**Mon Nom :** Anissa MOHAMED
**Sujet choisi :** Data Engineering appliqué à la maintenance aéronautique (Inspiré de Dassault Aviation).

---

## Étape 1 : Analyse des besoins

### 1. Le prompt utilisé
Afin de simuler les échanges avec l'entreprise cliente, nous avons utilisé le framework RICARDO pour concevoir le prompt suivant soumis à l'IA :

> "Tu travailles dans le domaine du Data engineering. Ton entreprise a comme activité la maintenance, la réparation et la révision (MRO) d'avions d'affaires et de défense. C’est une entreprise industrielle de haute technologie comme Dassault aviation. 
> Les données ont été collectées sur les caractéristiques techniques des appareils, les contrats d'acquisition par les pays/clients, les programmes de maintenance (MCO) et les performances de vol. 
> Inspire-toi du site web officiel de Dassault Aviation (Avions civils et militaires / Support et Services).
> Ton entreprise veut appliquer MERISE pour concevoir un système d'information. Tu es chargé de la partie analyse, c’est-à-dire de collecter les besoins auprès de l’entreprise. Elle a fait appel à un étudiant en ingénierie informatique pour réaliser ce projet, tu dois lui fournir les informations nécessaires pour qu’il applique ensuite lui-même les étapes suivantes de conception et développement de la base de données. 
> D’abord, établis les règles de gestions des données de ton entreprise sous la forme d'une liste à puce. Elle doit correspondre aux informations que fournit quelqu’un qui connaît le fonctionnement de l’entreprise, mais pas comment se construit un système d’information. 
> Ensuite, à partir de ces règles, fournis un dictionnaire de données brutes avec les colonnes suivantes, regroupées dans un tableau : signification de la donnée, type, taille en nombre de caractères ou de chiffres. Il doit y avoir entre 25 et 35 données. Il sert à fournir des informations supplémentaires sur chaque donnée (taille et type) mais sans a priori sur comment les données vont être modélisées ensuite. 
> Fournis donc les règles de gestion et le dictionnaire de données."

### 2. Résultat généré par l'IA

#### Règles métier
* Un avion appartient à un programme spécifique (ex: Rafale, Falcon 6X, Falcon 10X).
* Chaque modèle d'avion possède des caractéristiques techniques fixes (envergure, longueur, masse à vide).
* Un client (pays comme l'Inde, ou une entreprise privée) passe une commande pour un nombre précis d'appareils.
* Chaque avion est identifié par un numéro unique et peut être de type "Monoplace" ou "Biplace".
* Les avions sont stationnés ou entretenus dans des centres de maintenance répartis mondialement.
* Un client peut souscrire à un contrat de support spécifique (ex: contrats Ravel pour le Rafale, ou FalconCare).
* On enregistre pour chaque modèle son autonomie maximale (en km) et sa vitesse de pointe (Mach).
* L'entreprise suit les émissions de CO2 et le pourcentage de carburant durable (SAF) utilisé par les appareils.
* Lors de sa maintenance, un avion subit des interventions datées et décrites par les techniciens.

#### Dictionnaire de données 
| Signification de la donnée | Type SQL | Taille (Caractères / Chiffres) |
| :--- | :--- | :--- |
| Identifiant unique du client | VARCHAR | 10 caractères |
| Nom du pays ou de l'entreprise cliente | VARCHAR | 100 caractères |
| Code pays du client (Norme ISO) | VARCHAR | 2 caractères |
| Numéro de série unique de l'avion | VARCHAR | 20 caractères |
| Nom du modèle d'avion (ex: Rafale...) | VARCHAR | 50 caractères |
| Catégorie de l'appareil (Civil / Militaire) | VARCHAR | 15 caractères |
| Envergure de l'appareil (en mètres) | DECIMAL | 5 chiffres, 2 décimales |
| Longueur de l'appareil (en mètres) | DECIMAL | 5 chiffres, 2 décimales |
| Hauteur de l'appareil (en mètres) | DECIMAL | 5 chiffres, 2 décimales |
| Masse à vide (en kilos) | INT | - |
| Masse maximale au décollage (en kilos) | INT | - |
| Capacité d'emport externe (en kilos) | INT | - |
| Autonomie maximale de vol (en kilomètres) | INT | - |
| Vitesse maximale (en Mach) | DECIMAL | 3 chiffres, 2 décimales |
| Configuration de la cabine | VARCHAR | 15 caractères |
| Nom du moteur équipé | VARCHAR | 50 caractères |
| Identifiant unique du vol | VARCHAR | 15 caractères |
| Date du vol enregistré | DATE | AAAA-MM-JJ |
| Aéroport de départ (Code norme OACI) | VARCHAR | 4 caractères |
| Aéroport d'arrivée (Code norme OACI) | VARCHAR | 4 caractères |
| Durée totale du vol (en minutes) | INT | - |
| Numéro unique de l'intervention | VARCHAR | 15 caractères |
| Date de début de l'intervention | DATE | AAAA-MM-JJ |
| Descriptif détaillé de la maintenance | VARCHAR | 255 caractères |
| Identifiant de la ville du centre | INT | - |
| Nom de la ville du centre | VARCHAR | 100 caractères |
| Nom du centre de maintenance | VARCHAR | 100 caractères |
| Nom du contrat de support | VARCHAR | 50 caractères |
| Formule du contrat | VARCHAR | 20 caractères |
| Taux de disponibilité garanti (en %) | INT | - |
| Pourcentage de carburant durable (SAF) | INT | - |
| Réduction d'émissions de CO2 estimée | INT | - |

INT à 32 bits par défaut 
---

## Étape 2 : Modèle Conceptuel de Données (MCD)

### 1. Schéma du MCD
MCD_Dassault.png

*(Note : le fichier source de ce MCD est disponible dans ce dépôt Github).*

Ajout de 1_creation.sql : Création des tables physiques avec gestion automatique de l'intégrité référentielle (ON DELETE CASCADE / SET NULL).

Ajout de 2_contraintes.sql : Implémentation des règles de validation métier (CHECK) et des contraintes d'unicité (UNIQUE).

Ajout de 3_insertion.sql : Remplissage de la base de données (modèles, avions, clients, vols, maintenance).

Ajout de 4_interrogation.sql : 20 requêtes d'extraction avancées (jointures, sous-requêtes, agrégations) répondant aux scénarios définis.

Voici votre code Markdown structuré, embelli et formaté, prêt à être copié-collé dans votre fichier `README.md` sur GitHub.

J'y ai intégré une présentation claire pour le Modèle Logique de Données (MLD) et j'ai ajouté des liens relatifs (cliquables sur GitHub) pointant directement vers les 4 fichiers SQL de votre projet.

---

## III. Troisième étape : MLD et MPD

### III.A. Modèle Logique de Données (MLD)

*Note : Les clés primaires sont en **gras**, les clés étrangères sont précédées d'un `#`, et les attributs optionnels sont suivis d'un `*`.*

* **Modele** = (**Id_modele** INT, nom_modele VARCHAR(50), envergure DECIMAL(5,2), longueur_ DECIMAL(5,2), hauteur DECIMAL(5,2), masse_vide INT, masse_max INT, capacite_emport INT, Categorie VARCHAR(15), Autonomie INT, vitesse_mach DECIMAL(3,2), nom_moteur VARCHAR(50))
* **CONTRAT** = (**id_contrat_** INT, nom_contrat VARCHAR(50), formule VARCHAR(20), taux_de_dispo INT)
* **Pays**  = (**code_pays** VARCHAR(2), nom_pays VARCHAR(50))
* **VILLE** = (**#code_pays**, **id_ville** INT, nom_ville VARCHAR(50))
* **CLIENT** = (**#code_pays**, **id_client** INT, nom_client VARCHAR(50))
* **AVION** = (**#Id_modele**, **Num_serie** VARCHAR(20), configuration_cabine VARCHAR(15), #id_contrat_*, #(#code_pays, id_client)*)
* **VOL** = (**#(#Id_modele, Num_serie)**, **id_vol** VARCHAR(15), date_vol DATE, duree_vol_minutes INT, aeroport_depart VARCHAR(4), aeroport_arrivee VARCHAR(50), reduc_co2 INT, pourcentage_carburant_vert INT)
* **CENTRE_MAINTENANCE** = (**#(#code_pays, id_ville)**, **id_centre** VARCHAR(15), nom_centre VARCHAR(100), #(#(#code_pays_principal, id_ville_principal), id_centre_principal)*)
* **INTERVENTION** = (**#(#Id_modele, Num_serie)**, **num_intervention_avion** INT, descriptif VARCHAR(255), date_debut DATE, #(#(#code_pays, id_ville), id_centre))

### III.B. Modèle Physique de Données (MPD) et Contraintes

La traduction de ce modèle en base de données physique est disponible dans les scripts suivants :

* 1_creation.sql * : Script de création des tables incluant la gestion automatique des suppressions et modifications (ON DELETE CASCADE / SET NULL).
* _contraintes.sql * : Script d'implémentation des contraintes de validation métier (CHECK) et d'unicité.

---

## IV. Quatrième étape : Insertion des données

Les données de ce projet ont été générées automatiquement à l'aide d'une IA générative en utilisant le prompt structuré suivant :

> **Prompt utilisé :**
> Peux-tu me donner les requêtes SQL d’insertion permettant de remplir la base de données dont le modèle relationnel est le suivant :
> *Modele = (Id_modele INT, nom_modele VARCHAR(50), envergure DECIMAL(5,2), longueur_ DECIMAL(5,2), hauteur DECIMAL(5,2), masse_vide INT, masse_max INT, capacite_emport INT, Categorie VARCHAR(15), Autonomie INT, vitesse_mach DECIMAL(3,2), nom_moteur VARCHAR(50)); CONTRAT = (id_contrat_ INT, nom_contrat VARCHAR(50), formule VARCHAR(20), taux_de_dispo INT); Pays = (code_pays VARCHAR(2), nom_pays VARCHAR(50)); VILLE = (#code_pays, id_ville INT, nom_ville VARCHAR(50)); CLIENT = (#code_pays, id_client INT, nom_client VARCHAR(50)); AVION = (#Id_modele, Num_serie VARCHAR(20), configuration_cabine VARCHAR(15), #id_contrat_*, #(#code_pays, id_client)*); VOL = (#(#Id_modele, Num_serie), id_vol VARCHAR(15), date_vol DATE, duree_vol_minutes INT, aeroport_depart VARCHAR(4), aeroport_arrivee VARCHAR(50), reduc_co2 INT, pourcentage_carburant_vert INT); CENTRE_MAINTENANCE = (#(#code_pays, id_ville), id_centre VARCHAR(15), nom_centre VARCHAR(100), #(#(#code_pays_principal, id_ville_principal), id_centre_principal)*); INTERVENTION = (#(#Id_modele, Num_serie), num_intervention_avion INT, descriptif VARCHAR(255), date_debut DATE, #(#(#code_pays, id_ville), id_centre));*
> Les clés primaires correspondent aux id, sauf si autre chose est précisé (quand c'est un attribut composé). Les clés étrangères sont identifiées par les #, et ont le même nom que les clés primaires auxquelles elles font référence.
> Génère 5 modèles d'avions (incluant des vrais modèles comme 'Rafale', 'Falcon 10X', 'Mirage 2000 D'), 4 pays (dont 'FR' pour la France), 5 villes, 4 clients (dont l'Armée de l'Air française et un privé), 3 contrats (dont 'FalconCare'), 10 avions physiques, 10 vols (avec des codes aéroports de 4 caractères comme 'LFPG'), 3 centres de maintenance, et 5 interventions. Assure-toi que les valeurs respectent strictement les contraintes définies précédemment (catégories 'Civil', 'Militaire' ou 'AVSIMAR', pourcentages entre 0 et 100, code pays en majuscule, vitesses et dimensions positives).
> Les clés étrangères doivent faire référence aux clés primaires existantes : donne les lignes en commençant par remplir les tables dans lesquelles il n'y a pas de clés étrangères, puis les tables dans lesquelles les clés étrangères font références à des clés primaires des tables déjà remplies. Je souhaite copier-coller le tout sur MySQL Workbench.

*Le script SQL résultant de ce prompt est disponible ici :*

* 3_insertion.sql*

---

## V. Cinquième étape : Interrogation de la base (Scénarios d'utilisation)

*Afin de démontrer la polyvalence et la robustesse de notre modèle relationnel, la base de données a été conçue pour répondre aux besoins croisés de plusieurs départements. L'ensemble des requêtes permettant d'extraire les données pour les rôles ci-dessous est centralisé dans le fichier suivant :*

*  4_interrogation.sql*

### 1. Le Responsable du Support Opérationnel (MCO) - *Scénario Principal*

* **Rôle :** Responsable du Maintien en Condition Opérationnelle (MCO) et de l'Analyse de Flotte.
* **Contexte :** Sa mission quotidienne est de garantir que les avions des clients (gouvernements et entreprises privées) volent en toute sécurité et respectent les garanties contractuelles. Il supervise un réseau mondial de centres de maintenance et gère des contrats stricts (ex: *FalconCare*) visant à assurer la prévisibilité des coûts et à limiter l'immobilisation des avions au sol (AOG - Aircraft On Ground). De plus, avec les nouvelles normes environnementales, il suit la télémétrie des vols pour évaluer l'empreinte carbone.
* **Données à extraire :**
* Les caractéristiques des modèles pour vérifier leurs capacités de vol.
* Le suivi des contrats d'entretien (taux de disponibilité garanti).
* Le volume de vol de chaque appareil et la consommation de carburant durable.
* La charge de travail des différents centres de maintenance.
* L'identification rapide des avions n'ayant pas encore subi leurs contrôles de routine.



### 2. L'Auditeur Interne QSE (Qualité, Sécurité, Environnement) - *Scénario Bonus*

* **Rôle :** Auditeur Interne QSE au sein du groupe aéronautique.
* **Contexte :** Dans le cadre du renouvellement des certifications ISO de l'entreprise et de la préparation du rapport annuel RSE, il est chargé de réaliser un audit complet de la flotte en service. Il s'assure que les règles de sécurité sont respectées (suivi strict de la maintenance), vérifie la cohérence juridique des contrats de support, et prouve par les chiffres l'engagement écologique de l'entreprise.

### 3. Le Directeur de la Stratégie Commerciale et Environnementale - *Scénario Bonus*

* **Rôle :** Directeur de la Stratégie Commerciale et Environnementale.
* **Contexte :** Il prépare le grand bilan annuel destiné au comité de direction. Son objectif est d'évaluer la pénétration des produits sur le marché mondial, la rentabilité des services associés (contrats de maintenance), et d'auditer la transition écologique de la flotte en activité. Il croise les données du catalogue avec la réalité de l'exploitation par les clients.
* **Données à extraire :**
* **Audit des performances :** Identifier les modèles phares et comparer leurs spécifications techniques.
* **Analyse du marché :** Cartographier la clientèle stratégique par pays et les flottes spécifiques.
* **Bilan environnemental :** Surveiller les itinéraires empruntés, le temps de vol cumulé et l'effort écologique (carburant d'aviation durable, réduction CO2).
* **Évaluation des services :** Vérifier le dimensionnement des contrats (ex: formules Premium) et surveiller la charge globale du réseau de maintenance.
