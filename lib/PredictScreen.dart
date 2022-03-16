import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:mini_project/PredictApi.dart';
import 'package:mini_project/components/constants.dart';

class PredictScreen extends StatefulWidget {
  const PredictScreen({Key? key}) : super(key: key);

  @override
  State<PredictScreen> createState() => _PredictScreenState();
}

class _PredictScreenState extends State<PredictScreen> {
  late List symptoms = [];
  late List filtered = [];
  late Map<String, bool> maps = Map();

  void readJson() async {
    final jsondata = await rootBundle.loadString('assets/s.json');
    symptoms = json.decode(jsondata);
    symptoms.sort();
    setState(() {
      filtered = symptoms;
      for (int i = 0; i < filtered.length; i++) {
        maps[filtered[i]] = false;
      }
    });
  }

  void _runFilter(String value) {
    List result = [];
    if (value.isEmpty) {
      result = symptoms;
    } else {
      result =
          symptoms.where((sym) => sym.contains(value.toLowerCase())).toList();
    }
    setState(() {
      filtered = result;
    });
  }

  String capitalize(String string) {
    if (string.isEmpty) {
      return string;
    }

    return string[0].toUpperCase() + string.substring(1);
  }

  void _handlesubmit() {
    print("handle");
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => Predict(maps)));
  }

  void handleClear() {
    maps.forEach((key, value) {
      maps[key] = false;
    });
    setState(() {});
  }

  @override
  void initState() {
    readJson();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      gestures: [
        GestureType.onTap,
        GestureType.onPanUpdateDownDirection,
      ],
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: secondary,
          bottomNavigationBar: GestureDetector(
            onTap: _handlesubmit,
            child: Container(
                padding: EdgeInsets.only(bottom: 10),
                child: Text(
                  "Submit",
                  style: TextStyle(color: primary, fontSize: 20),
                  textAlign: TextAlign.center,
                )),
          ),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(children: [
              SizedBox(height: 50),
              Container(
                // color: Colors.red,
                child: Column(
                  children: [
                    TextField(
                        onChanged: (value) => _runFilter(value),
                        decoration: const InputDecoration(
                          labelText: "Search",
                        )),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: GestureDetector(
                        child: Text(
                          "CLEAR SELECTION",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: primary,
                              letterSpacing: 4,
                              fontWeight: FontWeight.w500),
                        ),
                        onTap: () {
                          handleClear();
                        },
                      ),
                      padding: EdgeInsets.only(right: 7),
                    )
                  ],
                ),
              ),
              filtered.isEmpty
                  ? Container(
                      child: Center(
                      child: Text("loading"),
                    ))
                  : Expanded(
                      child: ListView.builder(
                          itemCount: filtered.length,
                          // physics: NeverScrollableScrollPhysics(),
                          // shrinkWrap: true,
                          itemBuilder: (builder, index) {
                            final ele = filtered[index];
                            final val = maps[ele];
                            return GestureDetector(
                              onTap: () {
                                print("s");
                                setState(() {
                                  maps[ele] = !val!;
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: val! ? Colors.blue : Colors.white,
                                    border: Border.all(color: Colors.black26),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                                margin: EdgeInsets.all(5),
                                child: Text(
                                  capitalize(ele),
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: val ? Colors.white : Colors.black,
                                  ),
                                ),
                                padding: EdgeInsets.all(5),
                              ),
                            );
                          })),
            ]),
          )),
    );
  }
}
