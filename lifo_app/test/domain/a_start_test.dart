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
       [],//extra tubes
       []
     ]);

     aStart = AStarSearch(scenarioToExperiment);
  });

  group('Scenario class ', () {

    test('should not be  goal ', () {
      expect(aStart.isGoal(scenarioToExperiment), false);
    });
    test('see goal ', () {
      Scenario goal = Scenario.fromColors([
        [GREEN,GREEN, GREEN, GREEN],
        [YELLOW,YELLOW, YELLOW, YELLOW],
        [BLUE,BLUE, BLUE, BLUE],
        [RED,RED, RED, RED],
        [WITHE, WITHE, WITHE, WITHE],
        [PINK,PINK, PINK, PINK],
        [],//extra tubes
        []
      ]);
      expect(aStart.isGoal(goal), true);
    });

    test('should get all neighboars ', () {
      Set<Scenario> neigboards = aStart.neighbors(scenarioToExperiment);
      expect(neigboards.isEmpty, false);
      //son todas las combinaciones  del 0,1...,5  al 6 y 7
      //pero como cada tubo inicial produce un dejavu
      // solo son 6
      expect(neigboards.length, 6);
    });

    test('should get all neighboars ', () {
      List<Scenario>? solution = aStart.solve();
      expect(solution != null, true);
      expect(solution!.isEmpty, false);
      int movesAprox = scenarioToExperiment.getHeuristic();
      print(solution.first.content);
      for(Scenario scenario in solution){
        print(scenario.getMove());
      }
      expect(solution.length , movesAprox+1);

    });

  });

}
