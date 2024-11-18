import 'package:flutter/material.dart';

class LcdScreen extends StatelessWidget {
  const LcdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 300, // Largeur de l'écran
        height: 100, // Hauteur de l'écran
        decoration: BoxDecoration(
          color: Colors.green[700], // Fond vert sombre
          border: Border.all(
            color: Colors.black, // Bordure noire épaisse
            width: 4,
          ),
          borderRadius: BorderRadius.circular(8), // Coins légèrement arrondis
        ),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "This is a 2x16",
                style: TextStyle(
                  fontFamily: 'monospace', // Police rétro à chasse fixe
                  fontSize: 18,
                  color: Colors.lightGreenAccent, // Texte vert clair
                  shadows: [
                    Shadow(
                      offset: Offset(1, 1), // Décalage de l'ombre
                      color: Colors.black,
                      blurRadius: 2, // Flou de l'ombre
                    ),
                  ],
                ),
              ),
              Text(
                "line LCD Display",
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 18,
                  color: Colors.lightGreenAccent,
                  shadows: [
                    Shadow(
                      offset: Offset(1, 1),
                      color: Colors.black,
                      blurRadius: 2,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
