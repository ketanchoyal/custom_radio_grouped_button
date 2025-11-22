import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';

void main() {
  group('ButtonTextStyle', () {
    test('should create ButtonTextStyle with default values', () {
      const style = ButtonTextStyle();
      expect(style.selectedColor, Colors.white);
      expect(style.unSelectedColor, Colors.black);
      expect(style.disabledColor, Colors.grey);
      expect(style.textStyle, const TextStyle());
      expect(style.selectedTextStyle, const TextStyle());
    });

    test('should create ButtonTextStyle with custom values', () {
      const style = ButtonTextStyle(
        selectedColor: Colors.blue,
        unSelectedColor: Colors.red,
        disabledColor: Colors.grey,
        textStyle: TextStyle(fontSize: 16),
        selectedTextStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      );
      expect(style.selectedColor, Colors.blue);
      expect(style.unSelectedColor, Colors.red);
      expect(style.disabledColor, Colors.grey);
      expect(style.textStyle.fontSize, 16);
      expect(style.selectedTextStyle.fontSize, 18);
    });

    test('selectedTextStyle should default to textStyle when not provided', () {
      const textStyle = TextStyle(fontSize: 20);
      const style = ButtonTextStyle(textStyle: textStyle);
      expect(style.selectedTextStyle, textStyle);
    });
  });

  group('CustomRadioButton', () {
    testWidgets('should render radio buttons correctly', (tester) async {
      final values = [1, 2, 3];
      final labels = ['One', 'Two', 'Three'];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomRadioButton<int>(
              buttonLables: labels,
              buttonValues: values,
              radioButtonValue: (_) {},
              selectedColor: Colors.blue,
              unSelectedColor: Colors.grey,
            ),
          ),
        ),
      );

      expect(find.text('One'), findsOneWidget);
      expect(find.text('Two'), findsOneWidget);
      expect(find.text('Three'), findsOneWidget);
    });

    testWidgets('should select button on tap', (tester) async {
      final values = [1, 2, 3];
      final labels = ['One', 'Two', 'Three'];
      int? selectedValue;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomRadioButton<int>(
              buttonLables: labels,
              buttonValues: values,
              radioButtonValue: (value) {
                selectedValue = value;
              },
              selectedColor: Colors.blue,
              unSelectedColor: Colors.grey,
            ),
          ),
        ),
      );

      await tester.tap(find.text('Two'));
      await tester.pump();

      expect(selectedValue, 2);
    });

    testWidgets('should set default selected value', (tester) async {
      final values = [1, 2, 3];
      final labels = ['One', 'Two', 'Three'];
      int? selectedValue;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomRadioButton<int>(
              buttonLables: labels,
              buttonValues: values,
              defaultSelected: 2,
              radioButtonValue: (value) {
                selectedValue = value;
              },
              selectedColor: Colors.blue,
              unSelectedColor: Colors.grey,
            ),
          ),
        ),
      );

      // Verify default selection by triggering callback is not called initially
      expect(selectedValue, null);

      // Tap another button to verify selection works
      await tester.tap(find.text('One'));
      await tester.pump();
      expect(selectedValue, 1);
    });

    testWidgets(
        'should throw assertion error when labels and values length mismatch',
        (tester) async {
      expect(
        () => CustomRadioButton<int>(
          buttonLables: ['One', 'Two'],
          buttonValues: [1, 2, 3],
          radioButtonValue: (_) {},
          selectedColor: Colors.blue,
          unSelectedColor: Colors.grey,
        ),
        throwsAssertionError,
      );
    });

    testWidgets('should throw assertion error for duplicate values',
        (tester) async {
      expect(
        () => CustomRadioButton<int>(
          buttonLables: ['One', 'Two', 'Three'],
          buttonValues: [1, 2, 2],
          radioButtonValue: (_) {},
          selectedColor: Colors.blue,
          unSelectedColor: Colors.grey,
        ),
        throwsAssertionError,
      );
    });

    testWidgets('should render horizontal orientation', (tester) async {
      final values = [1, 2];
      final labels = ['One', 'Two'];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomRadioButton<int>(
              buttonLables: labels,
              buttonValues: values,
              horizontal: true,
              radioButtonValue: (_) {},
              selectedColor: Colors.blue,
              unSelectedColor: Colors.grey,
            ),
          ),
        ),
      );

      expect(find.byType(CustomListViewSpacing), findsOneWidget);
      final listView = tester.widget<CustomListViewSpacing>(
        find.byType(CustomListViewSpacing),
      );
      expect(listView.scrollDirection, Axis.vertical);
    });

    testWidgets('should render with wrap enabled', (tester) async {
      final values = [1, 2, 3];
      final labels = ['One', 'Two', 'Three'];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomRadioButton<int>(
              buttonLables: labels,
              buttonValues: values,
              enableButtonWrap: true,
              radioButtonValue: (_) {},
              selectedColor: Colors.blue,
              unSelectedColor: Colors.grey,
            ),
          ),
        ),
      );

      expect(find.byType(Wrap), findsOneWidget);
    });

    testWidgets('should disable specific buttons', (tester) async {
      final values = [1, 2, 3];
      final labels = ['One', 'Two', 'Three'];
      int? selectedValue;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomRadioButton<int>(
              buttonLables: labels,
              buttonValues: values,
              disabledValues: [2],
              radioButtonValue: (value) {
                selectedValue = value;
              },
              selectedColor: Colors.blue,
              unSelectedColor: Colors.grey,
            ),
          ),
        ),
      );

      // Try to tap disabled button
      await tester.tap(find.text('Two'));
      await tester.pump();

      // Value should not change
      expect(selectedValue, null);
    });

    testWidgets('should apply custom shape when enabled', (tester) async {
      final values = [1, 2];
      final labels = ['One', 'Two'];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomRadioButton<int>(
              buttonLables: labels,
              buttonValues: values,
              enableShape: true,
              shapeRadius: 25,
              radioButtonValue: (_) {},
              selectedColor: Colors.blue,
              unSelectedColor: Colors.grey,
            ),
          ),
        ),
      );

      final cards = tester.widgetList<Card>(find.byType(Card));
      for (final card in cards) {
        expect(card.shape, isA<RoundedRectangleBorder>());
      }
    });

    testWidgets('should work with string values', (tester) async {
      final values = ['apple', 'banana', 'cherry'];
      final labels = ['Apple', 'Banana', 'Cherry'];
      String? selectedValue;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomRadioButton<String>(
              buttonLables: labels,
              buttonValues: values,
              radioButtonValue: (value) {
                selectedValue = value;
              },
              selectedColor: Colors.blue,
              unSelectedColor: Colors.grey,
            ),
          ),
        ),
      );

      await tester.tap(find.text('Banana'));
      await tester.pump();

      expect(selectedValue, 'banana');
    });

    testWidgets('should programmatically select button', (tester) async {
      final values = [1, 2, 3];
      final labels = ['One', 'Two', 'Three'];
      int? selectedValue;
      final key = GlobalKey<CustomRadioButtonState<int>>();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomRadioButton<int>(
              key: key,
              buttonLables: labels,
              buttonValues: values,
              radioButtonValue: (value) {
                selectedValue = value;
              },
              selectedColor: Colors.blue,
              unSelectedColor: Colors.grey,
            ),
          ),
        ),
      );

      key.currentState?.selectButton(3);
      await tester.pump();

      expect(selectedValue, 3);
    });

    testWidgets('should apply absoluteZeroSpacing', (tester) async {
      final values = [1, 2];
      final labels = ['One', 'Two'];

      final widget = CustomRadioButton<int>(
        buttonLables: labels,
        buttonValues: values,
        absoluteZeroSpacing: true,
        radioButtonValue: (_) {},
        selectedColor: Colors.blue,
        unSelectedColor: Colors.grey,
      );

      expect(widget.padding, 0);
      expect(widget.spacing, 0);
    });

    testWidgets('should apply custom padding and spacing', (tester) async {
      final values = [1, 2];
      final labels = ['One', 'Two'];

      final widget = CustomRadioButton<int>(
        buttonLables: labels,
        buttonValues: values,
        padding: 5,
        spacing: 10,
        radioButtonValue: (_) {},
        selectedColor: Colors.blue,
        unSelectedColor: Colors.grey,
      );

      expect(widget.padding, 5);
      expect(widget.spacing, 10);
    });
  });

  group('CustomCheckBoxGroup', () {
    testWidgets('should render checkbox buttons correctly', (tester) async {
      final values = [1, 2, 3];
      final labels = ['One', 'Two', 'Three'];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomCheckBoxGroup<int>(
              buttonLables: labels,
              buttonValuesList: values,
              checkBoxButtonValues: (_) {},
              selectedColor: Colors.blue,
              unSelectedColor: Colors.grey,
            ),
          ),
        ),
      );

      expect(find.text('One'), findsOneWidget);
      expect(find.text('Two'), findsOneWidget);
      expect(find.text('Three'), findsOneWidget);
    });

    testWidgets('should toggle checkbox on tap', (tester) async {
      final values = [1, 2, 3];
      final labels = ['One', 'Two', 'Three'];
      List<int> selectedValues = [];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomCheckBoxGroup<int>(
              buttonLables: labels,
              buttonValuesList: values,
              checkBoxButtonValues: (values) {
                selectedValues = values;
              },
              selectedColor: Colors.blue,
              unSelectedColor: Colors.grey,
            ),
          ),
        ),
      );

      await tester.tap(find.text('Two'));
      await tester.pump();

      expect(selectedValues.length, 1);
      expect(selectedValues.contains(2), true);

      // Tap again to deselect
      await tester.tap(find.text('Two'));
      await tester.pump();

      expect(selectedValues.length, 0);
    });

    testWidgets('should allow multiple selections', (tester) async {
      final values = [1, 2, 3];
      final labels = ['One', 'Two', 'Three'];
      List<int> selectedValues = [];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomCheckBoxGroup<int>(
              buttonLables: labels,
              buttonValuesList: values,
              checkBoxButtonValues: (values) {
                selectedValues = values;
              },
              selectedColor: Colors.blue,
              unSelectedColor: Colors.grey,
            ),
          ),
        ),
      );

      await tester.tap(find.text('One'));
      await tester.pump();
      await tester.tap(find.text('Three'));
      await tester.pump();

      expect(selectedValues.length, 2);
      expect(selectedValues.contains(1), true);
      expect(selectedValues.contains(3), true);
    });

    testWidgets('should set default selected values', (tester) async {
      final values = [1, 2, 3];
      final labels = ['One', 'Two', 'Three'];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomCheckBoxGroup<int>(
              buttonLables: labels,
              buttonValuesList: values,
              defaultSelected: [1, 3],
              checkBoxButtonValues: (_) {},
              selectedColor: Colors.blue,
              unSelectedColor: Colors.grey,
            ),
          ),
        ),
      );

      final state = tester.state<CustomCheckBoxGroupState<int>>(
        find.byType(CustomCheckBoxGroup<int>),
      );
      expect(state.selectedValues.length, 2);
      expect(state.selectedValues.contains(1), true);
      expect(state.selectedValues.contains(3), true);
    });

    testWidgets(
        'should throw assertion error when labels and values length mismatch',
        (tester) async {
      expect(
        () => CustomCheckBoxGroup<int>(
          buttonLables: ['One', 'Two'],
          buttonValuesList: [1, 2, 3],
          checkBoxButtonValues: (_) {},
          selectedColor: Colors.blue,
          unSelectedColor: Colors.grey,
        ),
        throwsAssertionError,
      );
    });

    testWidgets('should throw assertion error for duplicate values',
        (tester) async {
      expect(
        () => CustomCheckBoxGroup<int>(
          buttonLables: ['One', 'Two', 'Three'],
          buttonValuesList: [1, 2, 2],
          checkBoxButtonValues: (_) {},
          selectedColor: Colors.blue,
          unSelectedColor: Colors.grey,
        ),
        throwsAssertionError,
      );
    });

    testWidgets('should render horizontal orientation', (tester) async {
      final values = [1, 2];
      final labels = ['One', 'Two'];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomCheckBoxGroup<int>(
              buttonLables: labels,
              buttonValuesList: values,
              horizontal: true,
              checkBoxButtonValues: (_) {},
              selectedColor: Colors.blue,
              unSelectedColor: Colors.grey,
            ),
          ),
        ),
      );

      expect(find.byType(CustomListViewSpacing), findsOneWidget);
      final listView = tester.widget<CustomListViewSpacing>(
        find.byType(CustomListViewSpacing),
      );
      expect(listView.scrollDirection, Axis.vertical);
    });

    testWidgets('should render with wrap enabled', (tester) async {
      final values = [1, 2, 3];
      final labels = ['One', 'Two', 'Three'];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomCheckBoxGroup<int>(
              buttonLables: labels,
              buttonValuesList: values,
              enableButtonWrap: true,
              checkBoxButtonValues: (_) {},
              selectedColor: Colors.blue,
              unSelectedColor: Colors.grey,
            ),
          ),
        ),
      );

      expect(find.byType(Wrap), findsOneWidget);
    });

    testWidgets('should disable specific checkboxes', (tester) async {
      final values = [1, 2, 3];
      final labels = ['One', 'Two', 'Three'];
      List<int> selectedValues = [];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomCheckBoxGroup<int>(
              buttonLables: labels,
              buttonValuesList: values,
              disabledValues: [2],
              checkBoxButtonValues: (values) {
                selectedValues = values;
              },
              selectedColor: Colors.blue,
              unSelectedColor: Colors.grey,
            ),
          ),
        ),
      );

      // Try to tap disabled button
      await tester.tap(find.text('Two'));
      await tester.pump();

      // Value should not change
      expect(selectedValues.length, 0);
    });

    testWidgets('should programmatically select button', (tester) async {
      final values = [1, 2, 3];
      final labels = ['One', 'Two', 'Three'];
      List<int> selectedValues = [];
      final key = GlobalKey<CustomCheckBoxGroupState<int>>();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomCheckBoxGroup<int>(
              key: key,
              buttonLables: labels,
              buttonValuesList: values,
              checkBoxButtonValues: (values) {
                selectedValues = values;
              },
              selectedColor: Colors.blue,
              unSelectedColor: Colors.grey,
            ),
          ),
        ),
      );

      key.currentState?.selectButton(2);
      await tester.pump();

      expect(selectedValues.length, 1);
      expect(selectedValues.contains(2), true);
    });

    testWidgets('should clear all selections when null is passed',
        (tester) async {
      final values = [1, 2, 3];
      final labels = ['One', 'Two', 'Three'];
      List<int> selectedValues = [];
      final key = GlobalKey<CustomCheckBoxGroupState<int>>();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomCheckBoxGroup<int>(
              key: key,
              buttonLables: labels,
              buttonValuesList: values,
              defaultSelected: [1, 2],
              checkBoxButtonValues: (values) {
                selectedValues = values;
              },
              selectedColor: Colors.blue,
              unSelectedColor: Colors.grey,
            ),
          ),
        ),
      );

      expect(key.currentState?.selectedValues.length, 2);

      key.currentState?.selectButton(null);
      await tester.pump();

      expect(selectedValues.length, 0);
      expect(key.currentState?.selectedValues.length, 0);
    });

    testWidgets('should apply custom shape when enabled', (tester) async {
      final values = [1, 2];
      final labels = ['One', 'Two'];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomCheckBoxGroup<int>(
              buttonLables: labels,
              buttonValuesList: values,
              enableShape: true,
              shapeRadius: 25,
              checkBoxButtonValues: (_) {},
              selectedColor: Colors.blue,
              unSelectedColor: Colors.grey,
            ),
          ),
        ),
      );

      final cards = tester.widgetList<Card>(find.byType(Card));
      for (final card in cards) {
        expect(card.shape, isA<RoundedRectangleBorder>());
      }
    });

    testWidgets('should work with string values', (tester) async {
      final values = ['apple', 'banana', 'cherry'];
      final labels = ['Apple', 'Banana', 'Cherry'];
      List<String> selectedValues = [];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomCheckBoxGroup<String>(
              buttonLables: labels,
              buttonValuesList: values,
              checkBoxButtonValues: (values) {
                selectedValues = values;
              },
              selectedColor: Colors.blue,
              unSelectedColor: Colors.grey,
            ),
          ),
        ),
      );

      await tester.tap(find.text('Banana'));
      await tester.pump();
      await tester.tap(find.text('Cherry'));
      await tester.pump();

      expect(selectedValues.length, 2);
      expect(selectedValues.contains('banana'), true);
      expect(selectedValues.contains('cherry'), true);
    });

    testWidgets('should apply absoluteZeroSpacing', (tester) async {
      final values = [1, 2];
      final labels = ['One', 'Two'];

      final widget = CustomCheckBoxGroup<int>(
        buttonLables: labels,
        buttonValuesList: values,
        absoluteZeroSpacing: true,
        checkBoxButtonValues: (_) {},
        selectedColor: Colors.blue,
        unSelectedColor: Colors.grey,
      );

      expect(widget.padding, 0);
      expect(widget.spacing, 0);
    });

    testWidgets('should apply custom padding and spacing', (tester) async {
      final values = [1, 2];
      final labels = ['One', 'Two'];

      final widget = CustomCheckBoxGroup<int>(
        buttonLables: labels,
        buttonValuesList: values,
        padding: 5,
        spacing: 10,
        checkBoxButtonValues: (_) {},
        selectedColor: Colors.blue,
        unSelectedColor: Colors.grey,
      );

      expect(widget.padding, 5);
      expect(widget.spacing, 10);
    });
  });

  group('CustomRadioButton - radioButtonValue callback', () {
    testWidgets('should call radioButtonValue when button is tapped',
        (tester) async {
      final values = [1, 2, 3];
      final labels = ['One', 'Two', 'Three'];
      int? callbackValue;
      int callbackCount = 0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomRadioButton<int>(
              buttonLables: labels,
              buttonValues: values,
              radioButtonValue: (value) {
                callbackValue = value;
                callbackCount++;
              },
              selectedColor: Colors.blue,
              unSelectedColor: Colors.grey,
            ),
          ),
        ),
      );

      await tester.tap(find.text('Two'));
      await tester.pump();

      expect(callbackValue, 2);
      expect(callbackCount, 1);
    });

    testWidgets('should call radioButtonValue with correct value on each tap',
        (tester) async {
      final values = [1, 2, 3];
      final labels = ['One', 'Two', 'Three'];
      final List<int?> callbackValues = [];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomRadioButton<int>(
              buttonLables: labels,
              buttonValues: values,
              radioButtonValue: (value) {
                callbackValues.add(value);
              },
              selectedColor: Colors.blue,
              unSelectedColor: Colors.grey,
            ),
          ),
        ),
      );

      await tester.tap(find.text('One'));
      await tester.pump();
      await tester.tap(find.text('Three'));
      await tester.pump();
      await tester.tap(find.text('Two'));
      await tester.pump();

      expect(callbackValues, [1, 3, 2]);
    });

    testWidgets(
        'should call radioButtonValue when selecting same button multiple times',
        (tester) async {
      final values = [1, 2, 3];
      final labels = ['One', 'Two', 'Three'];
      final List<int?> callbackValues = [];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomRadioButton<int>(
              buttonLables: labels,
              buttonValues: values,
              radioButtonValue: (value) {
                callbackValues.add(value);
              },
              selectedColor: Colors.blue,
              unSelectedColor: Colors.grey,
            ),
          ),
        ),
      );

      await tester.tap(find.text('Two'));
      await tester.pump();
      await tester.tap(find.text('Two'));
      await tester.pump();

      expect(callbackValues, [2, 2]);
    });

    testWidgets('should call radioButtonValue with string values',
        (tester) async {
      final values = ['apple', 'banana', 'cherry'];
      final labels = ['Apple', 'Banana', 'Cherry'];
      String? callbackValue;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomRadioButton<String>(
              buttonLables: labels,
              buttonValues: values,
              radioButtonValue: (value) {
                callbackValue = value;
              },
              selectedColor: Colors.blue,
              unSelectedColor: Colors.grey,
            ),
          ),
        ),
      );

      await tester.tap(find.text('Banana'));
      await tester.pump();

      expect(callbackValue, 'banana');
    });

    testWidgets('should call radioButtonValue when selectButton is called',
        (tester) async {
      final values = [1, 2, 3];
      final labels = ['One', 'Two', 'Three'];
      int? callbackValue;
      final key = GlobalKey<CustomRadioButtonState<int>>();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomRadioButton<int>(
              key: key,
              buttonLables: labels,
              buttonValues: values,
              radioButtonValue: (value) {
                callbackValue = value;
              },
              selectedColor: Colors.blue,
              unSelectedColor: Colors.grey,
            ),
          ),
        ),
      );

      key.currentState?.selectButton(3);
      await tester.pump();

      expect(callbackValue, 3);
    });

    testWidgets('should call radioButtonValue with null when deselecting',
        (tester) async {
      final values = [1, 2, 3];
      final labels = ['One', 'Two', 'Three'];
      int? callbackValue = 999; // Initialize with non-null
      final key = GlobalKey<CustomRadioButtonState<int>>();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomRadioButton<int>(
              key: key,
              buttonLables: labels,
              buttonValues: values,
              radioButtonValue: (value) {
                callbackValue = value;
              },
              selectedColor: Colors.blue,
              unSelectedColor: Colors.grey,
            ),
          ),
        ),
      );

      key.currentState?.selectButton(null);
      await tester.pump();

      expect(callbackValue, null);
    });

    testWidgets('should not call radioButtonValue when tapping disabled button',
        (tester) async {
      final values = [1, 2, 3];
      final labels = ['One', 'Two', 'Three'];
      int callbackCount = 0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomRadioButton<int>(
              buttonLables: labels,
              buttonValues: values,
              disabledValues: [2],
              radioButtonValue: (value) {
                callbackCount++;
              },
              selectedColor: Colors.blue,
              unSelectedColor: Colors.grey,
            ),
          ),
        ),
      );

      await tester.tap(find.text('Two'));
      await tester.pump();

      expect(callbackCount, 0);
    });
  });

  group('CustomCheckBoxGroup - checkBoxButtonValues callback', () {
    testWidgets('should call checkBoxButtonValues when button is tapped',
        (tester) async {
      final values = [1, 2, 3];
      final labels = ['One', 'Two', 'Three'];
      List<int>? callbackValue;
      int callbackCount = 0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomCheckBoxGroup<int>(
              buttonLables: labels,
              buttonValuesList: values,
              checkBoxButtonValues: (value) {
                callbackValue = value;
                callbackCount++;
              },
              selectedColor: Colors.blue,
              unSelectedColor: Colors.grey,
            ),
          ),
        ),
      );

      await tester.tap(find.text('Two'));
      await tester.pump();

      expect(callbackValue, [2]);
      expect(callbackCount, 1);
    });

    testWidgets(
        'should call checkBoxButtonValues with updated list on each tap',
        (tester) async {
      final values = [1, 2, 3];
      final labels = ['One', 'Two', 'Three'];
      final List<List<int>> callbackValues = [];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomCheckBoxGroup<int>(
              buttonLables: labels,
              buttonValuesList: values,
              checkBoxButtonValues: (value) {
                callbackValues.add(List.from(value));
              },
              selectedColor: Colors.blue,
              unSelectedColor: Colors.grey,
            ),
          ),
        ),
      );

      await tester.tap(find.text('One'));
      await tester.pump();
      await tester.tap(find.text('Three'));
      await tester.pump();
      await tester.tap(find.text('Two'));
      await tester.pump();

      expect(callbackValues.length, 3);
      expect(callbackValues[0], [1]);
      expect(callbackValues[1], [1, 3]);
      expect(callbackValues[2], [1, 3, 2]);
    });

    testWidgets('should call checkBoxButtonValues when toggling selection',
        (tester) async {
      final values = [1, 2, 3];
      final labels = ['One', 'Two', 'Three'];
      final List<List<int>> callbackValues = [];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomCheckBoxGroup<int>(
              buttonLables: labels,
              buttonValuesList: values,
              checkBoxButtonValues: (value) {
                callbackValues.add(List.from(value));
              },
              selectedColor: Colors.blue,
              unSelectedColor: Colors.grey,
            ),
          ),
        ),
      );

      await tester.tap(find.text('Two'));
      await tester.pump();
      await tester.tap(find.text('Two'));
      await tester.pump();

      expect(callbackValues.length, 2);
      expect(callbackValues[0], [2]);
      expect(callbackValues[1], []);
    });

    testWidgets('should call checkBoxButtonValues with multiple selections',
        (tester) async {
      final values = [1, 2, 3];
      final labels = ['One', 'Two', 'Three'];
      List<int>? callbackValue;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomCheckBoxGroup<int>(
              buttonLables: labels,
              buttonValuesList: values,
              checkBoxButtonValues: (value) {
                callbackValue = value;
              },
              selectedColor: Colors.blue,
              unSelectedColor: Colors.grey,
            ),
          ),
        ),
      );

      await tester.tap(find.text('One'));
      await tester.pump();
      await tester.tap(find.text('Two'));
      await tester.pump();
      await tester.tap(find.text('Three'));
      await tester.pump();

      expect(callbackValue, [1, 2, 3]);
    });

    testWidgets('should call checkBoxButtonValues with string values',
        (tester) async {
      final values = ['apple', 'banana', 'cherry'];
      final labels = ['Apple', 'Banana', 'Cherry'];
      List<String>? callbackValue;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomCheckBoxGroup<String>(
              buttonLables: labels,
              buttonValuesList: values,
              checkBoxButtonValues: (value) {
                callbackValue = value;
              },
              selectedColor: Colors.blue,
              unSelectedColor: Colors.grey,
            ),
          ),
        ),
      );

      await tester.tap(find.text('Banana'));
      await tester.pump();
      await tester.tap(find.text('Cherry'));
      await tester.pump();

      expect(callbackValue, ['banana', 'cherry']);
    });

    testWidgets('should call checkBoxButtonValues when selectButton is called',
        (tester) async {
      final values = [1, 2, 3];
      final labels = ['One', 'Two', 'Three'];
      List<int>? callbackValue;
      final key = GlobalKey<CustomCheckBoxGroupState<int>>();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomCheckBoxGroup<int>(
              key: key,
              buttonLables: labels,
              buttonValuesList: values,
              checkBoxButtonValues: (value) {
                callbackValue = value;
              },
              selectedColor: Colors.blue,
              unSelectedColor: Colors.grey,
            ),
          ),
        ),
      );

      key.currentState?.selectButton(2);
      await tester.pump();

      expect(callbackValue, [2]);
    });

    testWidgets(
        'should call checkBoxButtonValues with empty list when clearing',
        (tester) async {
      final values = [1, 2, 3];
      final labels = ['One', 'Two', 'Three'];
      List<int>? callbackValue;
      final key = GlobalKey<CustomCheckBoxGroupState<int>>();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomCheckBoxGroup<int>(
              key: key,
              buttonLables: labels,
              buttonValuesList: values,
              defaultSelected: [1, 2],
              checkBoxButtonValues: (value) {
                callbackValue = value;
              },
              selectedColor: Colors.blue,
              unSelectedColor: Colors.grey,
            ),
          ),
        ),
      );

      key.currentState?.selectButton(null);
      await tester.pump();

      expect(callbackValue, []);
    });

    testWidgets(
        'should not call checkBoxButtonValues when tapping disabled button',
        (tester) async {
      final values = [1, 2, 3];
      final labels = ['One', 'Two', 'Three'];
      int callbackCount = 0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomCheckBoxGroup<int>(
              buttonLables: labels,
              buttonValuesList: values,
              disabledValues: [2],
              checkBoxButtonValues: (value) {
                callbackCount++;
              },
              selectedColor: Colors.blue,
              unSelectedColor: Colors.grey,
            ),
          ),
        ),
      );

      await tester.tap(find.text('Two'));
      await tester.pump();

      expect(callbackCount, 0);
    });

    testWidgets('should track selection order in callback values',
        (tester) async {
      final values = [1, 2, 3, 4, 5];
      final labels = ['One', 'Two', 'Three', 'Four', 'Five'];
      List<int>? callbackValue;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomCheckBoxGroup<int>(
              buttonLables: labels,
              buttonValuesList: values,
              checkBoxButtonValues: (value) {
                callbackValue = value;
              },
              selectedColor: Colors.blue,
              unSelectedColor: Colors.grey,
            ),
          ),
        ),
      );

      await tester.tap(find.text('Three'));
      await tester.pump();
      await tester.tap(find.text('One'));
      await tester.pump();
      await tester.tap(find.text('Five'));
      await tester.pump();

      // Should maintain selection order
      expect(callbackValue, [3, 1, 5]);
    });

    testWidgets('should call callback when removing from middle of selection',
        (tester) async {
      final values = [1, 2, 3, 4, 5];
      final labels = ['One', 'Two', 'Three', 'Four', 'Five'];
      List<int>? callbackValue;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomCheckBoxGroup<int>(
              buttonLables: labels,
              buttonValuesList: values,
              defaultSelected: [1, 2, 3, 4, 5],
              checkBoxButtonValues: (value) {
                callbackValue = value;
              },
              selectedColor: Colors.blue,
              unSelectedColor: Colors.grey,
            ),
          ),
        ),
      );

      await tester.tap(find.text('Three'));
      await tester.pump();

      expect(callbackValue, [1, 2, 4, 5]);
    });
  });

  group('CustomListViewSpacing', () {
    testWidgets('should render children with spacing', (tester) async {
      final children = [
        Container(key: Key('child1'), height: 50),
        Container(key: Key('child2'), height: 50),
        Container(key: Key('child3'), height: 50),
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomListViewSpacing(
              spacing: 10,
              children: children,
            ),
          ),
        ),
      );

      expect(find.byKey(Key('child1')), findsOneWidget);
      expect(find.byKey(Key('child2')), findsOneWidget);
      expect(find.byKey(Key('child3')), findsOneWidget);
    });

    testWidgets('should use vertical scroll direction by default',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomListViewSpacing(
              children: [Container()],
            ),
          ),
        ),
      );

      final listView = tester.widget<ListView>(find.byType(ListView));
      expect(listView.scrollDirection, Axis.vertical);
    });

    testWidgets('should use horizontal scroll direction when specified',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomListViewSpacing(
              scrollDirection: Axis.horizontal,
              children: [Container()],
            ),
          ),
        ),
      );

      final listView = tester.widget<ListView>(find.byType(ListView));
      expect(listView.scrollDirection, Axis.horizontal);
    });

    testWidgets('should use custom scroll controller', (tester) async {
      final controller = ScrollController();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomListViewSpacing(
              scrollController: controller,
              children: [
                Container(height: 1000),
                Container(height: 1000),
              ],
            ),
          ),
        ),
      );

      final listView = tester.widget<ListView>(find.byType(ListView));
      expect(listView.controller, controller);

      controller.dispose();
    });
  });
}
