
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

      /*
      * Agrego bola LILE Agrego bola LIGHT_PINK
      *    Agrego bola GREEN Agrego bola ORANGE
      *  Agrego bola LIGHT_GREEN   Agrego bola BLUE*/
      scenarioToExperiment = ScenarioView.fromColors([
        [PairBall(LILA,'0-0'), PairBall(PIEL,'0-1')],
        [PairBall(VERDE,'1-0'), PairBall(NARANJA,'1-1'),],
        [PairBall(VERDE_CLARO,'2-0'), PairBall(AZUL,'2-1')],
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
      expect(scenarioToExperiment == currentScenario, true);
      /*await tester.tap(find.byKey(Key('validate')));
      await tester.pumpAndSettle();
      expect(find.byType(SolverPage), findsOneWidget);*/
    });
  });
}

