import 'dart:developer';

import 'package:url_launcher/url_launcher.dart';

class Act {
  static Future<void> launchThisUrl(String url) async {
    var uri = Uri.tryParse(url);
    if (uri != null) {
      var canLaunch = await canLaunchUrl(uri);
      if (canLaunch) {
        await launchUrl(uri);
      } else {
        log("URL can't be launched.");
      }
    }
  }
}
