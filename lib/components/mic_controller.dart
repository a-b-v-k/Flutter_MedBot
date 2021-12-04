import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mini_project/components/chats.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_to_text.dart';

class Miccontroller extends ChangeNotifier {
  bool ispressed = false;
  String text = "Mic is on... Say something";
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
    if (ispressed) {
      ispressed = false;
      notifyListeners();
    }
  }

  void updateBooltotrue(ScrollController scrollcontroller,
      {required chatcontroller}) async {
    bool isavailable;
    ispressed = true;
    scrollcontroller.animateTo(scrollcontroller.position.maxScrollExtent,
        duration: Duration(seconds: 1), curve: Curves.fastOutSlowIn);
    isavailable = await togglerecording(updatetext: (String t) {
      text = t;
      notifyListeners();
      print(text);
    }, islistening: (bool ispressed, String status) {
      this.ispressed = ispressed;
      notifyListeners();
      if (status == "done") chatcontroller.update(text, scrollcontroller);
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
      updateBooltotrue(scrollcontroller, chatcontroller: chatcontroller);
      //chatcontroller.update(text, scrollcontroller);
      text = "Mic is on... Say something.";
    }
  }
}
