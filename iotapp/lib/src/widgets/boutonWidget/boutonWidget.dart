import 'package:flutter/material.dart';
import 'package:iotapp/src/widgets/statusWidget/statusWidget.dart'; 


class ButtonGroupWidget extends StatelessWidget {
  final List<Map<String, dynamic>> buttonConfigs;

  const ButtonGroupWidget({
    super.key,
    required this.buttonConfigs,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: buttonConfigs.map((config) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                StatusWidget(
                  label: config['label'],
                  initialStatus: config['initialStatus'],
                  buttonColor: config['buttonColor'],
                  widthButton: config['widthButton'],
                  heightButton: config['heightButton'],
                  onPressed: config['onPressed'],
                  mqttService: config['mqttService'],
                  topic: config['topic'],
                  message: config['message'],
                ),
                const SizedBox(width: 10),
                Text(
                  config['text'],
                  style: const TextStyle(
                    fontFamily: 'PipBoyFont',
                    color: Color(0xFF00FF00), // Vert fluo typique
                    backgroundColor: Color.fromARGB(38, 0, 255, 0), // Fond
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
