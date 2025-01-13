import 'dart:async';
import 'package:flutter/material.dart';

class IconValueWidget extends StatefulWidget {
  final IconData icon;
  final Future<String> Function() fetchValue; // Fonction pour récupérer la valeur
  final Color iconColor;

  const IconValueWidget({
    super.key,
    required this.icon,
    required this.fetchValue,
    required this.iconColor,
  });

  @override
  State<StatefulWidget> createState() => _IconValueWidgetState();
}

class _IconValueWidgetState extends State<IconValueWidget> {
  String value = "Chargement...";
  late Timer timer;

  @override
  void initState() {
    super.initState();
    _updateValue(); // Récupérer la valeur initiale
    timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      _updateValue(); // Mettre à jour la valeur toutes les 10 secondes
    });
  }

  @override
  void dispose() {
    timer.cancel(); // Arrêter le timer lors de la destruction du widget
    super.dispose();
  }

  Future<void> _updateValue() async {
    try {
      final newValue = await widget.fetchValue(); // Appelle la fonction passée pour récupérer la valeur
      setState(() {
        value = newValue;
      });
    } catch (e) {
      setState(() {
        value = "Erreur";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        children: [
          Icon(widget.icon, color: widget.iconColor),
          const SizedBox(width: 10),
          Text(value),
        ],
      ),
    );
  }
}
