import 'package:flutter/material.dart';

extension ImageThumb on BuildContext {
  String userOwnerThumb(String value) {
    return "https://images.hive.blog/u/$value/avatar";
  }

  String resizedImage(String value) {
    return "https://images.hive.blog/320x160/$value";
  }
}
