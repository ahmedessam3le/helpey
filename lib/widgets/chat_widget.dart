import 'package:flutter/material.dart';
import 'package:helpey/constants/assets_manager.dart';
import 'package:helpey/constants/constants.dart';
import 'package:helpey/widgets/text_widget.dart';

class ChatWidget extends StatelessWidget {
  const ChatWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          color: cardColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Image.asset(
                  AssetsManager.userImage,
                  width: 40,
                ),
                const TextWidget(label: 'Here will be the message'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
