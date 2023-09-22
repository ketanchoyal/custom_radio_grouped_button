part of '../custom_radio_grouped_button.dart';

class CustomRadioButton<T> extends StatefulWidget {
  /// [spacing] Spacing between buttons
  CustomRadioButton({
    super.key,
    required this.buttonLables,
    required this.buttonValues,
    this.buttonTextStyle = const ButtonTextStyle(),
    this.autoWidth = false,
    required this.radioButtonValue,
    required this.unSelectedColor,
    this.unSelectedBorderColor,
    double padding = 3,
    double spacing = 0.0,
    required this.selectedColor,
    this.selectedBorderColor,
    this.height = 35,
    this.width = 100,
    this.enableButtonWrap = false,
    this.horizontal = false,
    this.enableShape = false,
    this.elevation = 10,
    this.shapeRadius = 50,
    this.radius = 20,
    this.defaultSelected,
    this.customShape,
    this.scrollController,
    this.absoluteZeroSpacing = false,
    this.margin,
    this.wrapAlignment = WrapAlignment.start,
    this.disabledValues = const [],
    this.disabledColor,
  })  : assert(buttonLables.length == buttonValues.length,
            "Button values list and button lables list should have same number of eliments "),
        // assert(
        //     buttonValues.toSet().intersection(disabledValues.toSet()) ==
        //         disabledValues.toSet(),
        //     "Disabled values should be present in button values"),
        assert(buttonValues.toSet().length == buttonValues.length,
            "Multiple buttons with same value cannot exist") {
    if (absoluteZeroSpacing) {
      this.padding = 0;
      this.spacing = 0;
    } else {
      this.padding = padding;
      this.spacing = spacing;
    }
  }

  ///Orientation of the Button Group
  final bool horizontal;

  final ScrollController? scrollController;

  ///Values of button
  final List<T> buttonValues;

  ///This option will make sure that there is no spacing in between buttons
  final bool absoluteZeroSpacing;

  ///Margins around card
  final EdgeInsetsGeometry? margin;

  ///Default value is 35
  final double height;
  late final double padding;

  ///Spacing between buttons
  late final double spacing;

  ///Default selected value
  final T? defaultSelected;

  ///Only applied when in vertical mode
  ///This will use minimum space required
  ///If enables it will ignore [width] field
  final bool autoWidth;

  ///Use this if you want to keep width of all the buttons same
  final double width;

  final List<String> buttonLables;

  ///List of disabled values
  final List<T> disabledValues;

  ///Styling class for label
  final ButtonTextStyle buttonTextStyle;

  final void Function(T) radioButtonValue;

  ///Unselected Color of the button
  final Color unSelectedColor;

  ///Selected Color of button
  final Color selectedColor;

  ///Disabled Color of button
  ///If not provided will use [unSelectedColor]
  final Color? disabledColor;

  ///Unselected Color of the button border
  final Color? unSelectedBorderColor;

  ///Selected Color of button border
  final Color? selectedBorderColor;

  /// A custom Shape can be applied (will work only if [enableShape] is true)
  final ShapeBorder? customShape;

  ///alignment for button when [enableButtonWrap] is true
  final WrapAlignment wrapAlignment;

  /// This will enable button wrap (will work only if orientation is vertical)
  final bool enableButtonWrap;

  ///if true button will have rounded corners
  ///If you want custom shape you can use [customShape] property
  final bool enableShape;
  final double elevation;

  /// Radius for non-shape radio button
  @Deprecated('Use shapeRadius instead')
  final double radius;

  /// Radius for shape radio button
  final double shapeRadius;

  CustomRadioButtonState<T> createState() => CustomRadioButtonState<T>();
}

class CustomRadioButtonState<T> extends State<CustomRadioButton<T>> {
  T? _currentSelectedValue;

  Color _borderColor(T e) =>
      (_currentSelectedValue == e
          ? widget.selectedBorderColor
          : widget.unSelectedBorderColor) ??
      Theme.of(context).primaryColor;

  @override
  void initState() {
    super.initState();
    if (widget.defaultSelected != null) {
      if (widget.buttonValues.contains(widget.defaultSelected)) {
        _currentSelectedValue = widget.defaultSelected;
      } else
        throw Exception("Default Value not found in button value list");
    }
  }

  List<T> get buttonValues => widget.buttonValues;

  List<String> get buttonLables => widget.buttonLables;

  List<T> get disabledValues => widget.disabledValues;

  /// This function will select the button and update the state
  /// THis can be access from outside to change the selected value programatically
  /// Please note that this will all call the [radioButtonValue] callback
  void selectButton(T selectedValue) {
    widget.radioButtonValue(selectedValue);
    if (mounted) setState(() {});
    _currentSelectedValue = selectedValue;
  }

