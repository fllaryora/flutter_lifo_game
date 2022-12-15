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
       [CELESTE, VERDE_CLARO, ROZA, VERDE_CLARO],
       [CELESTE,VERDE, VERDE, VERDE_CLARO],
       [VERDE_OSCURO,ROZA, AZUL, GRIS],
       [CELESTE_FUCCIA,NARANJA, ROJO, CELESTE],
       [NEGRO, LILA, BLANCO, AZUL],
       [ROJO,AZUL, NARANJA, AMARILLO],

       [LILA, BLANCO, CELESTE_FUCCIA, NARANJA],
       [NARANJA,PIEL, ROZA, NEGRO],
       [NEGRO,AZUL, BLANCO, VERDE_OSCURO],
       [VERDE_OSCURO, AMARILLO, AMARILLO, ROZA],
       [CELESTE, PIEL, LILA, CELESTE_FUCCIA],
       [GRIS,LILA, VERDE, AMARILLO],

       [VERDE_CLARO, GRIS, CELESTE_FUCCIA, GRIS],
       [NEGRO, VERDE_OSCURO, PIEL, ROJO],
       [ROJO, BLANCO, VERDE, PIEL],
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
        print(scenario.getMove());
      }
      expect(solution.length >  movesAprox, true );

    });

  });

}
