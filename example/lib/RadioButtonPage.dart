import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/material.dart';

class RadioButton extends StatelessWidget {
  const RadioButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Radio Button Example'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text('Grouped Button'),
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(Icons.check_box),
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Text(
              'Horizontal',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Shape Disabled',
                        style: TextStyle(fontSize: 15),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomRadioButton(
                        horizontal: true,
                        unSelectedColor: Theme.of(context).canvasColor,
                        buttonLables: [
                          'Student',
                          'Parent',
                          'Teacher',
                          'hgfh',
                          'jhgiugx'
                        ],
                        buttonValues: [
                          "STUDENT",
                          "PARENT",
                          "TEACHER",
                          'hgfh',
                          'jhgiugx'
                        ],
                        defaultSelected: "STUDENT",
                        radioButtonValue: (value) {
                          print(value);
                        },
                        selectedColor: Theme.of(context).accentColor,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Shape Enabled',
                        style: TextStyle(fontSize: 15),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomRadioButton(
                        horizontal: true,
                        enableShape: true,
                        elevation: 0,
                        unSelectedColor: Theme.of(context).canvasColor,
                        buttonLables: [
                          'Student',
                          'Parent',
                          'Teacher',
                        ],
                        buttonValues: [
                          1,
                          2,
                          3,
                        ],
                        defaultSelected: 1,
                        radioButtonValue: (value) {
                          print(value);
                        },
                        selectedColor: Theme.of(context).accentColor,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Verticle',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Shape Disabled',
                      style: TextStyle(fontSize: 15),
                    ),
                    SizedBox(
                      height: 10,
                    ),
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
                  ],
                ),
                Column(
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Shape Enabled',
                      style: TextStyle(fontSize: 15),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomRadioButton(
                      enableShape: true,
                      elevation: 0,
                      defaultSelected: "Sunday",
                      enableButtonWrap: true,
                      width: 120,
                      autoWidth: false,
                      unSelectedColor: Theme.of(context).canvasColor,
                      buttonLables: [
                        "Monday",
                        "Tuesday",
                        "Wednesday",
                        "Thursday",
                        "Friday",
                        "Saturday",
                        "Sunday",
                      ],
                      buttonValues: [
                        "Monday",
                        "Tuesday",
                        "Wednesday",
                        "Thursday",
                        "Friday",
                        "Saturday",
                        "Sunday",
                      ],
                      radioButtonValue: (value) {
                        print(value);
                      },
                      selectedColor: Theme.of(context).accentColor,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
