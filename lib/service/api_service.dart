import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/prediction_model.dart';
import '../utils/app_constants.dart';

class ApiService {
  static Future<PredictionResponse> fetchPrediction(PredictionRequest request) async {
    final response = await http.post(
      Uri.parse(AppConstants.apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(request.toJson()),
    );

    if (response.statusCode == 200) {
      return PredictionResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('API通信に失敗しました');
    }
  }
}
