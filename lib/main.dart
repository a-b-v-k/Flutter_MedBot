import 'package:flutter/material.dart';
import 'package:mini_project/HomeScreen.dart';
import 'package:mini_project/PredictScreen.dart';
import 'package:mini_project/Splash.dart';
import 'package:mini_project/components/chats.dart';
import 'package:mini_project/components/constants.dart';
import 'package:mini_project/components/mic_controller.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

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
        home: AnimatedSplashScreen(
          splash: SplashScreen(),
          nextScreen: ProviderHomePage(),
          pageTransitionType: PageTransitionType.fade,
        ));
  }
}

class ProviderHomePage extends StatelessWidget {
  const ProviderHomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Miccontroller>(
            create: (context) => Miccontroller()),
        ChangeNotifierProvider<ChatMessages>(
            create: (context) => ChatMessages()),
      ],
      child: MyHomePage(title: 'MedBot'),
    );
  }
}
