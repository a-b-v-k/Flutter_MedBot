import 'package:flutter/material.dart';

class ModalContent extends StatelessWidget {
  const ModalContent({
    Key? key,
    required this.miccontroller,
    required this.chatcontroller,
    required this.scrollcontroller,
  }) : super(key: key);

  final miccontroller;
  final chatcontroller;
  final ScrollController scrollcontroller;

  @override
  Widget build(BuildContext context) {
    TextEditingController _tcontroller = TextEditingController();
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.7,
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  hintText: "Enter your message...",
                  hintStyle: TextStyle(
                      fontWeight: FontWeight.w400, fontStyle: FontStyle.italic),
                ),
                autofocus: true,
                controller: _tcontroller,
                textCapitalization: TextCapitalization.sentences,
                showCursor: true,
                maxLines: null,
              ),
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                      String text = _tcontroller.text;
                      if (text.isNotEmpty) {
                        chatcontroller.update(text, scrollcontroller);
                      }
                    },
                    icon: Icon(Icons.send_rounded,
                        color: Theme.of(context).colorScheme.primary)),
                IconButton(
                    onPressed: () {
                      miccontroller.updateBool(scrollcontroller);
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.mic_rounded,
                        color: Theme.of(context).colorScheme.primary)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
