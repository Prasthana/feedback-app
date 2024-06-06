import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:network_logger/network_logger.dart';

String getInitials(String string, [int limitTo = 2]) {
  if (string.isEmpty) {
    return '';
  }

  var buffer = StringBuffer();
  var split = string.trim().split(' ');

  //For one word
  if (split.length == 1) {
    return string.substring(0, 1).toUpperCase();
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

showNetworkLogger(BuildContext context) {
      NetworkLoggerOverlay.attachTo(context,bottom: 400,right: 10);
}