import 'package:flutter/material.dart';
import 'package:mini_project/chatbuilder.dart';
import 'package:mini_project/components/MyModal.dart';
import 'package:mini_project/components/chats.dart';
import 'package:mini_project/components/constants.dart';
import 'package:mini_project/components/mic.dart';
import 'package:mini_project/components/mic_controller.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatelessWidget {
  final String title;
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final ScrollController _scontroller = ScrollController();

  void _showTextField(BuildContext context, Miccontroller miccontroller,
      ChatMessages chatcontroller, ScrollController scrollcontroller) {
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.white,
        barrierColor: Colors.transparent,
        elevation: 10,
        context: context,
        builder: (BuildContext context) {
          return ModalContent(
              miccontroller: miccontroller,
              chatcontroller: chatcontroller,
              scrollcontroller: scrollcontroller);
        });
  }

  @override
  Widget build(BuildContext context) {
    final miccontroller = Provider.of<Miccontroller>(context);
    final chatcontroller = Provider.of<ChatMessages>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        toolbarHeight: 40,
        backgroundColor: Colors.white,
        elevation: 2.0,
        leading: GestureDetector(
          onTap: () {
            showDialog(context: context, builder: (context) => ExitDialog());
          },
          child: Hero(
            tag: "exit",
            child: Icon(
              Icons.exit_to_app_rounded,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
        title: Text(
          title,
          style: TextStyle(color: Theme.of(context).colorScheme.primary),
        ),
      ),
      bottomNavigationBar: miccontroller.ispressed
          ? Container(
              height: 48,
              child: Center(
                child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Text(miccontroller.text)),
              ),
            )
          : Container(
              height: 48,
              child: IconButton(
                  icon: keyboardicon,
                  onPressed: () {
                    _showTextField(
                        context, miccontroller, chatcontroller, _scontroller);
                  }),
            ),
      floatingActionButton: Micbutton(
        scrollcontroller: _scontroller,
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      body: HomeScreenBody(scrollcontroller: _scontroller),
    );
  }
}

class ExitDialog extends StatelessWidget {
  const ExitDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetAnimationCurve: Curves.easeInOutQuad,
      insetAnimationDuration: Duration(milliseconds: 300),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        padding: EdgeInsets.all(10),
        height: 230,
        width: 230,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            exitprompt,
            TextButton(onPressed: () {}, child: exittextbutton),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: backtextbutton)
          ],
        ),
      ),
    );
  }
}

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({
    Key? key,
    required this.scrollcontroller,
  }) : super(key: key);

  final ScrollController scrollcontroller;

  @override
  Widget build(BuildContext context) {
    return Chats(scrollcontroller: scrollcontroller);
  }
}
