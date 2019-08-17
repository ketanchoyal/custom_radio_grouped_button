import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: GroupedButton());
  }
}

class GroupedButton extends StatelessWidget {
  const GroupedButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Grouped Button Example'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text('Radio Button'),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => RadioButton()));
        },
        icon: Icon(Icons.radio_button_checked),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Text(
              'Horizontal',
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
                      CustomCheckBoxGroup(
                        buttonColor: Theme.of(context).canvasColor,
                        buttonLables: [
                          "Monday",
                          "Tuesday",
                          "Wednesday",
                          "Thursday",
                        ],
                        buttonValuesList: [
                          "Monday",
                          "Tuesday",
                          "Wednesday",
                          "Thursday",
                        ],
                        checkBoxButtonValues: (values) {
                          print(values);
                        },
                        defaultSelected: "Monday",
                        horizontal: true,
                        width: 120,
                        // hight: 50,
                        selectedColor: Theme.of(context).accentColor,
                        padding: 5,
                        // enableShape: true,
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
                      CustomCheckBoxGroup(
                        buttonColor: Theme.of(context).canvasColor,
                        buttonLables: [
                          "Thursday",
                          "Friday",
                          "Saturday",
                          "Sunday",
                        ],
                        buttonValuesList: [
                          "Thursday",
                          "Friday",
                          "Saturday",
                          "Sunday",
                        ],
                        checkBoxButtonValues: (values) {
                          print(values);
                        },
                        defaultSelected: "Sunday",
                        horizontal: true,
                        width: 120,
                        // hight: 50,
                        selectedColor: Theme.of(context).accentColor,
                        padding: 5,
                        enableShape: true,
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
                    CustomCheckBoxGroup(
                      buttonColor: Theme.of(context).canvasColor,
                      buttonLables: [
                        "Monday",
                        "Tuesday",
                        "Wednesday",
                        "Thursday",
                        "Friday",
                        "Saturday",
                        "Sunday",
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
                      defaultSelected: "Monday",
                      horizontal: false,
                      width: 120,
                      // hight: 50,
                      selectedColor: Theme.of(context).accentColor,
                      padding: 5,
                      // enableShape: true,
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
                    CustomCheckBoxGroup(
                      buttonColor: Theme.of(context).canvasColor,
                      buttonLables: [
                        "Monday",
                        "Tuesday",
                        "Wednesday",
                        "Thursday",
                        "Friday",
                        "Saturday",
                        "Sunday",
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
                      defaultSelected: "Sunday",
                      horizontal: false,
                      width: 120,
                      // hight: 50,
                      selectedColor: Theme.of(context).accentColor,
                      padding: 5,
                      enableShape: true,
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

class RadioButton extends StatelessWidget {
  const RadioButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Radio Button Example'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text('Grouped Button'),
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(Icons.check_box),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Text(
              'Horizontal',
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
                        buttonColor: Theme.of(context).canvasColor,
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
                        buttonColor: Theme.of(context).canvasColor,
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
                      buttonColor: Theme.of(context).canvasColor,
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
                      buttonColor: Theme.of(context).canvasColor,
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
