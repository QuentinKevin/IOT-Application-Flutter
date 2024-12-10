import 'package:flutter/material.dart';


class LCDWidget extends StatefulWidget {
  final int maxCharactersPerLine;

  const LCDWidget({
    Key? key,
    this.maxCharactersPerLine = 16, // Nombre de caractères maximum par ligne
  }) : super(key: key);

  @override
  _LCDWidgetState createState() => _LCDWidgetState();
}

class _LCDWidgetState extends State<LCDWidget> {
  String textLine1 = ''; // Texte affiché sur la ligne 1
  String textLine2 = ''; // Texte affiché sur la ligne 2
  final FocusNode _focusNode = FocusNode(); // Pour gérer le focus
  final TextEditingController _controller = TextEditingController();

  void _updateText(String value) {
    setState(() {
      if (value.length > widget.maxCharactersPerLine) {
        // Répartir les caractères entre les deux lignes
        textLine1 = value.substring(0, widget.maxCharactersPerLine);
        textLine2 = value.substring(
          widget.maxCharactersPerLine,
          value.length > widget.maxCharactersPerLine * 2
              ? widget.maxCharactersPerLine * 2
              : value.length,
        );
      } else {
        // Si moins de 16 caractères, tout va sur la première ligne
        textLine1 = value;
        textLine2 = '';
      }
    });
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
        // Donner le focus au champ invisible
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
