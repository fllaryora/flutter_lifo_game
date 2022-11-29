// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:lifo_app/data/model/Tube.dart';
import 'package:lifo_app/data/model/scenario.dart';


void main() {
  late Scenario scenarioToExperiment;
  late Scenario scenarioInvalid;
  int BLUE = 1;
  int RED = 2;
  int GREEN = 3;
  int YELLOW = 4;
  int PINK = 5;
  int WITHE = 6;
  setUp(() {
     maxSpaces = 4;
     maxColors = 6;

     scenarioToExperiment = Scenario.fromColors([
       [GREEN,BLUE, RED, YELLOW],
       [YELLOW,BLUE, GREEN, PINK],
       [BLUE,BLUE, GREEN, WITHE],
       [RED,WITHE, RED, GREEN],
       [YELLOW, RED, PINK, YELLOW],
       [WITHE,PINK, PINK, WITHE],
       [], //extratubes
       []
     ]);

     scenarioInvalid = Scenario.fromColors([
       [GREEN,BLUE, RED, YELLOW],
       [YELLOW,BLUE, GREEN, PINK],
       [BLUE,BLUE, GREEN, WITHE],
       [RED,WITHE, RED, YELLOW],
       [YELLOW, RED, PINK, YELLOW],
       [WITHE,PINK, PINK, WITHE],
       [], //extratubes
       []
     ]);
  });
  group('Scenario class ', () {

    test('should not be valid', () {
      expect(scenarioInvalid.isValid, false);
    });

    test('should  be valid', () {
      expect(scenarioToExperiment.isValid, true);
    });

    test('can move when is valid', () {
      //blancos
      expect(scenarioToExperiment.move(2,6), true);
      expect(scenarioToExperiment.move(5,6), true);
      //rozas
      expect(scenarioToExperiment.move(1,5), true);
      expect(scenarioToExperiment.move(5,7), true);
      expect(scenarioToExperiment.move(5,7), true);
      expect(scenarioToExperiment.move(5,7), true);
      //movi al blanco al penultimo
      expect(scenarioToExperiment.move(5,6), true);
      //verdes
      expect(scenarioToExperiment.move(1,5), true);
      expect(scenarioToExperiment.move(2,5), true);
      expect(scenarioToExperiment.move(3,5), true);
      //azul
      expect(scenarioToExperiment.move(1,2), true);
      //amarillo
      expect(scenarioToExperiment.move(0,1), true);
      expect(scenarioToExperiment.move(4,1), true);
      //roza
      expect(scenarioToExperiment.move(4,7), true);
      //rojo
      expect(scenarioToExperiment.move(0,4), true);
      expect(scenarioToExperiment.move(3,4), true);
      //azul
      expect(scenarioToExperiment.move(0,2), true);
      //verde
      expect(scenarioToExperiment.move(0,5), true);
      //balnco
      expect(scenarioToExperiment.move(3,6), true);
      //rojo
      expect(scenarioToExperiment.move(4,3), true);
      expect(scenarioToExperiment.move(4,3), true);
      expect(scenarioToExperiment.move(4,3), true);
      //amarillo
      expect(scenarioToExperiment.move(4,1), true);

      //terminado
      expect(scenarioToExperiment.isFinish, true);
    });

  test('should not move when is not valid', () {
    expect(scenarioToExperiment.move(0,1), false);
    expect(scenarioToExperiment.move(1,2), false);
    //blancos
    expect(scenarioToExperiment.move(2,6), true);
    //de blanco a verde
    expect(scenarioToExperiment.move(6,2), false);
    expect(scenarioToExperiment.move(5,6), true);
    //verde a blanco
    expect(scenarioToExperiment.move(3,6), false);

  });

    test('can get Heuristic', () {
      /*
      * heuristica 23
heuristica 22
heuristica 22
heuristica 21
heuristica 20
heuristica 19
heuristica 18
heuristica 18
heuristica 18
heuristica 16
heuristica 14
heuristica 14
heuristica 12
heuristica 11
heuristica 11
heuristica 11
heuristica 9
heuristica 7
heuristica 6
heuristica 6
heuristica 4
heuristica 2
heuristica 0
*/
      //blancos
      scenarioToExperiment.move(2,6);
      print("heuristica "+ scenarioToExperiment.getHeuristic().toString());
      scenarioToExperiment.move(5,6);
      print("heuristica "+ scenarioToExperiment.getHeuristic().toString());
      //rozas
      scenarioToExperiment.move(1,5);
      print("heuristica "+ scenarioToExperiment.getHeuristic().toString());
      scenarioToExperiment.move(5,7);
      print("heuristica "+ scenarioToExperiment.getHeuristic().toString());
      scenarioToExperiment.move(5,7);
      print("heuristica "+ scenarioToExperiment.getHeuristic().toString());
      scenarioToExperiment.move(5,7);
      print("heuristica "+ scenarioToExperiment.getHeuristic().toString());
      //movi al blanco al penultimo
      scenarioToExperiment.move(5,6);
      print("heuristica "+ scenarioToExperiment.getHeuristic().toString());
      //verdes
      scenarioToExperiment.move(1,5);
      print("heuristica "+ scenarioToExperiment.getHeuristic().toString());
      scenarioToExperiment.move(2,5);
      print("heuristica "+ scenarioToExperiment.getHeuristic().toString());
      scenarioToExperiment.move(3,5);
      print("heuristica "+ scenarioToExperiment.getHeuristic().toString());
      //azul
      scenarioToExperiment.move(1,2);
      print("heuristica "+ scenarioToExperiment.getHeuristic().toString());
      //amarillo
      scenarioToExperiment.move(0,1);
      print("heuristica "+ scenarioToExperiment.getHeuristic().toString());
      scenarioToExperiment.move(4,1);
      print("heuristica "+ scenarioToExperiment.getHeuristic().toString());
      //roza
      scenarioToExperiment.move(4,7);
      print("heuristica "+ scenarioToExperiment.getHeuristic().toString());
      //rojo
      scenarioToExperiment.move(0,4);
      print("heuristica "+ scenarioToExperiment.getHeuristic().toString());
      scenarioToExperiment.move(3,4);
      print("heuristica "+ scenarioToExperiment.getHeuristic().toString());
      //azul
      scenarioToExperiment.move(0,2);
      print("heuristica "+ scenarioToExperiment.getHeuristic().toString());
      //verde
      scenarioToExperiment.move(0,5);
      print("heuristica "+ scenarioToExperiment.getHeuristic().toString());
      //balnco
      scenarioToExperiment.move(3,6);
      print("heuristica "+ scenarioToExperiment.getHeuristic().toString());
      //rojo
      scenarioToExperiment.move(4,3);
      print("heuristica "+ scenarioToExperiment.getHeuristic().toString());
      scenarioToExperiment.move(4,3);
      print("heuristica "+ scenarioToExperiment.getHeuristic().toString());
      scenarioToExperiment.move(4,3);
      print("heuristica "+ scenarioToExperiment.getHeuristic().toString());
      //amarillo
      scenarioToExperiment.move(4,1);
      print("heuristica "+ scenarioToExperiment.getHeuristic().toString());

      //terminado
      expect(scenarioToExperiment.isFinish, true);
      expect(scenarioToExperiment.getHeuristic(), 0);
    });
});

}
