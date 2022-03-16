import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mini_project/components/Chat.dart';
import 'package:mini_project/components/chats.dart';
import 'package:mini_project/components/constants.dart';
import 'package:provider/provider.dart';

class Chats extends StatelessWidget {
  Chats({Key? key, required this.scrollcontroller}) : super(key: key);

  final ScrollController scrollcontroller;
  bool isUser(ChatMessage mess) {
    return mess.senderId == 1 ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    final chatcontroller = Provider.of<ChatMessages>(context);
    final messages = chatcontroller.messages;
    return ListView.builder(
        controller: scrollcontroller,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: messages.length + 1,
        itemBuilder: (BuildContext context, int index) {
          if (index == messages.length) return SizedBox(height: 150);
          return Mychatmessage(message: messages[index]);
        });
  }
}

class Mychatmessage extends StatelessWidget {
  const Mychatmessage({Key? key, required this.message}) : super(key: key);

  final ChatMessage message;

  String capitalize(String string) {
    if (string.isEmpty) {
      return string;
    }

    return string[0].toUpperCase() + string.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    String captialmessage = capitalize(message.text!);
    Color primary = Theme.of(context).colorScheme.primary;
    Color secondary = Theme.of(context).colorScheme.secondary;
    bool isbot = message.senderId == 0;
    return Row(
      mainAxisAlignment:
          isbot ? MainAxisAlignment.start : MainAxisAlignment.end,
      children: [
        isbot ? chaticon : SizedBox.shrink(),
        Container(
          padding: isbot ? leftpadding : rightpadding,
          child: Align(
            alignment: isbot ? Alignment.centerLeft : Alignment.centerRight,
            child: Container(
              // color: Colors.red,
              width: MediaQuery.of(context).size.width * 0.75,
              child: Align(
                alignment: isbot ? Alignment.centerLeft : Alignment.centerRight,
                child: Container(
                  child: Text(
                    captialmessage,
                    style: TextStyle(color: isbot ? primary : secondary),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: isbot ? leftborder : rightborder,
                    color: isbot ? secondary : primary,
                  ),
                  padding: EdgeInsets.all(16),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