  List<Widget> _buildButtonsColumn() {
    return buttonValues.map((e) {
      int index = buttonValues.indexOf(e);
      bool disabled = disabledValues.contains(e);
      bool isSelected = _currentSelectedValue == e;
      return Padding(
        padding: EdgeInsets.all(widget.padding),
        child: Card(
          margin: widget.margin ??
              EdgeInsets.all(widget.absoluteZeroSpacing ? 0 : 4),
          color: disabled
              ? widget.disabledColor ?? widget.unSelectedColor
              : _currentSelectedValue == e
                  ? widget.selectedColor
                  : widget.unSelectedColor,
          elevation: widget.elevation,
          shape: widget.enableShape
              ? widget.customShape ??
                  RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.all(Radius.circular(widget.shapeRadius)),
                  )
              : null,
          child: Container(
            height: widget.height,
            child: MaterialButton(
              shape: widget.enableShape
                  ? widget.customShape ??
                      OutlineInputBorder(
                        borderSide:
                            BorderSide(color: _borderColor(e), width: 1),
                        borderRadius: BorderRadius.all(
                            Radius.circular(widget.shapeRadius)),
                      )
                  : OutlineInputBorder(
                      borderSide: BorderSide(color: _borderColor(e), width: 1),
                      borderRadius: BorderRadius.zero,
                    ),
              onPressed: disabled ? null : () => selectButton(e),
              child: Text(widget.buttonLables[index],
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: textStyle(isSelected, disabled)),
            ),
          ),
        ),
      );
    }).toList();
  }

  List<Widget> _buildButtonsRow() {
    return buttonValues.map((e) {
      int index = buttonValues.indexOf(e);
      bool disabled = disabledValues.contains(e);
      bool isSelected = _currentSelectedValue == e;
      return Card(
        margin:
            widget.margin ?? EdgeInsets.all(widget.absoluteZeroSpacing ? 0 : 4),
        color: disabled
            ? widget.disabledColor ?? widget.unSelectedColor
            : _currentSelectedValue == e
                ? widget.selectedColor
                : widget.unSelectedColor,
        elevation: widget.elevation,
        shape: widget.enableShape
            ? widget.customShape ??
                RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.all(Radius.circular(widget.shapeRadius)),
                )
            : null,
        child: Container(
          height: widget.height,
          width: widget.autoWidth ? null : widget.width,
          constraints: widget.autoWidth ? null : BoxConstraints(maxWidth: 250),
          child: MaterialButton(
            shape: widget.enableShape
                ? widget.customShape ??
                    OutlineInputBorder(
                      borderSide: BorderSide(color: _borderColor(e), width: 1),
                      borderRadius:
                          BorderRadius.all(Radius.circular(widget.shapeRadius)),
                    )
                : OutlineInputBorder(
                    borderSide: BorderSide(color: _borderColor(e), width: 1),
                    borderRadius: BorderRadius.zero,
                  ),
            onPressed: disabled ? null : () => selectButton(e),
            child: Text(
              widget.buttonLables[index],
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: textStyle(isSelected, disabled),
            ),
          ),
        ),
      );
    }).toList();
  }

  TextStyle textStyle(bool isSelected, bool disabled) {
    if (isSelected) {
      return widget.buttonTextStyle.selectedTextStyle.copyWith(
        color: disabled
            ? widget.buttonTextStyle.disabledColor
            : widget.buttonTextStyle.selectedColor,
      );
    }
    return widget.buttonTextStyle.textStyle.copyWith(
      color: disabled
          ? widget.buttonTextStyle.disabledColor
          : widget.buttonTextStyle.unSelectedColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildRadioButtons();
  }

  _buildRadioButtons() {
    if (widget.horizontal)
      return Container(
        height: widget.height * (widget.buttonLables.length * 1.5) +
            widget.padding * 2 * widget.buttonLables.length,
        child: Center(
          child: CustomListViewSpacing(
            spacing: widget.spacing,
            scrollController: widget.scrollController,
            scrollDirection: Axis.vertical,
            children: _buildButtonsColumn(),
          ),
        ),
      );
    if (!widget.horizontal && widget.enableButtonWrap)
      return Container(
        child: Center(
          child: Wrap(
            spacing: widget.spacing,
            direction: Axis.horizontal,
            alignment: widget.wrapAlignment,
            children: _buildButtonsRow(),
          ),
        ),
      );
    if (!widget.horizontal && !widget.enableButtonWrap)
      return Container(
        height: widget.height + widget.padding * 2,
        child: Center(
          child: CustomListViewSpacing(
            spacing: widget.spacing,
            scrollController: widget.scrollController,
            scrollDirection: Axis.horizontal,
            children: _buildButtonsRow(),
          ),
        ),
      );
  }
}
