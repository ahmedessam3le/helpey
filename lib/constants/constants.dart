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
}
