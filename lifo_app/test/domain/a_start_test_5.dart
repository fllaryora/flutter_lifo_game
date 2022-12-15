// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:lifo_app/data/model/Tube.dart';
import 'package:lifo_app/data/model/balls.dart';
import 'package:lifo_app/data/model/scenario.dart';
import 'package:lifo_app/domain/a_star.dart';

void main() {
  late Scenario scenarioToExperiment;


  late AStarSearch aStart;

  setUp(() {

     maxSpaces = 4;
     maxColors = 13;

     scenarioToExperiment = Scenario.fromColors([
       [BLANCO, AMARILLO, LILA, ROZA],
       [VERDE, ROJO, GRIS, PIEL],
       [NARANJA, BLANCO, AZUL, AMARILLO],
       [NARANJA, VERDE, AMARILLO, ROZA],
       [BLANCO, GRIS, NARANJA, BLANCO],
       [VERDE_CLARO, CELESTE_FUCCIA, VERDE, CELESTE_FUCCIA],
       [VERDE, CELESTE_FUCCIA, VERDE_CLARO, GRIS],
       [CELESTE, CELESTE_FUCCIA, AZUL, ROJO],

       [CELESTE, ROJO, NARANJA, CELESTE],
       [CELESTE, AMARILLO, AZUL, ROZA],
       [ROJO, PIEL, VERDE_CLARO, VERDE_CLARO],
       [LILA, AZUL, ROZA, PIEL],
       [PIEL, GRIS, LILA, LILA],
       [],//extra tubes
       []
     ]);

     aStart = AStarSearch(scenarioToExperiment);
  });

  group('Scenario class ', () {

    test('should get all neighboars ', () {
      expect(scenarioToExperiment.isValid, true);

      List<Scenario>? solution = aStart.solve();
      expect(solution != null, true);
      expect(solution!.isEmpty, false);
      int movesAprox = scenarioToExperiment.getHeuristic();
      print(solution.first.content);
      for(Scenario scenario in solution){
        List <int > move = scenario.getMove();
        int tubeIndex = move[1];
        Tube tubeDest = scenario.content[tubeIndex];
        int color = tubeDest.topColor!;
        List<Balls> bolas = Balls.values;
        Balls bola = bolas[color];
        print(bola.name + move.toString() );
      }
      expect(solution.length >  movesAprox, true );

    });

  });

}
