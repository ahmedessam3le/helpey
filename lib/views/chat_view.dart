import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:helpey/constants/assets_manager.dart';
import 'package:helpey/constants/constants.dart';
import 'package:helpey/models/chat_model.dart';
import 'package:helpey/widgets/chat_widget.dart';
import 'package:provider/provider.dart';

import '../services/api_services.dart';
import '../view_models/ai_models_view_model.dart';

class ChatView extends StatefulWidget {
  const ChatView({Key? key}) : super(key: key);

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  bool _isTyping = false;
  List<ChatModel> chatList = [];

  late TextEditingController _textEditingController;
  late FocusNode _focusNode;

  @override
  void initState() {
    _textEditingController = TextEditingController();
    _focusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final aiModelsViewModel =
        Provider.of<AIModelsViewModel>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(AssetsManager.openaiLogo),
        ),
        title: const Text('Helpey'),
        actions: [
          IconButton(
            onPressed: () async {
              await Constants.showAIModelBottomSheet(context: context);
            },
            icon: const Icon(
              Icons.more_vert_rounded,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                itemCount: chatList.length,
                itemBuilder: (context, index) {
                  return ChatWidget(
                    chatIndex: chatList[index].chatIndex,
                    message: chatList[index].message,
                  );
                },
              ),
            ),
            if (_isTyping) ...[
              const SpinKitThreeBounce(
                color: Colors.white,
                size: 24,
              ),
            ],
            const SizedBox(height: 16),
            Material(
              color: Constants.cardColor,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _textEditingController,
                        focusNode: _focusNode,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration.collapsed(
                          hintText: 'How can i help you ?',
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                        onSubmitted: (value) async {
                          await sendMessage(viewModel: aiModelsViewModel);
                        },
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        await sendMessage(viewModel: aiModelsViewModel);
                      },
                      icon: const Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> sendMessage({required AIModelsViewModel viewModel}) async {
    setState(() {
      _isTyping = true;
      chatList.add(
        ChatModel(message: _textEditingController.text, chatIndex: 0),
      );
      _textEditingController.clear();
      _focusNode.unfocus();
    });
    chatList.addAll(
      await ApiServices.sendMessage(
        aiModel: viewModel.currentModel,
        message: _textEditingController.text,
      ).whenComplete(
        () => setState(() {
          _isTyping = false;
        }),
      ),
    );
  }
}
