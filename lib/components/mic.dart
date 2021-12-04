import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:mini_project/components/chats.dart';
import 'package:mini_project/components/constants.dart';
import 'package:mini_project/components/mic_controller.dart';
import 'package:provider/provider.dart';

class Micbutton extends StatelessWidget {
  Micbutton({Key? key, required this.scrollcontroller}) : super(key: key);

  final ScrollController scrollcontroller;

  @override
  Widget build(BuildContext context) {
    final _miccontroller = Provider.of<Miccontroller>(context);
    final _chatcontroller = Provider.of<ChatMessages>(context);
    bool pressed = _miccontroller.ispressed;
    return AvatarGlow(
      duration: const Duration(seconds: 2),
      repeatPauseDuration: const Duration(milliseconds: 100),
      glowColor: Colors.blue,
      animate: pressed,
      endRadius: 60,
      child: FloatingActionButton(
        elevation: 15,
        onPressed: () {
          _miccontroller.updateBool(scrollcontroller,
              chatcontroller: _chatcontroller);
        },
        child: micicon,
      ),
    );
  }
}
