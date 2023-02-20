import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:helpey/constants/assets_manager.dart';
import 'package:helpey/constants/constants.dart';
import 'package:helpey/view_models/chat_view_model.dart';
import 'package:helpey/widgets/chat_widget.dart';
import 'package:helpey/widgets/text_widget.dart';
import 'package:provider/provider.dart';

import '../view_models/ai_models_view_model.dart';

class ChatView extends StatefulWidget {
  const ChatView({Key? key}) : super(key: key);

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  bool _isTyping = false;
  // List<ChatModel> chatList = [];

  late TextEditingController _textEditingController;
  late FocusNode _focusNode;
  late ScrollController _scrollController;

  @override
  void initState() {
    _textEditingController = TextEditingController();
    _focusNode = FocusNode();
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _focusNode.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final aiModelsViewModel =
        Provider.of<AIModelsViewModel>(context, listen: true);
    final chatViewModel = Provider.of<ChatViewModel>(context, listen: true);
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
                physics: const BouncingScrollPhysics(),
                controller: _scrollController,
                itemCount: chatViewModel.chatList.length,
                itemBuilder: (context, index) {
                  return ChatWidget(
                    chatIndex: chatViewModel.chatList[index].chatIndex,
                    message: chatViewModel.chatList[index].message,
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
                          await sendMessage(
                            aiViewModel: aiModelsViewModel,
                            chatViewModel: chatViewModel,
                          );
                        },
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        await sendMessage(
                          aiViewModel: aiModelsViewModel,
                          chatViewModel: chatViewModel,
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

  void scrollChatToTheEnd() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(seconds: 2),
      curve: Curves.easeOut,
    );
  }

  Future<void> sendMessage({
    required AIModelsViewModel aiViewModel,
    required ChatViewModel chatViewModel,
  }) async {
    if (_textEditingController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: TextWidget(
            label: 'Please type a message',
          ),
        ),
      );
      return;
    }
    setState(() {
      _isTyping = true;
      // chatList.add(
      //   ChatModel(message: _textEditingController.text, chatIndex: 0),
      // );
      chatViewModel.addUserMessage(message: _textEditingController.text);
      _textEditingController.clear();
      _focusNode.unfocus();
    });
    await chatViewModel
        .sendMessage(
      chosenModel: aiViewModel.currentModel,
      message: _textEditingController.text,
    )
        .catchError(
      (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: TextWidget(
              label: error.toString(),
            ),
          ),
        );
      },
    );
    // chatList.addAll(
    //   await ApiServices.sendMessage(
    //     aiModel: aiViewModel.currentModel,
    //     message: _textEditingController.text,
    //   ).whenComplete(
    //     () => ,
    //   ),
    // );
    setState(() {
      _isTyping = false;
      scrollChatToTheEnd();
    });
  }
}
