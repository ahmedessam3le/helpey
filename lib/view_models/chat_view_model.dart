import 'dart:developer';

import 'package:flutter/material.dart';

import '../models/chat_model.dart';
import '../services/api_services.dart';

class ChatViewModel with ChangeNotifier {
  List<ChatModel> _chatList = [];
  List<ChatModel> get chatList => [..._chatList];

  void addUserMessage({required String message}) {
    _chatList.add(ChatModel(message: message, chatIndex: 0));
    notifyListeners();
  }

  Future<void> sendMessage({
    required String chosenModel,
    required String message,
  }) async {
    log('---------------- sendMessage ---- MESSAGE ----------------\n$message');
    _chatList.addAll(
      await ApiServices.sendMessage(aiModel: chosenModel, message: message),
    );
    notifyListeners();
  }
}
