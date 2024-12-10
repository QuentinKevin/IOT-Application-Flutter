import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl;

  ApiService(this.baseUrl);

  Future<Map<String, dynamic>> fetchEquipmentData(String equipmentId) async {
    final url = Uri.parse('$baseUrl/api/equipments/$equipmentId');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print('Réponse de l\'API pour $equipmentId : $data');
      return data;
    } else {
      throw Exception(
        'Erreur ${response.statusCode} : Impossible de récupérer les données',
      );
    }
  }
}
