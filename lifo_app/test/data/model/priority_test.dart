// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:lifo_app/data/model/Tube.dart';
import 'package:lifo_app/data/model/priority_queue.dart';
import 'package:lifo_app/data/model/scenario.dart';


void main() {
  late Scenario scenarioToExperiment;
  //fringe or open set
  late StateQueue openSet;
  late //close list
  CloseList cameFrom;

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

     openSet = StateQueue();
     cameFrom =  CloseList();

  });
  group('Scenario class ', () {

    test('can add in empty fringe ', () {
      expect(openSet.add(scenarioToExperiment), true);
      expect(openSet.length, 1);
    });

    test('can add new scenario in fringe ', () {
      openSet.add(scenarioToExperiment);
      expect(openSet.length, 1);
      Scenario? moveTwoSix = scenarioToExperiment.fromMove(2,6);
      expect(moveTwoSix != null, true);
      expect(openSet.add(moveTwoSix!), true);
      expect(openSet.length, 2);
    });

    test('shuld not add dejavu scenario in fringe ', () {
      openSet.add(scenarioToExperiment);
      Scenario? moveTwoSix = scenarioToExperiment.fromMove(2,6);
      openSet.add(moveTwoSix!);
      //this is the dejavu
      Scenario? moveTwoSeven = scenarioToExperiment.fromMove(2,7);
      expect(moveTwoSeven != null, true);
      expect(openSet.add(moveTwoSeven!), false);
      expect(openSet.length, 2);
    });

    test('can not remove a scenario in empty fringe ', () {
      expect(openSet.length, 0);
      expect(openSet.remove(), null);
      expect(openSet.length, 0);
    });

    test('can remove a scenario in fringe ', () {
      openSet.add(scenarioToExperiment);
      expect(openSet.remove(), scenarioToExperiment);
      expect(openSet.length, 0);
    });

    test('can remove Highest priority scenario in fringe ', () {
      openSet.add(scenarioToExperiment);
      expect(openSet.length, 1);
      Scenario? moveTwoSix = scenarioToExperiment.fromMove(2,6);
      openSet.add(moveTwoSix!);
      expect(openSet.remove(), moveTwoSix);
      expect(openSet.length, 1);
      openSet.add(moveTwoSix!);
      Scenario? moveFiveSix = moveTwoSix.fromMove(5,6);
      openSet.add(moveFiveSix!);
      expect(openSet.length, 3);
      expect(openSet.remove(), moveFiveSix);
      expect(openSet.length, 2);
    });


    test('can add in empty close ', () {
      Scenario? moveTwoSix = scenarioToExperiment.fromMove(2,6);
      expect(cameFrom.add(scenarioToExperiment, moveTwoSix!), true);
      Scenario? moveFiveSix = moveTwoSix.fromMove(5,6);
      expect(cameFrom.add(moveTwoSix, moveFiveSix!), true);
    });

    test('should not add an dejavu', () {
      Scenario? moveTwoSix = scenarioToExperiment.fromMove(2,6);
      //this is the dejavu
      Scenario? moveTwoSeven = scenarioToExperiment.fromMove(2,7);
      expect(cameFrom.add(scenarioToExperiment, moveTwoSix!), true);
      expect(cameFrom.add(scenarioToExperiment, moveTwoSeven!), false);
    });

    test('can reconstruct', () {
      Scenario? one = scenarioToExperiment.fromMove(2,6);
      expect(cameFrom.add(one!, scenarioToExperiment), true);

      Scenario? two = one.fromMove(5,6);
      expect(cameFrom.add(two!, one), true);

      Scenario? three = two.fromMove(1,5);
      expect(cameFrom.add(three!, two), true);

      Scenario? four = three.fromMove(5,7);
      expect(cameFrom.add(four!, three), true);

      Scenario? five = four.fromMove(5,7);
      expect(cameFrom.add(five!, four), true);

      Scenario? six = five.fromMove(5,7);
      expect(cameFrom.add(six!, five), true);

      Scenario? seven = six.fromMove(5,6);
      expect(cameFrom.add(seven!, six), true);

      Scenario? eight = seven.fromMove(1,5);
      expect(cameFrom.add(eight!, seven), true);

      Scenario? nine = eight.fromMove(2,5);
      expect(cameFrom.add(nine!, eight), true);

      Scenario? ten = nine.fromMove(3,5);
      expect(cameFrom.add(ten!, nine), true);

      Scenario? eleven = ten.fromMove(1,2);
      expect(cameFrom.add(eleven!, ten), true);

      Scenario? twelve = eleven.fromMove(0,1);
      expect(cameFrom.add(twelve!, eleven), true);

      Scenario? thirteen = twelve.fromMove(4,1);
      expect(cameFrom.add(thirteen!, twelve), true);

      Scenario? fourteen = thirteen.fromMove(4,7);
      expect(cameFrom.add(fourteen!, thirteen), true);

      Scenario? fifteen = fourteen.fromMove(0,4);
      expect(cameFrom.add(fifteen!, fourteen), true);

      Scenario? sixteen = fifteen.fromMove(3,4);
      expect(cameFrom.add(sixteen!, fifteen), true);

      Scenario? seventeen = sixteen.fromMove(0,2);
      expect(cameFrom.add(seventeen!, sixteen), true);

      Scenario? eighteen = seventeen.fromMove(0,5);
      expect(cameFrom.add(eighteen!, seventeen), true);

      Scenario? nineteen = eighteen.fromMove(3,6);
      expect(cameFrom.add(nineteen!, eighteen), true);

      Scenario? twenty = nineteen.fromMove(4,3);
      expect(cameFrom.add(twenty!, nineteen), true);

      Scenario? twentyone = twenty.fromMove(4,3);
      expect(cameFrom.add(twentyone!, twenty), true);

      Scenario? twentytwo = twentyone.fromMove(4,3);
      expect(cameFrom.add(twentytwo!, twentyone), true);

      Scenario? twentythree = twentytwo.fromMove(4,1);
      expect(cameFrom.add(twentythree!, twentytwo), true);



      List<Scenario> expected = <Scenario>[
        scenarioToExperiment,
        one, two, three, four, five, six, seven, eight, nine,ten,
        eleven, twelve, thirteen, fourteen, fifteen,sixteen,seventeen, eighteen,
        nineteen, twenty, twentyone, twentytwo, twentythree
      ];

      List<Scenario> actualList = cameFrom.reconstructPath(twentythree);
      expect(actualList.length, expected.length);

      for(int scenario = 0; scenario < expected.length; scenario++) {
        expect(actualList[scenario], expected[scenario]);
      }


    });
});

}
