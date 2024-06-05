import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';

String getInitials(String string, [int limitTo = 2]) {
  if (string.isEmpty) {
    return '';
  }

  var buffer = StringBuffer();
  var split = string.split(' ');

  //For one word
  if (split.length == 1) {
    return string.substring(0, 1);
  }

  for (var i = 0; i < (limitTo); i++) {
    buffer.write(split[i][0]);
  }

  return buffer.toString().toUpperCase();
}

showLoader(BuildContext context) {
  Loader.show(
    context,
    overlayColor: Colors.black54,
    progressIndicator:
        const CircularProgressIndicator(backgroundColor: Colors.white),
  );
}


hideLoader() {
  Loader.hide();
}
