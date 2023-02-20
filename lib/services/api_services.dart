import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:helpey/constants/api_constants.dart';
import 'package:helpey/models/ai_model.dart';
import 'package:helpey/models/chat_model.dart';
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

  static Future<List<ChatModel>> sendMessage({
    required String aiModel,
    required String message,
  }) async {
    try {
      var response = await http.post(
        Uri.parse(ApiConstants.completionsEndPoint),
        headers: {
          'Authorization': ApiConstants.auth,
          'Content-Type': ApiConstants.applicationJson,
        },
        body: jsonEncode({
          'model': aiModel,
          'prompt': message,
          'max_tokens': 100,
        }),
      );
      Map jsonResponse = jsonDecode(response.body);

      if (jsonResponse['error'] != null) {
        throw HttpException(jsonResponse['error']['message']);
      }

      List<ChatModel> chatList = [];
      if (jsonResponse['choices'].isNotEmpty) {
        chatList = List.generate(
          jsonResponse['choices'].length,
          (index) {
            return ChatModel(
                message: jsonResponse['choices'][index]['text'], chatIndex: 1);
          },
        );
      }
      return chatList;
    } catch (error) {
      log('-------- sendMessage ERROR -------- \n$error');
      rethrow;
    }
  }
}
