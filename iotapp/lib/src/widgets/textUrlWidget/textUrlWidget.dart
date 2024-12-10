import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class TextUrlWidget extends StatelessWidget {
  final String label;
  final String url;

  const TextUrlWidget({super.key, required this.label, required this.url});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => launchUrlString(url),
      child: Text(
        label,
        style: const TextStyle(
          fontFamily: 'PipBoyFont', // La police personnalisée
          fontSize: 18, // Taille du texte
          color: Color(0xFF00FF00), // Couleur verte typique du Pip-Boy
          backgroundColor: Color.fromARGB(38, 0, 255, 0), // Fond 

        ),
      ),
    );
  }
}
