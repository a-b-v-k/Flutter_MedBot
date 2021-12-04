import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

ColorScheme colorscheme = ColorScheme.light(
    primary: HexColor("#ff3384ef"), secondary: HexColor("#fff7f7f7"));

ThemeData themedata = ThemeData(
  colorScheme: colorscheme,
  backgroundColor: Colors.white,
  scaffoldBackgroundColor: Colors.white,
);

const Color primary = Color(0xFF3384EF);
const Color secondary = Color(0xFFF7F7F7);

const BorderRadiusDirectional leftborder = BorderRadiusDirectional.only(
  topEnd: Radius.circular(17),
  topStart: Radius.circular(17),
  bottomEnd: Radius.circular(17),
);

const BorderRadiusDirectional rightborder = BorderRadiusDirectional.only(
  topEnd: Radius.circular(17),
  topStart: Radius.circular(17),
  bottomStart: Radius.circular(17),
);

const EdgeInsets leftpadding =
    EdgeInsets.only(right: 25, left: 3, top: 10, bottom: 10);

const EdgeInsets rightpadding =
    EdgeInsets.only(right: 16, left: 25, top: 10, bottom: 10);

const chaticon = Padding(
  child: Icon(
    Icons.health_and_safety_outlined,
    size: 50,
    color: primary,
  ),
  padding: EdgeInsets.only(left: 5),
);

const Icon micicon = Icon(Icons.mic_rounded, color: primary);

const Text exitprompt = Text(
  "DO YOU WANT TO EXIT THE APP?",
  textAlign: TextAlign.center,
  style: TextStyle(color: primary, fontSize: 20),
);

const Text exittext = Text(
  "EXIT",
  textAlign: TextAlign.center,
  style: TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.bold,
      letterSpacing: 5,
      color: Colors.white),
);

const Text backtext = Text(
  "BACK",
  textAlign: TextAlign.center,
  style: TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.bold,
      letterSpacing: 5,
      color: Colors.white),
);

const EdgeInsets exitcardbuttonpadding =
    EdgeInsets.symmetric(horizontal: 25, vertical: 12);

const Icon keyboardicon = Icon(
  Icons.keyboard,
  color: primary,
);

Container exittextbutton = Container(
  decoration: BoxDecoration(
      color: Colors.red.shade400, borderRadius: BorderRadius.circular(10)),
  child: Padding(padding: exitcardbuttonpadding, child: exittext),
);

Container backtextbutton = Container(
  decoration:
      BoxDecoration(color: primary, borderRadius: BorderRadius.circular(10)),
  child: Padding(padding: exitcardbuttonpadding, child: backtext),
);
