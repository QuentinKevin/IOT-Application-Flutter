import 'package:flutter/material.dart';
import 'package:iotapp/src/services/MqttService.dart';
import 'package:iotapp/src/settings/setting.dart';
import 'package:iotapp/src/widgets/iconValueWidget/iconValueWidget.dart';
import 'package:iotapp/src/widgets/statusWidget/statusWidget.dart';
import 'package:iotapp/src/widgets/textUrlWidget/textUrlWidget.dart';

import 'src/widgets/LCDScreenWidget/LCDScreenWidget.dart';
import 'src/widgets/dynamiqueEquipment/dynamiqueEquipment.dart';
import 'package:iotapp/src/services/Apiservice.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IOT APP',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromRGBO(47, 80, 52, 1),
            brightness: Brightness.dark,
            contrastLevel: 1.0),
        useMaterial3: true,
      ),
      home: MyHomePage(title: 'IOT Application'),
      debugShowCheckedModeBanner: false,
    );
  }
}

// ignore: must_be_immutable
class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.title});

  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final MqttService mqttService = MqttService();
  bool isConnected = false;
  String connectionStatus = "Connexion en cours...";

  @override
  void initState() {
    super.initState();
    _connectToBroker();
  }

  Future<void> _connectToBroker() async {
    try {
      await mqttService.connect();
      setState(() {
        isConnected = true;
        connectionStatus = "Connecté au broker MQTT !";
      });
    } catch (e) {
      setState(() {
        isConnected = false;
        connectionStatus = "Erreur de connexion : $e";
      });
    }
  }
  Future<String> fetchHumidityValue(String equipmentId) async {
    final data = await apiService.fetchEquipmentData(equipmentId);
    return '${data['value']} ${data['unit']}'; // Récupère la valeur et l'unité
  }
  Future<String> fetchTemperatureValue(String equipmentId) async {
    final data = await apiService.fetchEquipmentData(equipmentId);
    return '${data['value']} ${data['unit']}'; // Exemple de valeur pour la température
  }
  ApiService apiService = ApiService('https://iot-data-engineers-server.onrender.com');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(47, 80, 52, 1),
      // backgroundColor: const Color.fromARGB(59, 124, 124, 124),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: <Widget>[
          // Titre principal
          Center(
            child: Text(
              widget.title,
              style: const TextStyle(
                fontFamily: 'PipBoyFont',
                fontSize: 20,
                color: Color(0xFF00FF00), // Vert fluo typique
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Indication de l'état de connexion
          Center(
            child: Text(
              connectionStatus,
              style: TextStyle(
                fontFamily: 'PipBoyFont',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isConnected ? const Color(0xFF00FF00) : Colors.red,
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Écran LCD
          const Center(
            child: LCDWidget(), // Ajout de l'écran LCD
          ),
          const SizedBox(height: 20),

          // Widgets température et humidité
           Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconValueWidget(
                icon: Icons.water_drop,
                futureValue: fetchHumidityValue('67298243-00e1-46fb-b94e-228c8d3e675b'),
                iconColor: Colors.blue,
              ),
              // Widget pour la température
            IconValueWidget(
              icon: Icons.thermostat,
              futureValue: fetchTemperatureValue('b8fe322b-5549-4627-990a-e62a6c43e381'),
              iconColor: Colors.red,
            ),
            ],
          ),
         
          // Boutons et leurs textes associés
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    StatusWidget(
                      label: "Turn On",
                      initialStatus: false,
                      buttonColor: Colors.purple,
                      widthButton: 200,
                      heightButton: 60,
                      onPressed: () {
                        mqttService.publishMessage('home/lights', 'on');
                      },
                      mqttService: mqttService,
                    ),
                    const SizedBox(width: 10),
                    const Text("C'est pas Versailles ici",
                      style: TextStyle(
                        fontFamily: 'PipBoyFont',
                        color: Color(0xFF00FF00), // Vert fluo typique
                        backgroundColor: Color.fromARGB(38, 0, 255, 0), // Fond 
                      ),
                    ),
                    
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    StatusWidget(
                      label: "",
                      initialStatus: true,
                      buttonColor: Colors.purple,
                      widthButton: Setting.sizeLarge,
                      heightButton: Setting.sizeMedium,
                      onPressed: () {
                        mqttService.publishMessage('routine/start', 'start');
                      },
                      mqttService: mqttService,
                    ),
                    const SizedBox(width: 10),
                    const Text("Programme Routingue",
                      style: TextStyle(
                        fontFamily: 'PipBoyFont',
                        color: Color(0xFF00FF00), // Vert fluo typique
                        backgroundColor: Color.fromARGB(38, 0, 255, 0), // Fond 
                      ),
                      ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    StatusWidget(
                      label: "",
                      initialStatus: true,
                      buttonColor: Colors.purple,
                      widthButton: Setting.sizeLarge,
                      heightButton: Setting.sizeMedium,
                      onPressed: () {
                        mqttService.publishMessage('vacation/start', 'start');
                      },
                      mqttService: mqttService,
                    ),
                    const SizedBox(width: 20),
                    const Text("Programme Vacance",
                      style: TextStyle(
                        fontFamily: 'PipBoyFont',
                        color: Color(0xFF00FF00), // Vert fluo typique
                        backgroundColor: Color.fromARGB(38, 0, 255, 0), // Fond 
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Liens GitHub et Figma
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextUrlWidget(
                label: "Lien Github",
                url: "https://github.com/QuentinKevin/IOT-Application-Flutter",
              ),
              SizedBox(width: 20),
              TextUrlWidget(
                label: "Lien Figma",
                url:
                    "https://www.figma.com/design/JfYg0CGDHf6rhzzkOCydZv/IOT-Application?node-id=13-61&node-type=instance&t=syIlL1rSvyzmCFA0-0",
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    mqttService.disconnect();
    super.dispose();
  }
}
