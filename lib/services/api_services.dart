import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:helpey/constants/api_constants.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  static Future<void> getAIModels() async {
    try {
      var response = await http.get(
        Uri.parse(ApiConstants.modelsEndPoint),
        headers: {
          'Authorization': ApiConstants.auth,
        },
      );
      Map jsonResponse = jsonDecode(response.body);

      if (jsonResponse['error'] != null) {
        debugPrint(
            '-------- getAIModels ERROR -------- \n${jsonResponse['error']['message']}');
        throw HttpException(jsonResponse['error']['message']);
      }
      debugPrint('-------- getAIModels RESPONSE -------- \n$jsonResponse');
    } catch (error) {
      debugPrint('-------- getAIModels ERROR -------- \n$error');
    }
  }
}
