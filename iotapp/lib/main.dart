import 'package:flutter/material.dart';
import 'package:iotapp/src/services/MqttService.dart';
import 'package:iotapp/src/settings/setting.dart';
import 'package:iotapp/src/widgets/iconValueWidget/iconValueWidget.dart';
import 'package:iotapp/src/widgets/statusWidget/statusWidget.dart';
import 'package:iotapp/src/widgets/textUrlWidget/textUrlWidget.dart';
import 'package:iotapp/src/widgets/boutonWidget/boutonWidget.dart';
import 'package:iotapp/src/widgets/LCDScreenWidget/LCDScreenWidget.dart';
import 'package:iotapp/src/services/Apiservice.dart';
import 'package:iotapp/src/widgets/TabBarWidget/TabBarWidget.dart';
import 'package:local_auth/local_auth.dart';

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
          contrastLevel: 1.0,
        ),
        useMaterial3: true,
      ),
      home: BiometricAuthScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class BiometricAuthScreen extends StatefulWidget {
  @override
  _BiometricAuthScreenState createState() => _BiometricAuthScreenState();
}

class _BiometricAuthScreenState extends State<BiometricAuthScreen> {
  final LocalAuthentication auth = LocalAuthentication();
  bool _isAuthenticated = false;

  Future<void> _authenticate() async {
    try {
      final bool authenticated = await auth.authenticate(
        localizedReason: 'Veuillez vous authentifier pour accéder à l\'application',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
      setState(() {
        _isAuthenticated = authenticated;
      });
      if (authenticated) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MyHomePage(title: 'IOT Application')),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    _authenticate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Authentification Biométrique'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _isAuthenticated ? 'Authentifié avec succès!' : 'Non authentifié',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _authenticate,
              child: Text('Authentifier'),
            ),
          ],
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  final MqttService mqttService = MqttService();
  late TabController _tabController;
  bool isConnected = false;
  String connectionStatus = "Connexion en cours...";
  final ApiService apiService = ApiService('https://iot-data-engineers-server.onrender.com');

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this); // 3 onglets : STAT, DATA, ROUTINE
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
    return '${data['value']} ${data['unit']}';
  }

  Future<String> fetchTemperatureValue(String equipmentId) async {
    final data = await apiService.fetchEquipmentData(equipmentId);
    return '${data['value']} ${data['unit']}';
  }

  Future<String> fetchGASValue(String equipmentId) async {
    final data = await apiService.fetchEquipmentData(equipmentId);
    return '${data['value']}';
  }

  Future<String> fetchSTEAMValue(String equipmentId) async {
    final data = await apiService.fetchEquipmentData(equipmentId);
    return '${data['value']}';
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(47, 80, 52, 1),
      body: Column(
        children: [
          // Titre principal
          Padding(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: Text(
                widget.title,
                style: const TextStyle(
                  fontFamily: 'PipBoyFont',
                  fontSize: 20,
                  color: Color(0xFF00FF00),
                ),
              ),
            ),
          ),
          // Indication de connexion
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
          const SizedBox(height: 10),

          // Écran LCD
          Center(
            child: LCDScreenWidget(
              maxCharactersPerLine: 20,
              mqttService: mqttService,
            ), // Ajout de l'écran LCD
          ),
          const SizedBox(height: 20),

          // Widgets température et humidité
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconValueWidget(
                icon: Icons.water_drop,
                fetchValue: () => fetchHumidityValue('67298243-00e1-46fb-b94e-228c8d3e675b'),
                iconColor: Colors.blue,
              ),
              // Widget pour la température
              IconValueWidget(
                icon: Icons.thermostat,
                fetchValue: () => fetchTemperatureValue('b8fe322b-5549-4627-990a-e62a6c43e381'),
                iconColor: Colors.red,
              ),
            ],
          ),

          // TabBar ajoutée via TabBarWidget
          TabBarWidget(
            tabController: _tabController,
            tabs: const ['ACTION', 'DONNÉES', 'ROUTINE'], // Onglets
          ),

          // TabBarView pour afficher le contenu des onglets
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // Onglet STAT
                ListView(
                  padding: const EdgeInsets.all(20),
                  children: [
                    ButtonGroupWidget(
                      buttonConfigs: [
                        {
                          'label': "Turn On",
                          'initialStatus': false,
                          'buttonColor': Colors.purple,
                          'widthButton': 200.0,
                          'heightButton': 60.0,
                          'onPressed': null,
                          'mqttService': mqttService,
                          'text': "Lumière",
                          'topic': "SET/LED",
                          'message': ["HIGH", "LOW"],
                        },
                      ],
                    ),
                    ButtonGroupWidget(
                      buttonConfigs: [
                        {
                          'label': "Turn On",
                          'initialStatus': false,
                          'buttonColor': Colors.purple,
                          'widthButton': 200.0,
                          'heightButton': 60.0,
                          'onPressed': null,
                          'mqttService': mqttService,
                          'text': "Allarme",
                          'topic': "SET/BUZZER",
                          'message': ["9600", "0"],
                        },
                      ],
                    ),
                    ButtonGroupWidget(
                      buttonConfigs: [
                        {
                          'label': "Turn On",
                          'initialStatus': false,
                          'buttonColor': Colors.purple,
                          'widthButton': 200.0,
                          'heightButton': 60.0,
                          'onPressed': null,
                          'mqttService': mqttService,
                          'text': "Warning",
                          'topic': "SET/RGB_LED",
                          'message': ["255,0,0", "0,0,0"],
                        },
                      ],
                    ),
                    ButtonGroupWidget(
                      buttonConfigs: [
                        {
                          'label': "Turn On",
                          'initialStatus': false,
                          'buttonColor': Colors.purple,
                          'widthButton': 200.0,
                          'heightButton': 60.0,
                          'onPressed': null,
                          'mqttService': mqttService,
                          'text': "Porte",
                          'topic': "SET/DOOR_SERVO",
                          'message': ["180", "0"],
                        },
                      ],
                    ),
                    ButtonGroupWidget(
                      buttonConfigs: [
                        {
                          'label': "Turn On",
                          'initialStatus': false,
                          'buttonColor': Colors.purple,
                          'widthButton': 200.0,
                          'heightButton': 60.0,
                          'onPressed': null,
                          'mqttService': mqttService,
                          'text': "VEntilateur",
                          'topic': "SET/FAN",
                          'message': ["180", "0"],
                        },
                      ],
                    ),
                  ],
                ),
                // Onglet DATA
                  Column(
                    children: <Widget>[
                      IconValueWidget(
                        icon: Icons.water_drop,
                        fetchValue: () => fetchGASValue("084c778c-4aa3-4f86-9782-2d9cebd443e3"),
                        iconColor: Colors.blue,
                      ),
                      // Widget pour la température
                      IconValueWidget(
                        icon: Icons.thermostat,
                        fetchValue: () => fetchSTEAMValue('e380e232-a1e3-43f7-8598-e6ee82f1d765'),
                        iconColor: Colors.red,
                      ),
                      IconValueWidget(
                        icon: Icons.water_drop,
                        fetchValue: () => fetchHumidityValue('67298243-00e1-46fb-b94e-228c8d3e675b'),
                        iconColor: Colors.blue,
                      ),
                      IconValueWidget(
                        icon: Icons.thermostat,
                        fetchValue: () => fetchTemperatureValue('b8fe322b-5549-4627-990a-e62a6c43e381'),
                        iconColor: Colors.red,
                      ),
                    ],
                  ),
                // Onglet ROUTINE
                ListView(
                  padding: const EdgeInsets.all(20),
                  children: [
                    ButtonGroupWidget(
                      buttonConfigs: [
                        {
                          'label': "Routine jour",
                          'initialStatus': true,
                          'buttonColor': Colors.purple,
                          'widthButton': Setting.sizeLarge,
                          'heightButton': Setting.sizeMedium,
                          'onPressed': null,
                          'mqttService': mqttService,
                          'text': "Routine de jour",
                          'topic': "TRIGGER/ROUTINE",
                          'message': ["DAY_MODE", "NIGHT_MODE"],
                        },
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    mqttService.disconnect();
    _tabController.dispose();
    super.dispose();
  }
}
