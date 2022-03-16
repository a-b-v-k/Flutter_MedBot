import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mini_project/components/chats.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_to_text.dart';

class Miccontroller extends ChangeNotifier {
  bool ispressed = false;
  String text = "Listening....";
  late String listenedtext;
  static final _speech = SpeechToText();

  static Future<bool> togglerecording({
    required void Function(String text) updatetext,
    required void Function(bool, String) islistening,
  }) async {
    final isavailable = await _speech.initialize(
        onStatus: (status) => islistening(_speech.isListening, status),
        onError: (e) => print("Error: $e"));

    if (isavailable) {
      Future.delayed(Duration(milliseconds: 300));
      _speech.listen(
          listenFor: Duration(seconds: 10),
          pauseFor: Duration(seconds: 5),
          onResult: (res) => updatetext(res.recognizedWords),
          listenMode: ListenMode.dictation);
    }

    return isavailable;
  }

  void updateBooltofalse() {
    ispressed = false;
    notifyListeners();
  }

  void updateBooltotrue(ScrollController scrollcontroller,
      {required chatcontroller}) async {
    bool isavailable;
    ispressed = true;
    listenedtext = text;
    isavailable = await togglerecording(updatetext: (String t) {
      listenedtext = t;
      notifyListeners();
      print(text);
    }, islistening: (bool ispressed, String status) {
      this.ispressed = ispressed;
      notifyListeners();
      if (status == "done" && listenedtext != text)
        chatcontroller.update(listenedtext, scrollcontroller);
      print("Status: $status");
    });
    print("Availablity: $isavailable");
    notifyListeners();
  }

  void updateBool(ScrollController scrollcontroller,
      {required chatcontroller}) {
    if (ispressed)
      updateBooltofalse();
    else {
      scrollcontroller.animateTo(scrollcontroller.position.maxScrollExtent,
          duration: Duration(seconds: 1), curve: Curves.fastOutSlowIn);
      updateBooltotrue(scrollcontroller, chatcontroller: chatcontroller);
      listenedtext = text;
    }
  }
}
