import 'dart:async';

import 'package:flutter/material.dart';
import '../../services/Apiservice.dart';
late Timer timer;

class EquipmentDetailsWidget extends StatefulWidget {
  final String equipmentId;
  final ApiService apiService;

  const EquipmentDetailsWidget({
    super.key,
    required this.equipmentId,
    required this.apiService,
  });

  @override
  State<StatefulWidget> createState() => _EquipmentDetailsWidgetState();
}

class _EquipmentDetailsWidgetState extends State<EquipmentDetailsWidget> {
  late Future<Map<String, dynamic>> _equipmentData;

  @override
  void initState() {
    super.initState();
    _equipmentData = widget.apiService.fetchEquipmentData(widget.equipmentId);
    timer = Timer.periodic(const Duration(seconds: 30), (timer) {
      setState(() {
        _equipmentData =
            widget.apiService.fetchEquipmentData(widget.equipmentId);
      });
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: _equipmentData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(
            child: Text(
              'Erreur : ${snapshot.error}',
              style: const TextStyle(color: Colors.red),
            ),
          );
        } else if (snapshot.hasData) {
          final data = snapshot.data!;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Nom : ${data['name'] ?? 'N/A'}'),
              Text('État : ${data['state'] == true ? "Activé" : "Désactivé"}'),
              Text('Valeur : ${data['value'] ?? 'N/A'} ${data['unit'] ?? ''}'),
            ],
          );
        } else {
          return const Text('Aucune donnée disponible');
        }
      },
    );
  }
}
