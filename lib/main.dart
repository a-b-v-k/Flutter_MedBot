import 'package:flutter/material.dart';
import 'package:mini_project/HomeScreen.dart';
import 'package:mini_project/components/chats.dart';
import 'package:mini_project/components/constants.dart';
import 'package:mini_project/components/mic_controller.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: themedata,
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider<Miccontroller>(
              create: (context) => Miccontroller()),
          ChangeNotifierProvider<ChatMessages>(
              create: (context) => ChatMessages()),
        ],
        child: MyHomePage(title: 'MedBot'),
      ),
    );
  }
}
