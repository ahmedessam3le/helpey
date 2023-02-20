import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:helpey/constants/assets_manager.dart';
import 'package:helpey/constants/constants.dart';
import 'package:helpey/services/api_services.dart';
import 'package:helpey/widgets/chat_widget.dart';
import 'package:provider/provider.dart';

import '../view_models/ai_models_view_model.dart';

class ChatView extends StatefulWidget {
  const ChatView({Key? key}) : super(key: key);

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  bool _isTyping = false;

  late TextEditingController _textEditingController;

  @override
  void initState() {
    _textEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
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
                itemCount: 6,
                itemBuilder: (context, index) {
                  return ChatWidget(
                    chatIndex:
                        Constants.chatMessages[index]['chatIndex'] as int,
                    message: Constants.chatMessages[index]['msg'] as String,
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
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration.collapsed(
                          hintText: 'How can i help you ?',
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                        onSubmitted: (value) {
                          //TODO Send Message
                        },
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        setState(() {
                          _isTyping = true;
                        });
                        final list = ApiServices.sendMessage(
                          aiModel: aiModelsViewModel.currentModel,
                          message: _textEditingController.text,
                        ).whenComplete(
                          () => setState(() {
                            _isTyping = false;
                          }),
                        );
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
}
