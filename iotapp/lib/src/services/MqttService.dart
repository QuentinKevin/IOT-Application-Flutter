import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class MqttService {
  final String broker = '61fc7071f01749b5a874046c95a0f08d.s1.eu.hivemq.cloud'; // Remplacez par votre domaine HiveMQ Cloud
  final int port = 8883; // Port sécurisé pour TLS
  final String clientIdentifier = 'flutter_client'; // Identifiant unique
  final String username = 'flutter_user'; // Remplacez par votre nom d'utilisateur HiveMQ
  final String password = 'Flutteruser1'; // Remplacez par votre mot de passe HiveMQ

  late MqttServerClient client;

  Future<void> connect() async {
    client = MqttServerClient.withPort(broker, clientIdentifier, port);
    client.logging(on: true); // Activer les logs
    client.secure = true; // Activer la connexion sécurisée
    client.keepAlivePeriod = 20;

    // Ajoutez un contexte de sécurité (optionnel pour HiveMQ Cloud)
    client.onDisconnected = onDisconnected;
    client.onConnected = onConnected;
    client.onSubscribed = onSubscribed;

    final connMessage = MqttConnectMessage()
        .withClientIdentifier(clientIdentifier)
        .authenticateAs(username, password) // Authentification avec nom d'utilisateur/mot de passe
        .startClean()
        .withWillQos(MqttQos.atMostOnce);
    client.connectionMessage = connMessage;

    try {
      print('Tentative de connexion au broker MQTT...');
      await client.connect();
    } catch (e) {
      print('Erreur de connexion : $e');
      client.disconnect();
    }

    if (client.connectionStatus!.state == MqttConnectionState.connected) {
      print('Connecté au broker HiveMQ!');
    } else {
      print(
          'Échec de connexion: ${client.connectionStatus?.state} - Retour: ${client.connectionStatus?.returnCode}');
    }
  }

  void onConnected() {
    print('Connexion réussie!');
  }

  void onDisconnected() {
    print('Déconnecté!');
  }

  void onSubscribed(String topic) {
    print('Abonné au topic: $topic');
  }

  void subscribeToTopic(String topic) {
    if (client.connectionStatus!.state == MqttConnectionState.connected) {
      client.subscribe(topic, MqttQos.atMostOnce);
    }
  }

  void publishMessage(String topic, String message) {
    if (client.connectionStatus!.state == MqttConnectionState.connected) {
      final builder = MqttClientPayloadBuilder();
      builder.addString(message);
      client.publishMessage(topic, MqttQos.atLeastOnce, builder.payload!);
    }
  }

  void disconnect() {
    client.disconnect();
    print('Déconnecté.');
  }
}
