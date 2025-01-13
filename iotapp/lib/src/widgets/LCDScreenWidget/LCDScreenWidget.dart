import 'package:flutter/material.dart';
import 'package:iotapp/src/services/MqttService.dart';
import 'package:mqtt_client/mqtt_client.dart';

class LCDScreenWidget extends StatefulWidget {
  final int maxCharactersPerLine;
  final MqttService mqttService; // Ajoutez cette ligne pour passer le service MQTT

  LCDScreenWidget({required this.maxCharactersPerLine, required this.mqttService});

  @override
  _LCDScreenWidgetState createState() => _LCDScreenWidgetState();
}

class _LCDScreenWidgetState extends State<LCDScreenWidget> {
  late String textLine1 = "";
  late String textLine2 = "";
  final _focusNode = FocusNode();
  final _controller = TextEditingController();
  final MqttService mqttService = MqttService();

  void _updateText(String value) {
    setState(() {
      if (value.length > widget.maxCharactersPerLine) {
        textLine1 = value.substring(0, widget.maxCharactersPerLine);
        textLine2 = value.substring(
          widget.maxCharactersPerLine,
          value.length > widget.maxCharactersPerLine * 2
              ? widget.maxCharactersPerLine * 2
              : value.length,
        );
      } else {
        textLine1 = value;
        textLine2 = '';
      }
      _publishToMqtt(textLine1, textLine2); // Publiez le texte mis à jour
    });
  }

  void _publishToMqtt(String line1, String line2) {
    final message = '$line1\n$line2';
    widget.mqttService.publishMessage('SET/LCD_DISPLAY', message); 
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _focusNode.requestFocus();
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Écran LCD
          Container(
            width: 300,
            height: 100, // Limiter strictement à la hauteur pour 2 lignes
            decoration: BoxDecoration(
              color: Colors.green[700], // Fond vert sombre
              border: Border.all(
                color: Colors.black, // Bordure noire épaisse
                width: 4,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Ligne 1
                Text(
                  textLine1.padRight(widget.maxCharactersPerLine),
                  style: const TextStyle(
                    fontFamily: 'cf-lcd-521',
                    fontSize: 20,
                    color: Color(0xFF00FF00),
                  ),
                ),
                // Ligne 2
                Text(
                  textLine2.padRight(widget.maxCharactersPerLine),
                  style: const TextStyle(
                    fontFamily: 'cf-lcd-521',
                    fontSize: 20,
                    color: Color(0xFF00FF00),
                  ),
                ),
              ],
            ),
          ),
          // Champ de saisie invisible
          TextField(
            focusNode: _focusNode, // Focus géré dynamiquement
            controller: _controller,
            maxLength: widget.maxCharactersPerLine * 2, // Limite à 2 lignes
            onChanged: _updateText, // Met à jour les lignes dynamiquement
            style: const TextStyle(
              fontSize: 0, // Rendre le texte invisible
              color: Colors.transparent,
            ),
            decoration: const InputDecoration(
              border: InputBorder.none, // Pas de bordure visible
              counterText: '', // Pas de compteur
            ),
            cursorColor: Colors.transparent, // Pas de curseur visible
          ),
        ],
      ),
    );
  }
}
