import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ButtonTextStyle {
  ///Selected color of Text
  final Color selectedColor;

  ///Unselected color of Text
  final Color unSelectedColor;
  final TextStyle textStyle;

  const ButtonTextStyle({
    this.selectedColor = Colors.white,
    this.unSelectedColor = Colors.black,
    this.textStyle = const TextStyle(),
  });
}
