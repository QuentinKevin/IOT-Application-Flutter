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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
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
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Container(
          alignment: Alignment.center,
          child:
            ListView(
                  children: <Widget>[
                    const IconValueWidget(
                      icon: Icons.thermostat,
                      value: "21°C",
                      iconColor: Colors.red
                    ),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(Setting.paddingLarge, 0, 0,0),
                        child: ListTile(
                        leading: StatusWidget(
                                  label: "",
                                  status: false,
                                  buttonColor: Colors.purple,
                                  widthButton: Setting.sizeLarge,
                                  heightButton: Setting.sizeMedium,
                      ),  
                      title: const Text("C'est pas Versailles ici"),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(Setting.paddingLarge, 0, 0,0),
                        child: ListTile(
                              leading: StatusWidget(
                                label: "",
                                status: true,
                                buttonColor: Colors.purple,
                                widthButton: Setting.sizeLarge,
                                heightButton: Setting.sizeMedium,
                              ),
                          title: const Text('Programme Routingue'),
                        ),
                    ),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(Setting.paddingLarge, 0, 0,0),
                        child: ListTile(
                        leading: StatusWidget(
                                  label: "",
                                  status: true,
                                  buttonColor: Colors.purple,
                                  widthButton: Setting.sizeLarge,
                                  heightButton: Setting.sizeMedium,
                                ),
                      title: const Text('Programme Vacance'),
                        ),
                    ),

                    const TextUrlWidget(
                      label: "Lien Github",
                      url: "https://github.com/QuentinKevin/IOT-Application-Flutter",
                    ),
                    const TextUrlWidget(
                      label: "Lien Figma",
                      url: "https://www.figma.com/design/JfYg0CGDHf6rhzzkOCydZv/IOT-Application?node-id=13-61&node-type=instance&t=syIlL1rSvyzmCFA0-0",
                    ),
                  ],
                ),
              ),
    );
  }
}
