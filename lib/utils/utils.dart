import 'package:flutter/foundation.dart';

void gPrint(value) {
  if (kDebugMode) {
    print(value);
  }
}

String truncateString(String text, {length: 7, omission: '...'}) {
  if (length >= text.length) {
    return text;
  }
  return text.replaceRange(length, text.length, omission);
}
