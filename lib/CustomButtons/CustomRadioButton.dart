//library custom_radio_grouped_button;
import 'package:flutter/material.dart';

class CustomRadioButton extends StatefulWidget {
  CustomRadioButton({
    this.buttonLables,
    this.buttonValues,
    this.fontSize = 15,
    this.autoWidth = true,
    this.radioButtonValue,
    this.unSelectedColor,
    this.padding = 3,
    this.selectedColor,
    this.height = 35,
    this.width = 100,
    this.enableButtonWrap = false,
    this.horizontal = false,
    this.enableShape = false,
    this.elevation = 10,
    this.defaultSelected,
    this.customShape,
  })  : assert(buttonLables.length == buttonValues.length),
        assert(unSelectedColor != null),
        assert(selectedColor != null);

  final bool horizontal;

  final List buttonValues;

  final double height;
  final double padding;

  ///Default selected value
  final dynamic defaultSelected;

  ///Only applied when in vertical mode
  ///This will use minimum space required
  ///If enables it will ignore width field
  final bool autoWidth;

  ///Use this if you want to keep width of all the buttons same
  final double width;

  final List<String> buttonLables;

  final double fontSize;

  final Function(dynamic) radioButtonValue;

  ///Unselected Color of the button
  final Color unSelectedColor;

  ///Selected Color of button
  final Color selectedColor;

  /// A custom Shape can be applied (will work only if enableShape is true)
  final ShapeBorder customShape;

  /// This will enable button wrap (will work only if orientation is vertical)
  final bool enableButtonWrap;
  final bool enableShape;
  final double elevation;

  _CustomRadioButtonState createState() => _CustomRadioButtonState();
}

class _CustomRadioButtonState extends State<CustomRadioButton> {
  String _currentSelectedLabel;

  @override
  void initState() {
    super.initState();
    if (widget.defaultSelected != null) {
      if (widget.buttonValues.contains(widget.defaultSelected))
        _currentSelectedLabel = widget.defaultSelected;
      else
        throw Exception("Default Value not found in button value list");
    }
  }

  List<Widget> _buildButtonsColumn() {
    List<Widget> buttons = [];
    for (int index = 0; index < widget.buttonLables.length; index++) {
      var button = Padding(
        padding: EdgeInsets.all(widget.padding),
        child: Card(
          color: _currentSelectedLabel == widget.buttonLables[index]
              ? widget.selectedColor
              : widget.unSelectedColor,
          elevation: widget.elevation,
          shape: widget.enableShape
              ? widget.customShape == null
                  ? RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                    )
                  : widget.customShape
              : null,
          child: Container(
            height: widget.height,
            child: MaterialButton(
              shape: widget.enableShape
                  ? widget.customShape == null
                      ? OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).primaryColor, width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        )
                      : widget.customShape
                  : OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).primaryColor, width: 1),
                      borderRadius: BorderRadius.zero,
                    ),
              onPressed: () {
                widget.radioButtonValue(widget.buttonValues[index]);
                setState(() {
                  _currentSelectedLabel = widget.buttonLables[index];
                });
              },
              child: Text(
                widget.buttonLables[index],
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                  color: _currentSelectedLabel == widget.buttonLables[index]
                      ? Colors.white
                      : Theme.of(context).textTheme.bodyText1.color,
                  fontSize: widget.fontSize,
                ),
              ),
            ),
          ),
        ),
      );
      buttons.add(button);
    }
    return buttons;
  }

  List<Widget> _buildButtonsRow() {
    List<Widget> buttons = [];
    for (int index = 0; index < widget.buttonLables.length; index++) {
      var button = Card(
        color: _currentSelectedLabel == widget.buttonLables[index]
            ? widget.selectedColor
            : widget.unSelectedColor,
        elevation: widget.elevation,
        shape: widget.enableShape
            ? widget.customShape == null
                ? RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  )
                : widget.customShape
            : null,
        child: Container(
          height: widget.height,
          width: widget.autoWidth ? null : widget.width,
          constraints: BoxConstraints(maxWidth: 250),
          child: MaterialButton(
            shape: widget.enableShape
                ? widget.customShape == null
                    ? OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).primaryColor, width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      )
                    : widget.customShape
                : OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).primaryColor, width: 1),
                    borderRadius: BorderRadius.zero,
                  ),
            onPressed: () {
              widget.radioButtonValue(widget.buttonValues[index]);
              setState(() {
                _currentSelectedLabel = widget.buttonLables[index];
              });
            },
            child: Text(
              widget.buttonLables[index],
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(
                color: _currentSelectedLabel == widget.buttonLables[index]
                    ? Colors.white
                    : Theme.of(context).textTheme.bodyText1.color,
                fontSize: widget.fontSize,
              ),
            ),
          ),
        ),
      );
      buttons.add(button);
    }
    return buttons;
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
          child: ListView(
            scrollDirection: Axis.vertical,
            children: _buildButtonsColumn(),
          ),
        ),
      );
    if (!widget.horizontal && widget.enableButtonWrap)
      return Container(
        child: Center(
          child: Wrap(
            direction: Axis.horizontal,
            alignment: WrapAlignment.start,
            children: _buildButtonsRow(),
          ),
        ),
      );
    if (!widget.horizontal && !widget.enableButtonWrap)
      return Container(
        height: widget.height + widget.padding * 2,
        child: Center(
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: _buildButtonsRow(),
          ),
        ),
      );
  }
}
