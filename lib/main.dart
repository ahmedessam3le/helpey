import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:helpey/constants/constants.dart';

import 'views/chat_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Helpey',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: scaffoldBackgroundColor,
        appBarTheme: AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: cardColor,
            statusBarBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.light,
          ),
          color: cardColor,
          elevation: 2,
        ),
      ),
      home: const ChatView(),
    );
  }
}
