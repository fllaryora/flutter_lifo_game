// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:lifo_app/data/model/Tube.dart';
import 'package:lifo_app/data/model/scenario.dart';
import 'package:lifo_app/domain/a_star.dart';

void main() {
  late Scenario scenarioToExperiment;


  late AStarSearch aStart;
  int CELESTE = 1;
  int VERDE_CLARO = 2;
  int ROZA = 3;
  int VERDE = 4;
  int VERDE_OSCURO = 5;
  int AZUL = 6;
  int GRIS = 7;
  int CELESTE_FUCCIA = 8;
  int NARANJA = 9;
  int ROJO = 10;
  int NEGRO = 11;
  int LILA = 12;
  int BLANCO = 13;
  int AMARILLO = 14;
  int ROZA_CLARO = 15;
  setUp(() {

     maxSpaces = 4;
     maxColors = 15;

     scenarioToExperiment = Scenario.fromColors([
       [CELESTE,VERDE_CLARO, ROZA, VERDE_CLARO],
       [CELESTE,VERDE, VERDE, VERDE_CLARO],
       [VERDE_OSCURO,ROZA, AZUL, GRIS],
       [CELESTE_FUCCIA,NARANJA, ROJO, CELESTE],
       [NEGRO, LILA, BLANCO, AZUL],
       [ROJO,AZUL, NARANJA, AMARILLO],

       [LILA, BLANCO, CELESTE_FUCCIA, NARANJA],
       [NARANJA,ROZA_CLARO, ROZA, NEGRO],
       [NEGRO,AZUL, BLANCO, VERDE_OSCURO],
       [VERDE_OSCURO, AMARILLO, AMARILLO, ROZA],
       [CELESTE, ROZA_CLARO, LILA, CELESTE_FUCCIA],
       [GRIS,LILA, VERDE, AMARILLO],

       [VERDE_CLARO, GRIS, CELESTE_FUCCIA, GRIS],
       [NEGRO, VERDE_OSCURO, ROZA_CLARO, ROJO],
       [ROJO, BLANCO, VERDE, ROZA_CLARO],
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
