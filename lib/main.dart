import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:helpey/constants/constants.dart';
import 'package:helpey/view_models/ai_models_view_model.dart';
import 'package:provider/provider.dart';

import 'views/chat_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AIModelsViewModel(),
        ),
      ],
      child: MaterialApp(
        title: 'Helpey',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Constants.scaffoldBackgroundColor,
          appBarTheme: AppBarTheme(
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Constants.cardColor,
              statusBarBrightness: Brightness.light,
              statusBarIconBrightness: Brightness.light,
            ),
            color: Constants.cardColor,
            elevation: 2,
          ),
        ),
        home: const ChatView(),
      ),
    );
  }
}
