import 'package:flutter/material.dart';
import 'package:helpey/widgets/models_drop_down_widget.dart';

import '../widgets/text_widget.dart';

class Constants {
  static Color scaffoldBackgroundColor = const Color(0xFF343541);
  static Color cardColor = const Color(0xFF444654);

  static Future<void> showAIModelBottomSheet({
    required BuildContext context,
  }) async {
    await showModalBottomSheet(
      context: context,
      backgroundColor: cardColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(18.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Flexible(
                child: TextWidget(
                  label: 'AI Model: ',
                  fontSize: 16,
                ),
              ),
              Flexible(
                flex: 2,
                child: ModelsDropDownWidget(),
              ),
            ],
          ),
        );
      },
    );
  }

  // static final List<String> _models = [
  //   'Model 1',
  //   'Model 2',
  //   'Model 3',
  //   'Model 4',
  //   'Model 5',
  //   'Model 6',
  // ];
  //
  // static List<DropdownMenuItem<String>>? get getModelItems {
  //   List<DropdownMenuItem<String>>? modelsItems =
  //       List<DropdownMenuItem<String>>.generate(
  //     _models.length,
  //     (index) => DropdownMenuItem(
  //       value: _models[index],
  //       child: TextWidget(
  //         label: _models[index],
  //         fontSize: 15,
  //       ),
  //     ),
  //   );
  //   return modelsItems;
  // }

  static final chatMessages = [
    {
      "msg": "Hello who are you?",
      "chatIndex": 0,
    },
    {
      "msg":
          "Hello, I am ChatGPT, a large language model developed by OpenAI. I am here to assist you with any information or questions you may have. How can I help you today?",
      "chatIndex": 1,
    },
    {
      "msg": "What is flutter?",
      "chatIndex": 0,
    },
    {
      "msg":
          "Flutter is an open-source mobile application development framework created by Google. It is used to develop applications for Android, iOS, Linux, Mac, Windows, and the web. Flutter uses the Dart programming language and allows for the creation of high-performance, visually attractive, and responsive apps. It also has a growing and supportive community, and offers many customizable widgets for building beautiful and responsive user interfaces.",
      "chatIndex": 1,
    },
    {
      "msg": "Okay thanks",
      "chatIndex": 0,
    },
    {
      "msg":
          "You're welcome! Let me know if you have any other questions or if there's anything else I can help you with.",
      "chatIndex": 1,
    },
  ];
}
