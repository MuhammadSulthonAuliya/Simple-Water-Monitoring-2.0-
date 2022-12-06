import 'package:flutter/material.dart';

// Asset variabel yang digunakan untuk tampilan

class DefaultAsset {
  BoxDecoration defaultBackground = BoxDecoration(
      gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topLeft,
          colors: <Color>[
        Colors.blue,
        Colors.purple,
        Colors.lightBlue,
      ]));
  TextStyle defaultText = TextStyle(fontSize: 19);

  BoxDecoration getDBackgorund() {
    return this.defaultBackground;
  }

  TextStyle getDTextStyle() {
    return this.defaultText;
  }
}
