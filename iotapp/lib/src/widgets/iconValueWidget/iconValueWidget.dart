import 'package:flutter/material.dart';

class IconValueWidget extends StatefulWidget {
  final IconData icon;
  final Future<String> futureValue; // Future pour récupérer les données dynamiquement
  final Color iconColor;

  const IconValueWidget({
    super.key,
    required this.icon,
    required this.futureValue,
    required this.iconColor,
  });

  @override
  State<StatefulWidget> createState() => _IconValueWidgetState();
}

class _IconValueWidgetState extends State<IconValueWidget> {
  late Future<String> value; // Stocke la future valeur pour cet widget

  @override
  void initState() {
    super.initState();
    value = widget.futureValue; // Associe la future valeur initiale
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        children: [
          Icon(widget.icon, color: widget.iconColor),
          const SizedBox(width: 10),
          FutureBuilder<String>(
            future: value,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Text('Chargement...');
              } else if (snapshot.hasError) {
                return const Text('Erreur');
              } else if (snapshot.hasData) {
                return Text(snapshot.data ?? 'N/A');
              } else {
                return const Text('N/A');
              }
            },
          ),
        ],
      ),
    );
  }
}
