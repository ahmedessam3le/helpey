import 'api_key.dart';

class ApiConstants {
  static const String _baseUrl = 'https://api.openai.com/v1';
  static String auth = 'Bearer $apiKey';
  static String modelsEndPoint = '$_baseUrl/models';
  static String completionsEndPoint = '$_baseUrl/completions';
  static String applicationJson = 'application/json';
}
