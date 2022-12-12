
import 'package:flutter_test/flutter_test.dart';
import 'package:lifo_app/data/model/Tube.dart';
import 'package:lifo_app/data/model/balls.dart';
import 'package:lifo_app/data/model/scenario.dart';
import 'package:lifo_app/view/configure.dart';
import 'package:lifo_app/view/model/pair_ball.dart';
import 'package:lifo_app/view/model/scenarioView.dart';

import 'view/helper/make_testable.dart';


void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    int _itemsPerTube = 2;
    int _extraTubes = 2;
    int _amountOfColors = 3;
    maxColors = _amountOfColors;
    maxSpaces = _itemsPerTube;
    extraTubes = _extraTubes;

    ScenarioView scenarioToExperiment = ScenarioView.fromColors([
      [PairBall(AMARILLO-1,'00'), PairBall(ROJO-1,'01')],
      [PairBall(ROJO-1,'10'), PairBall(AZUL-1,'11'),],
      [PairBall(AMARILLO-1,'20'), PairBall(AZUL-1,'21')],
      [],//extra tubes
      []
    ]);

    ConfigurePage widget = ConfigurePage(title: 'Lifo Solver',
      itemsPerTube:_itemsPerTube,
      amountOfColors: _amountOfColors,
      extraTubesToUse: _extraTubes,);
    // Build our app and trigger a frame.
    await tester.pumpWidget(buildTestableWidget( widget));
    ScenarioView currentScenario = widget.getScenario();
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
