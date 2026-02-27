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
