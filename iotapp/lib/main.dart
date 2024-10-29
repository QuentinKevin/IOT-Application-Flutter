import 'package:flutter/material.dart';
import 'package:iotapp/src/settings/setting.dart';
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
                    ListTile(
                      leading: StatusWidget(
                                  label: "",
                                  status: false,
                                  buttonColor: Colors.purple,
                                  widthButton: Setting.sizeLarge,
                                  heightButton: Setting.sizeMedium,
                      ),  
                      title: const Text('Bouton gauche'),
                    ),
                    ListTile(
                      leading: StatusWidget(
                                  label: "",
                                  status: false,
                                  buttonColor: Colors.purple,
                                  widthButton: Setting.sizeLarge,
                                  heightButton: Setting.sizeMedium,
                                ),
                      title: const TextUrlWidget(
                        label: "Lien Github",
                        url: "https://github.com",
                        ),
                    ),
                  ],
                ),
              ),
    );
  }
}
