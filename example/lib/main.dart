import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/material.dart';

import './RadioButtonPage.dart';

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
  const GroupedButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Grouped Button Example'),
        centerTitle: true,
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
                      CustomCheckBoxGroup<String>(
                        // scrollController: ScrollController(),
                        unSelectedColor: Theme.of(context).canvasColor,
                        buttonLables: [
                          "Monday",
                          "Tuesday",
                          "Wednesday",
                          "Thursday",
                        ],
                        disabledValues: [
                          "Monday",
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
                        defaultSelected: ["Monday"],
                        horizontal: true,
                        width: 120,
                        // hight: 50,
                        selectedColor: Theme.of(context).colorScheme.secondary,
                        padding: 5,
                        spacing: 0.0,
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
                        unSelectedColor: Theme.of(context).canvasColor,
                        buttonLables: [
                          "Thursday Thursday Thursday Thursday",
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
                        defaultSelected: ["Sunday"],
                        horizontal: true,
                        width: 120,
                        // hight: 50,
                        selectedColor: Theme.of(context).colorScheme.secondary,
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
                    CustomCheckBoxGroup(
                      buttonTextStyle: ButtonTextStyle(
                        selectedColor: Colors.pinkAccent,
                        unSelectedColor: Colors.orange,
                        textStyle: TextStyle(
                          fontSize: 16,
                        ),
                        selectedTextStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
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
                      disabledValues: [
                        "Monday",
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
                      defaultSelected: ["Monday"],
                      horizontal: false,
                      enableButtonWrap: false,
                      width: 40,
                      absoluteZeroSpacing: false,
                      selectedColor: Theme.of(context).colorScheme.secondary,
                      padding: 10,
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
                      'Shape Enabled and Wrap enabled',
                      style: TextStyle(fontSize: 15),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomCheckBoxGroup(
                      buttonTextStyle: ButtonTextStyle(
                        selectedColor: Colors.white,
                        unSelectedColor: Colors.black,
                        textStyle: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      autoWidth: false,
                      enableButtonWrap: true,
                      wrapAlignment: WrapAlignment.center,
                      unSelectedColor: Theme.of(context).canvasColor,
                      buttonLables: [
                        "Monday Monday Mondays",
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
                      defaultSelected: ["Sunday"],
                      horizontal: false,
                      width: 120,
                      // hight: 50,
                      selectedColor: Theme.of(context).colorScheme.secondary,
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
