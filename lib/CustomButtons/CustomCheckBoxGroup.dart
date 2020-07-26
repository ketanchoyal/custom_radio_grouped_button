//library custom_radio_grouped_button;
import 'package:flutter/material.dart';

class CustomCheckBoxGroup extends StatefulWidget {
  CustomCheckBoxGroup({
    this.buttonLables,
    this.fontSize = 15,
    this.buttonValuesList,
    this.checkBoxButtonValues,
    this.unSelectedColor,
    this.selectedColor,
    this.height = 35,
    this.width = 100,
    this.autoWidth = true,
    this.defaultSelected,
    this.padding = 3,
    this.horizontal = false,
    this.enableShape = false,
    this.elevation = 0,
    this.enableButtonWrap = false,
    this.customShape,
  })  : assert(buttonLables.length == buttonValuesList.length),
        assert(unSelectedColor != null),
        // assert(defaultSelected != null
        // ? buttonValuesList.contains(defaultSelected) != false
        // : true),
        assert(selectedColor != null);

  final bool horizontal;

  final List buttonValuesList;
  final double fontSize;

  final double height;
  final double padding;

  ///Only applied when in vertical mode
  ///This will use minimum space required
  ///If enables it will ignore width field
  final bool autoWidth;

  ///Use this if you want to keep width of all the buttons same
  final double width;
  final bool enableShape;
  final double elevation;

  final List<String> buttonLables;

  final Function(List<dynamic>) checkBoxButtonValues;

  ///Selected Color of button
  final Color selectedColor;

  ///Default Selected button
  final dynamic defaultSelected;

  ///Unselected Color of the button
  final Color unSelectedColor;

  /// A custom Shape can be applied (will work only if enableShape is true)
  final ShapeBorder customShape;

  /// This will enable button wrap (will work only if orientation is vertical)
  final bool enableButtonWrap;

  _CustomCheckBoxGroupState createState() => _CustomCheckBoxGroupState();
}

class _CustomCheckBoxGroupState extends State<CustomCheckBoxGroup> {
  List<dynamic> selectedLables = [];

  @override
  void initState() {
    super.initState();
    if (widget.defaultSelected != null) {
      if (widget.buttonValuesList.contains(widget.defaultSelected))
        selectedLables.add(widget.defaultSelected);
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
          color: selectedLables.contains(widget.buttonValuesList[index])
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
                if (selectedLables.contains(widget.buttonValuesList[index])) {
                  selectedLables.remove(widget.buttonValuesList[index]);
                } else {
                  selectedLables.add(widget.buttonValuesList[index]);
                }
                setState(() {});
                widget.checkBoxButtonValues(selectedLables);
              },
              child: Text(
                widget.buttonLables[index],
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                  color: selectedLables.contains(widget.buttonValuesList[index])
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
        color: selectedLables.contains(widget.buttonValuesList[index])
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
          decoration: BoxDecoration(),
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
              if (selectedLables.contains(widget.buttonValuesList[index])) {
                selectedLables.remove(widget.buttonValuesList[index]);
              } else {
                selectedLables.add(widget.buttonValuesList[index]);
              }
              setState(() {});
              widget.checkBoxButtonValues(selectedLables);
            },
            child: Text(
              widget.buttonLables[index],
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(
                color: selectedLables.contains(widget.buttonValuesList[index])
                    ? Colors.white
                    : Theme.of(context).textTheme.bodyText1.color,
                fontSize: widget.fontSize,
              ),
            ),
          ),
        ),
        // ),
      );
      buttons.add(button);
    }
    return buttons;
  }

  @override
  Widget build(BuildContext context) {
    return _buildCheckBoxButtons();
  }

  _buildCheckBoxButtons() {
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
