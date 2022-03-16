import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mini_project/components/constants.dart';

class Predict extends StatefulWidget {
  final map;

  const Predict(this.map);

  @override
  State<Predict> createState() => _PredictState();
}

class _PredictState extends State<Predict> {
  late String predicted = "";

  List<String> syms = [];
  void display() {
    syms = [];
    widget.map.forEach((k, v) {
      if (v) {
        syms.add(k);
      }
    });
  }

  String capitalize(String string) {
    if (string.isEmpty) {
      return string;
    }

    return string[0].toUpperCase() + string.substring(1);
  }

  void makeCall() async {
    Map<String, List<String>> req = Map();
    req["symptoms"] = syms;
    // print(req["symptoms"]);
    final resp = await http.post(
      Uri.parse('https://init.vijay-krishnakr.repl.co/predict'),
      body: jsonEncode(req),
    );
    setState(() {
      predicted = resp.body;
    });
  }

  @override
  Widget build(BuildContext context) {
    // predicted = "";
    display();
    if (predicted == "") {
      makeCall();
    }
    // print(jsonData);
    return Scaffold(
        backgroundColor: secondary,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_sharp),
            iconSize: 40,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          elevation: 0,
          backgroundColor: secondary,
          foregroundColor: primary,
        ),
        body: Container(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 40),
              child: predicted == ""
                  ? CircularProgressIndicator()
                  : Text(
                      "You might be having this disease: " +
                          "${capitalize(predicted)}",
                      style: TextStyle(fontSize: 25),
                      textAlign: TextAlign.center),
            ),
          ),
        ));
  }
}
