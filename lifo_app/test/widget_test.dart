
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lifo_app/data/model/Tube.dart';
import 'package:lifo_app/data/model/balls.dart';
import 'package:lifo_app/data/model/scenario.dart';
import 'package:lifo_app/view/configure.dart';
import 'package:lifo_app/view/model/pair_ball.dart';
import 'package:lifo_app/view/model/scenarioView.dart';
import 'package:lifo_app/view/solver.screen.dart';

import 'view/helper/make_testable.dart';

void main() {
  group('ConfigurePage navigation tests', () {
    late ScenarioView scenarioToExperiment;
    int _itemsPerTube = 2;
    int _extraTubes = 2;
    int _amountOfColors = 3;// "Fake" routes used to verify the right route was pushed
    setUp(() {

      maxColors = _amountOfColors;
      maxSpaces = _itemsPerTube;
      extraTubes = _extraTubes;

      scenarioToExperiment = ScenarioView.fromColors([
        [PairBall(AMARILLO-1,'0-0'), PairBall(ROJO-1,'0-1')],
        [PairBall(ROJO-1,'1-0'), PairBall(AZUL-1,'1-1'),],
        [PairBall(AMARILLO-1,'2-0'), PairBall(AZUL-1,'2-1')],
        [],//extra tubes
        []
      ]);
    });

    testWidgets('Counter increments smoke test', (WidgetTester tester) async {

      ConfigurePage widget = ConfigurePage(title: 'Lifo Solver',
        itemsPerTube:_itemsPerTube,
        amountOfColors: _amountOfColors,
        extraTubesToUse: _extraTubes,);

      // Build our app and trigger a frame.
      await tester.pumpWidget(buildTestableWidget(widget));

      ScenarioView currentScenario = widget.getScenario();
      // Verify that our counter starts at 0.
      //expect(find.text('0'), findsOneWidget);
      //expect(find.text('1'), findsNothing);
      expect(scenarioToExperiment == currentScenario, true);
      // Tap the '+' icon and trigger a frame.
      await tester.tap(find.byKey(Key('validate')));
      //await tester.pump();
      await tester.pumpAndSettle();
      expect(find.byType(SolverPage), findsOneWidget);
    });
  });
}

