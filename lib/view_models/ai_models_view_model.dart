import 'package:flutter/material.dart';
import 'package:helpey/services/api_services.dart';

import '../models/ai_model.dart';

class AIModelsViewModel with ChangeNotifier {
  String _currentModel = 'text-davinci-003';

  String get currentModel => _currentModel;

  void setCurrentModel(String chosenModel) {
    _currentModel = chosenModel;
    notifyListeners();
  }

  List<AIModel> _modelsList = [];
  List<AIModel> get aiModels => [..._modelsList];

  Future<List<AIModel>> fetchAIModels() async {
    if (_modelsList.isEmpty) {
      _modelsList = await ApiServices.getAIModels();
      notifyListeners();
    }

    return _modelsList;
  }
}
