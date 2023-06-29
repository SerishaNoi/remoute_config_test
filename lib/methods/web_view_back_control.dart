import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

Future<bool> exitApp(BuildContext context, InAppWebViewController controller) async {
  if (await controller.canGoBack()) {
    print("onWill goback");
    controller.goBack();
  }
  return Future.value(false);
}
