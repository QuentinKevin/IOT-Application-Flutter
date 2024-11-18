import 'package:flutter/material.dart';
import 'package:iotapp/src/settings/setting.dart';
import 'package:iotapp/src/widgets/iconValueWidget/iconValueWidget.dart';
import 'package:iotapp/src/widgets/statusWidget/statusWidget.dart';
import 'package:iotapp/src/widgets/textUrlWidget/textUrlWidget.dart';

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
      home: const MyHomePage(title: 'IOT Application'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(47, 80, 52, 1),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: <Widget>[
          // Titre principal
          Center(
            child: Text(
              widget.title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconValueWidget(
                  icon: Icons.thermostat,
                  value: "21°C",
                  iconColor: Color.fromARGB(255, 206, 3, 3)),
              IconValueWidget(
                  icon: Icons.water_drop,
                  value: "57%",
                  iconColor: Color.fromARGB(255, 7, 135, 194))
            ],
          ),
          const SizedBox(height: 20),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    StatusWidget(
                      label: "",
                      status: false,
                      buttonColor: Colors.purple,
                      widthButton: Setting.sizeLarge,
                      heightButton: Setting.sizeMedium,
                    ),
                    const SizedBox(width: 10),
                    const Text("C'est pas Versailles ici"),
                  ],
                ),
                const SizedBox(height: 20), // Espacement entre les lignes
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    StatusWidget(
                      label: "",
                      status: true,
                      buttonColor: Colors.purple,
                      widthButton: Setting.sizeLarge,
                      heightButton: Setting.sizeMedium,
                    ),
                    const SizedBox(width: 10),
                    const Text("Programme Routingue"),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    StatusWidget(
                      label: "",
                      status: true,
                      buttonColor: Colors.purple,
                      widthButton: Setting.sizeLarge,
                      heightButton: Setting.sizeMedium,
                    ),
                    const SizedBox(width: 20),
                    const Text("Programme Vacance"),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),
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
}
