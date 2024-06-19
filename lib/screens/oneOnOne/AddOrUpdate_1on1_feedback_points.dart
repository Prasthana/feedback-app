import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:oneononetalks/api_services/models/oneonone.dart';
import 'package:oneononetalks/utils/constants.dart' as constants;

class AddOrUpdateOneOnOneFeedbackPointsView extends StatefulWidget {
  const AddOrUpdateOneOnOneFeedbackPointsView({
    super.key,
    required this.addedPointText,
    required this.index, 
    required this.isFromGoodAtList
  });
  final String addedPointText;
  final int index;
  final bool isFromGoodAtList;
  @override
  State<AddOrUpdateOneOnOneFeedbackPointsView> createState() => _AddOrUpdateOneOnOneFeedbackPointsViewState();
}

class _AddOrUpdateOneOnOneFeedbackPointsViewState extends State<AddOrUpdateOneOnOneFeedbackPointsView> {
  late String enteredText = "";
  late TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    enteredText = widget.addedPointText;
    _textController = TextEditingController(text: enteredText);
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var isFromGoodAtList = widget.isFromGoodAtList;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            if (enteredText.isNotEmpty) {
              showValidationAlert(
                  context, "Good at/Yet to Improve points will not be saved");
            } else {
              Navigator.pop(context);
            }
          },
        ),
        backgroundColor: Colors.white,
        title:  Text(
          isFromGoodAtList ? "Good At" : "Yet to Improve",
          style: const TextStyle(
            fontFamily: constants.uberMoveFont,
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context, enteredText);
            },
            child: const Text(
              'Save',
              style: TextStyle(
              fontFamily: constants.uberMoveFont,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            ),
          ),
        ],
      ),
      body: Expanded(
        child: TextField(
            keyboardType: TextInputType.multiline,
            textInputAction: TextInputAction.newline,
            maxLines: 10000,
            autofocus: true,
            autocorrect: true,
            controller: _textController,
            decoration: const InputDecoration(
              fillColor: Colors.white,
              hintText: constants.notesHintText,
              hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            style: const TextStyle(
              fontFamily: constants.uberMoveFont,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            onChanged: (text) {
              setState(() {
                enteredText = text;
              });
            }),
      ),
    );
  }

  showValidationAlert(BuildContext context, String alertText) {
    // set up the button
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        Navigator.pop(context);
        Navigator.pop(context);
      },
    );

    Widget cancelButton = TextButton(
      child: const Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    CupertinoAlertDialog alert = CupertinoAlertDialog(
      content: Text(alertText),
      actions: [okButton, cancelButton],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
