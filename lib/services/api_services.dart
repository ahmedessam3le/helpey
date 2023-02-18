import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:helpey/constants/api_constants.dart';
import 'package:helpey/models/ai_model.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  static Future<List<AIModel>> getAIModels() async {
    try {
      var response = await http.get(
        Uri.parse(ApiConstants.modelsEndPoint),
        headers: {
          'Authorization': ApiConstants.auth,
        },
      );
      Map jsonResponse = jsonDecode(response.body);

      if (jsonResponse['error'] != null) {
        throw HttpException(jsonResponse['error']['message']);
      }
      return AIModel.getAIModels(jsonResponse['data']);
    } catch (error) {
      log('-------- getAIModels ERROR -------- \n$error');
      rethrow;
    }
  }
}
