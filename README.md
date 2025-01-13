# **PharmaPlus** 🏥  
**Gestion des Pharmacies avec Flutter - Clean Architecture**  

## **Description**  
**PharmaPlus** est une application mobile développée en Flutter pour la gestion des pharmacies, permettant aux utilisateurs de :  
- Rechercher des pharmacies à proximité (localisation) (a venir).  
- Passer des commandes ou réservations (a venir).  
- Obtenir des informations sur les horaires d'ouverture des pharmacies de garde.  

Ce projet suit les principes de la **Clean Architecture** pour garantir un code maintenable, modulaire et évolutif.

---

## **Table des Matières**  
1. [Caractéristiques](#caractéristiques)  
2. [Structure du projet](#structure-du-projet)  
3. [Technologies utilisées](#technologies-utilisées)  
4. [Installation et configuration](#installation-et-configuration)  
5. [Fonctionnalités principales](#fonctionnalités-principales)  
6. [Capture d'écran](#capture-décran)  
7. [Contributeurs](#contributeurs)  
8. [Licence](#licence)  

---

## **Caractéristiques**  
- **Recherche de pharmacies** : Trouver les pharmacies autour de vous grâce à la géolocalisation.  
- **Gestion des médicaments** : Vérifier la disponibilité des produits en stock.  
- **Notifications** : Recevoir des alertes pour les promotions ou médicaments disponibles.(a venir)  
- **Pharmacies de garde** : Trouver les pharmacies ouvertes pendant les heures non ouvrables.  
- **Réservations** : Réserver des médicaments en ligne avant de se déplacer.(a venir)  

---

## **Structure du projet**  
L'application est basée sur les principes de **Clean Architecture**, divisée en trois couches principales :  

### 1. **Presentation Layer**  
- Contient les **widgets** et **screens** de l'interface utilisateur.  
- Utilise **State Management (Bloc.)** pour gérer l'état de l'application.  

### 2. **Domain Layer**  
- Contient les **Use Cases**, les **Interfaces** et les entités principales.  
- Exemples : RecherchePharmacie, RéservationMédicament.  

### 3. **Data Layer**  
- Gère les sources de données telles que les **APIs** et la **base de données locale (SQLite)**.  
- Implémente des **Repositories** pour l'accès aux données.  

### Architecture en résumé :  
```
lib/
│
├── data/          # Accès aux données (APIs, DB locale)
├── domain/        # Logique métier, UseCases
├── presentation/  # UI et gestion des états
└── core/          # Constantes, Helpers, Utils
```

---

## **Technologies utilisées**  
### **Frontend**  
- **Flutter** : Cadre de développement cross-platform.  
- **State Management** : Provider / Riverpod / Bloc (à spécifier selon votre choix).  
- **HTTP/Dio** : Pour la consommation des APIs REST.  
- **Geolocator** : Pour la géolocalisation des pharmacies.  
- **Flutter Local Notifications** : Pour gérer les rappels ou alertes.(a venir)    

### **Backend**  
- **Laravel**.  
- APIs pour la gestion des médicaments et pharmacies.  

### **Base de données**  
- **Locale** : SQLitepour les données hors ligne.  
- **Distante** : MySQL.  

---

## **Installation et configuration**  
### **Prérequis**  
- Flutter 3.10 ou version ultérieure.  
- Android Studio ou VS Code installé.  
- Un backend fonctionnel pour les APIs REST.  

### **Étapes d'installation**  
1. **Clonez le projet :**  
   ```bash
   git clone https://github.com/OmarDIOP0/clean-architecture-Flutter.git
   cd clean-architecture-Flutter
   ```  

2. **Installez les dépendances :**  
   ```bash
   flutter pub get
   ```  

3. **Configurez votre environnement :**  
   Créez un fichier `.env` pour vos clés API et URL backend :  
   ```
   GOOGLE_MAPS_API_KEY=VOTRE_CLE
   ```

4. **Lancez l'application :**  
   ```bash
   flutter run
   ```

---

## **Fonctionnalités principales**  
- **Page d'accueil** : Liste des pharmacies avec leurs informations.  
- **Moteur de recherche🏪** : Rechercher des médicaments ou pharmacies spécifiques.  
- **Notifications push🔔** : Alertes sur les pharmacies de garde ou disponibilités.(a venir) 
- **Cartographie🌍 ** : Localisation des pharmacies sur une carte interactive. (a venir)   
- **Profil utilisateur** : Gestion des favoris et historique des commandes. (a venir)   

---

## **Contributeurs**  
- **Omar DIOP** (Développeur Fullstack)   

---

## **Contact**  
Pour toute question ou demande d'information :  
📧 **omardiop1@esp.sn**  
