part of '../custom_radio_grouped_button.dart';

class ButtonTextStyle {
  ///Selected color of Text
  final Color selectedColor;

  final Color disabledColor;

  ///Unselected color of Text
  final Color unSelectedColor;

  /// Color in [TextStyle] will be ignored
  final TextStyle textStyle;

  /// Color in [TextStyle] will be ignored
  final TextStyle selectedTextStyle;

  const ButtonTextStyle({
    this.selectedColor = Colors.white,
    this.unSelectedColor = Colors.black,
    this.disabledColor = Colors.grey,
    this.textStyle = const TextStyle(),
    TextStyle? selectedTextStyle,
  }) : selectedTextStyle = selectedTextStyle ?? textStyle;
}
