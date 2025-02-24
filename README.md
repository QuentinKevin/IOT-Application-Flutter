# IOT Application Flutter

## Comment Utiliser l'application

### Installation du projet

1. Clonez le dépôt :
    ```sh
    git clone https://github.com/QuentinKevin/IOT-Application-Flutter.git
    cd IOT-Application-Flutter/iotapp
    ```

2. Installez les dépendances :
    ```sh
    flutter pub get
    ```

3. Exécutez l'application :
    ```sh
    flutter run
    ```

### Structure du projet

Le projet est structuré comme suit :

- `lib/`: Contient le code source principal de l'application.
  - [main.dart](http://_vscodecontentref_/1): Point d'entrée de l'application.
  - `src/`: Contient les services, widgets et paramètres utilisés dans l'application.
    - `services/`: Contient les services pour la connexion MQTT et les appels API.
    - `widgets/`: Contient les widgets personnalisés utilisés dans l'application.
    - `settings/`: Contient les paramètres de configuration de l'application.
- `assets/`: Contient les ressources statiques telles que les images.
- `test/`: Contient les tests unitaires et d'intégration de l'application.
- `pubspec.yaml`: Fichier de configuration des dépendances du projet.

### Développement

Pour développer et tester l'application, vous pouvez utiliser les commandes Flutter habituelles :

- Pour exécuter les tests :
    ```sh
    flutter test
    ```

- Pour analyser le code :
    ```sh
    flutter analyze
    ```

### Fonctionnalités

- **Authentification Biométrique** : Utilise l'authentification biométrique pour sécuriser l'accès à l'application.
- **Connexion MQTT** : Se connecte à un broker MQTT pour recevoir et envoyer des messages.
- **Affichage des Données** : Affiche les données de température, d'humidité, de gaz et de vapeur récupérées via des appels API.
- **Contrôle des Équipements** : Permet de contrôler divers équipements via des boutons qui envoient des messages MQTT.
- **Routines** : Permet de déclencher des routines prédéfinies pour les équipements.

### Widgets Personnalisés

- `LCDScreenWidget`: Affiche un écran LCD simulé.
- `IconValueWidget`: Affiche une icône avec une valeur récupérée via une fonction asynchrone.
- `TabBarWidget`: Affiche une barre d'onglets personnalisée.
- `ButtonGroupWidget`: Affiche un groupe de boutons pour contrôler les équipements.

### Services

- `MqttService`: Gère la connexion et la communication avec le broker MQTT.
- `ApiService`: Gère les appels API pour récupérer les données des équipements.

### Paramètres

- `Setting`: Contient les paramètres de configuration tels que les tailles des boutons.

Pour plus de détails, consultez le code source dans le répertoire `lib/`.

### Choix et difficultés

 - Il n'y a pas eu de diffculté lors du développement.
 - Nous avons été guidé sur les choix technologiques
