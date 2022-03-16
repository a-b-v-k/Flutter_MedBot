import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mini_project/components/Chat.dart';
import 'package:dialog_flowtter/dialog_flowtter.dart';

class ChatMessages extends ChangeNotifier {
  List<ChatMessage> messages = [
    ChatMessage(
        senderId: 0, text: "Hello!, \nwhat can I do for you today?", time: 0),
  ];

  late DialogFlowtter dialogflowtter;

  void init() async {
    dialogflowtter = await DialogFlowtter.fromFile();
  }

  void displaymessage(int id, String text, ScrollController scrollcontroller) {
    messages.add(ChatMessage(senderId: id, text: text, time: 0));
    WidgetsBinding.instance!.addPostFrameCallback((_) => scrollcontroller
        .animateTo(scrollcontroller.position.maxScrollExtent + 38,
            duration: Duration(milliseconds: 1000), curve: Curves.easeOutExpo));
    notifyListeners();
  }

  getbotresponse(String querytext) async {
    DetectIntentResponse response = await dialogflowtter.detectIntent(
      queryInput: QueryInput(text: TextInput(text: querytext)),
    );
    return response.message!.text!.text!.last;
  }

  update(String text, ScrollController scrollcontroller) async {
    displaymessage(1, text, scrollcontroller);
    //await Future.delayed(Duration(milliseconds: 200), () {});
    getbotresponse(text).then((res) {
      displaymessage(0, res, scrollcontroller);
    });
  }
}
