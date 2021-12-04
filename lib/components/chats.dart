import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mini_project/components/Chat.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_dialogflow/dialogflow_v2.dart';

class ChatMessages extends ChangeNotifier {
  List<Message> messages = [
    Message(
        senderId: 0, text: "Hello!, \nwhat can I do for you today?", time: 0),
  ];

  void displaymessage(int id, String text, ScrollController scrollcontroller) {
    messages.add(Message(senderId: id, text: text, time: 0));
    WidgetsBinding.instance!.addPostFrameCallback((_) => scrollcontroller
        .animateTo(scrollcontroller.position.maxScrollExtent + 38,
            duration: Duration(milliseconds: 1000), curve: Curves.easeOutExpo));
    notifyListeners();
  }

  Future<String> getbotresponse(String querytext) async {
    AuthGoogle authGoogle =
        await AuthGoogle(fileJson: "assets/key.json").build();
    Dialogflow dialogflow =
        Dialogflow(authGoogle: authGoogle, language: Language.english);
    AIResponse response = await dialogflow.detectIntent(querytext);

    print(response.queryResult.queryText);
    return response.queryResult.fulfillmentText;
  }

  update(String text, ScrollController scrollcontroller) async {
    displaymessage(1, text, scrollcontroller);
    await Future.delayed(Duration(milliseconds: 200), () {});
    getbotresponse(text)
        .then((res) => displaymessage(0, res, scrollcontroller));
  }
}
