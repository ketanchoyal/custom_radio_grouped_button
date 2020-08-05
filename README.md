# custom_radio_grouped_button

[![Pub](https://img.shields.io/pub/v/custom_radio_grouped_button)](https://pub.dartlang.org/packages/custom_radio_grouped_button)

Custom Radio Buttons and Grouped Check Box Button

Custom Flutter widgets that makes Checkbox and Radio Buttons much cleaner and easier.

## Breaking Changes:
  From Version 1.0.2

    buttonColor is now unSelectedColor

## Installing

Add the following to your `pubspec.yaml` file:

    dependencies:
      custom_radio_grouped_button: any

# Creating Radio Button

    CustomRadioButton(
      elevation: 0,
      absoluteZeroSpacing: true,
      unSelectedColor: Theme.of(context).canvasColor,
      buttonLables: [
        'Student',
        'Parent',
        'Teacher',
      ],
      buttonValues: [
        "STUDENT",
        "PARENT",
        "TEACHER",
      ],
      buttonTextStyle: ButtonTextStyle(
          selectedColor: Colors.white,
          unSelectedColor: Colors.black,
          textStyle: TextStyle(fontSize: 16)),
      radioButtonValue: (value) {
        print(value);
      },
      selectedColor: Theme.of(context).accentColor,
    ),

# Creating Grouped Button


    CustomCheckBoxGroup(
      buttonTextStyle: ButtonTextStyle(
        selectedColor: Colors.red,
        unSelectedColor: Colors.orange,
        textStyle: TextStyle(
          fontSize: 16,
        ),
      ),
      unSelectedColor: Theme.of(context).canvasColor,
      buttonLables: [
        "M",
        "T",
        "W",
        "T",
        "F",
        "S",
        "S",
      ],
      buttonValuesList: [
        "Monday",
        "Tuesday",
        "Wednesday",
        "Thursday",
        "Friday",
        "Saturday",
        "Sunday",
      ],
      checkBoxButtonValues: (values) {
        print(values);
      },
      spacing: 0,
      defaultSelected: "Monday",
      horizontal: false,
      enableButtonWrap: false,
      width: 40,
      absoluteZeroSpacing: false,
      selectedColor: Theme.of(context).accentColor,
      padding: 10, 
    );


## Screenshots

<img src="https://github.com/ketanchoyal/custom_radio_grouped_button/raw/dev/ScreenShots/GroupButton.gif" alt="Grouped Button"/>

<img src="https://github.com/ketanchoyal/custom_radio_grouped_button/raw/dev/ScreenShots/RadioButton.gif" alt="Grouped Button"/>