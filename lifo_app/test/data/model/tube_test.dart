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
  late Tube tubeToExperiment;

  int BLUE = 1;
  int RED = 2;
  int GREEN = 3;
  int YELLOW = 4;

  setUp(() {
     maxSpaces = 4;
     maxColors = 4;
     tubeToExperiment = Tube();
  });
  group('Tube class ', () {

    test('should not pop in empty tube', () {
      expect(tubeToExperiment.pop(), null);
    });

    test('Can pop in not empty tube', () {
      tubeToExperiment.push(BLUE);
      expect(tubeToExperiment.pop(), BLUE);
    });


    test('Can push in empty tube', () {
      expect(tubeToExperiment.push(BLUE), true);
    });

    test('should not push in full tube', () {
      expect(tubeToExperiment.push(RED), true);
      expect(tubeToExperiment.push(BLUE), true);
      expect(tubeToExperiment.push(GREEN), true);
      expect(tubeToExperiment.push(YELLOW), true);
      expect(tubeToExperiment.push(YELLOW), false);
    });

    test('should not be equals tubes', () {
      Tube tube1 = Tube();
      Tube tube2 = Tube();

      tube1.push(RED);
      tube1.push(BLUE);
      tube1.push(GREEN);
      tube1.push(YELLOW);

      tube2.push(RED);
      tube2.push(BLUE);
      tube2.push(BLUE);
      tube2.push(YELLOW);
      expect(tube1 == tube2, false);
    });

    test('should not be equals tubes 2', () {
      Tube tube1 = Tube();
      Tube tube2 = Tube();

      tube1.push(YELLOW);

      tube2.push(YELLOW);
      tube2.push(YELLOW);

      expect(tube1 == tube2, false);
    });

    test('should be equals to differents tubes', () {
      Tube tube1 = Tube();
      Tube tube2 = Tube();

      tube1.push(RED);
      tube1.push(BLUE);
      tube1.push(GREEN);
      tube1.push(YELLOW);

      tube2.push(RED);
      tube2.push(BLUE);
      tube2.push(GREEN);
      tube2.push(YELLOW);
      expect(tube1 == tube2, true);
    });


    test('all the balls should be the same colors', () {
      expect(tubeToExperiment.areAllBallsTheSameColour, true);
      tubeToExperiment.push(RED);
      expect(tubeToExperiment.areAllBallsTheSameColour, true);
      tubeToExperiment.push(RED);
      expect(tubeToExperiment.areAllBallsTheSameColour, true);
      tubeToExperiment.push(RED);
      expect(tubeToExperiment.areAllBallsTheSameColour, true);
      tubeToExperiment.push(RED);
      expect(tubeToExperiment.areAllBallsTheSameColour, true);
    });

    test('all the balls should not be the same colors', () {
      expect(tubeToExperiment.areAllBallsTheSameColour, true);
      tubeToExperiment.push(RED);
      expect(tubeToExperiment.areAllBallsTheSameColour, true);
      tubeToExperiment.push(BLUE);
      expect(tubeToExperiment.areAllBallsTheSameColour, false);
      tubeToExperiment.push(RED);
      expect(tubeToExperiment.areAllBallsTheSameColour, false);
      tubeToExperiment.push(RED);
      expect(tubeToExperiment.areAllBallsTheSameColour, false);
    });

    test('the recolored version should be equals to BLUE version in all stages', () {

      Tube tube2 = Tube();

      Tube recolored = tubeToExperiment.reColorTubeForHeuristic();
      expect(recolored == tube2, true);

      tubeToExperiment.push(YELLOW);
      tube2.push(BLUE);

      recolored = tubeToExperiment.reColorTubeForHeuristic();
      expect(recolored == tube2, true);

      tubeToExperiment.push(YELLOW);
      tube2.push(BLUE);

      recolored = tubeToExperiment.reColorTubeForHeuristic();
      print(tube2);
      print(recolored);
      expect(recolored == tube2, true);

      tubeToExperiment.push(YELLOW);
      tube2.push(BLUE);

      recolored = tubeToExperiment.reColorTubeForHeuristic();
      print(tube2);
      print(recolored);
      expect(recolored == tube2, true);

      tubeToExperiment.push(YELLOW);
      tube2.push(BLUE);

      recolored = tubeToExperiment.reColorTubeForHeuristic();
      print(tube2);
      print(recolored);
      expect(recolored == tube2, true);
    });

    test('Can human push in empty tube', () {
      expect(tubeToExperiment.humanPush(BLUE), true);
    });

    test('should not human push in full tube', () {
      expect(tubeToExperiment.humanPush(RED), true);
      expect(tubeToExperiment.humanPush(RED), true);
      expect(tubeToExperiment.humanPush(RED), true);
      expect(tubeToExperiment.humanPush(RED), true);
      expect(tubeToExperiment.humanPush(RED), false);
    });

    test('should not human push in red tube', () {
      expect(tubeToExperiment.humanPush(RED), true);
      expect(tubeToExperiment.humanPush(BLUE), false);
      expect(tubeToExperiment.humanPush(GREEN), false);
      expect(tubeToExperiment.humanPush(YELLOW), false);
      expect(tubeToExperiment.humanPush(RED), true);
    });
  });


}
