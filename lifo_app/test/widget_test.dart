// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lifo_app/data/model/Tube.dart';
import 'package:lifo_app/data/model/balls.dart';
import 'package:lifo_app/data/model/scenario.dart';
import 'package:lifo_app/view/configure.dart';

import 'view/helper/make_testable.dart';


void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    int _itemsPerTube = 2;
    int _extraTubes = 2;
    int _amountOfColors = 3;
    maxColors = _amountOfColors;
    maxSpaces = _itemsPerTube;
    extraTubes = _extraTubes;

    Scenario scenarioToExperiment = Scenario.fromColors([
      [AMARILLO-1, ROJO-1],
      [ROJO-1, AZUL-1,],
      [AMARILLO-1, AZUL-1],
      [],//extra tubes
      []
    ]);

    ConfigurePage widget = ConfigurePage(title: 'Lifo Solver',
      itemsPerTube:_itemsPerTube,
      amountOfColors: _amountOfColors,
      extraTubesToUse: _extraTubes,);
    // Build our app and trigger a frame.
    await tester.pumpWidget(buildTestableWidget( widget));
    Scenario currentScenario = widget.getScenario();
    // Verify that our counter starts at 0.
    //expect(find.text('0'), findsOneWidget);
    //expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    //await tester.tap(find.byKey(Key('validate')));
    //await tester.pump();

    // Verify that our content is equal.
    expect(scenarioToExperiment == currentScenario, true);
    //expect(find.text('1'), findsOneWidget);
  });
}
