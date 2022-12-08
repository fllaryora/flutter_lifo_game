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
       [VERDE,CELESTE, ROJO, VERDE_CLARO],
       [PIEL,NARANJA, VERDE, CELESTE_FUCCIA],
       [BLANCO, CELESTE_FUCCIA, AMARILLO, CELESTE_FUCCIA],
       [LILA,VERDE_CLARO, GRIS, VIOLETA],
       [VIOLETA, LILA, NARANJA, AZUL],
       [NARANJA,AZUL, AZUL, ROJO],
       [PIEL,GRIS, AMARILLO, ROJO],
       [LILA, GRIS, CELESTE, PIEL],

       [CELESTE, BLANCO, NARANJA, CELESTE],
       [VERDE, VIOLETA, BLANCO, PIEL],
       [GRIS, VERDE_CLARO, CELESTE_FUCCIA, ROJO],
       [LILA, AMARILLO, VERDE, VERDE_CLARO],
       [AZUL, BLANCO, AMARILLO, VIOLETA],
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
