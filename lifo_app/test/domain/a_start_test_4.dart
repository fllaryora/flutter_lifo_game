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
     maxColors = 15;

     scenarioToExperiment = Scenario.fromColors([
       [CELESTE, PIEL, GRIS, CELESTE_FUCCIA],
       [NARANJA, CELESTE_FUCCIA, BLANCO, VERDE],
       [CELESTE, PIEL, GRIS, VIOLETA],
       [AMARILLO, VERDE, VERDE_CLARO, CELESTE_FUCCIA],
       [CELESTE_FUCCIA, ROJO, VERDE_OSCURO, VERDE_CLARO],
       [VERDE_OSCURO, AMARILLO, NARANJA, CELESTE],

       [LILA, VERDE_CLARO, VERDE, PIEL],
       [AMARILLO, VERDE_OSCURO, NEGRO, NEGRO],
       [AZUL, VERDE_CLARO, VERDE_OSCURO, VIOLETA],
       [NARANJA, BLANCO, VIOLETA, AZUL],
       [AZUL, LILA, NEGRO, NEGRO],
       [VERDE, GRIS, AMARILLO, PIEL],

       [ROJO, LILA, AZUL, ROJO],
       [ROJO, NARANJA, CELESTE, BLANCO],
       [GRIS, VIOLETA, LILA, BLANCO],
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
      for(Scenario scenario in solution) {
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
