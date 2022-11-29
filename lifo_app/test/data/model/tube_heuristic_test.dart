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
  int aCase = 0;
  int eCase = 0;
  int bCase = 1;
  int dCase = 1;
  int cCase = 2;

  int fCase = bCase + 1;//2
  int jCase = dCase + 1;//2
  int gCase = cCase + 1;//3
  int hCase = fCase + 1;//3
  int iCase = fCase + 1;//3
  int kCase = gCase + 1;//4
  int nCase = gCase + 1;//4

  int mCase = hCase+1;//4
  int lCase = hCase+1;//4
  int oCase = hCase+1;//4
  int qCase = hCase+1;//4

  int pCase = iCase +1;//4
  int rCase = iCase +1;//4
  int sCase = iCase +1;//4
  int tCase = iCase +1;//4

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

    test('get  heuristic value', () {

      Tube tube1 = Tube();
      print(tube1.getHeuristic());
      print("a"+ aCase.toString());
      expect(tube1.getHeuristic(), aCase);
      tube1.push(RED);
      print(tube1.getHeuristic());
      print("b"+ bCase.toString());
      expect(tube1.getHeuristic(), bCase);
      tube1.push(RED);
      print(tube1.getHeuristic());
      print("c"+ cCase.toString());
      expect(tube1.getHeuristic(), cCase);
      tube1.push(RED);
      print(tube1.getHeuristic());
      print("d"+ dCase.toString());
      expect(tube1.getHeuristic(), dCase);
      tube1.push(RED);
      print(tube1.getHeuristic());
      print("e"+ eCase.toString());
      expect(tube1.getHeuristic(), eCase);

    });

    test('should get the same heuristic value', () {

      Tube tube2 = Tube();
      print(tube2.getHeuristic());
      print("a"+ aCase.toString());
      expect(tube2.getHeuristic(), aCase);
      tube2.push(BLUE);
      print(tube2.getHeuristic());
      print("b"+ bCase.toString());
      expect(tube2.getHeuristic(), bCase);
      tube2.push(RED);
      print(tube2.getHeuristic());
      print("f"+ fCase.toString());
      expect(tube2.getHeuristic(), fCase);

      Tube tube3 = Tube();
      tube3.push(GREEN);
      expect(tube3.getHeuristic(), bCase);
      tube3.push(GREEN);
      expect(tube3.getHeuristic(), cCase);
      tube3.push(YELLOW);
      expect(tube3.getHeuristic(), gCase);

      Tube tube4 = Tube();
      tube4.push(BLUE);
      expect(tube4.getHeuristic(), bCase);
      tube4.push(RED);
      expect(tube4.getHeuristic(), cCase);
      tube4.push(BLUE);
      expect(tube4.getHeuristic(), hCase);

      Tube tube5 = Tube();
      tube5.push(GREEN);
      expect(tube5.getHeuristic(), bCase);
      tube5.push(RED);
      expect(tube5.getHeuristic(), cCase);
      tube5.push(RED);
      expect(tube5.getHeuristic(), hCase);
    });

    test('should get the same heuristic value iCase', () {

      Tube tube5 = Tube();
      tube5.push(GREEN);
      expect(tube5.getHeuristic(), bCase);
      tube5.push(RED);
      expect(tube5.getHeuristic(), cCase);
      tube5.push(BLUE);
      expect(tube5.getHeuristic(), iCase);

    });

    test('should get the same heuristic value jCase', () {

      Tube tube1 = Tube();
      expect(tube1.getHeuristic(), aCase);
      tube1.push(RED);
      expect(tube1.getHeuristic(), bCase);
      tube1.push(RED);
      expect(tube1.getHeuristic(), cCase);
      tube1.push(RED);
      expect(tube1.getHeuristic(), dCase);
      tube1.push(BLUE);
      expect(tube1.getHeuristic(), jCase);

    });

    test('should get the same heuristic value kCAse', () {

      Tube tube1 = Tube();
      expect(tube1.getHeuristic(), aCase);
      tube1.push(RED);
      expect(tube1.getHeuristic(), bCase);
      tube1.push(RED);
      expect(tube1.getHeuristic(), cCase);
      tube1.push(BLUE);
      expect(tube1.getHeuristic(), gCase);
      tube1.push(RED);
      print(tube1.getHeuristic());
      print("k"+ kCase.toString());
      expect(tube1.getHeuristic(), kCase);
    });


  test('should get the same heuristic value nCAse', () {

    Tube tube1 = Tube();
    expect(tube1.getHeuristic(), aCase);
    tube1.push(RED);
    expect(tube1.getHeuristic(), bCase);
    tube1.push(RED);
    expect(tube1.getHeuristic(), cCase);
    tube1.push(BLUE);
    expect(tube1.getHeuristic(), gCase);
    tube1.push(GREEN);
    print(tube1.getHeuristic());
    print("n"+ nCase.toString());
    expect(tube1.getHeuristic(), nCase);
  });


  test('should get the same heuristic value MCAse', () {

    Tube tube5 = Tube();
    tube5.push(GREEN);
    expect(tube5.getHeuristic(), bCase);
    tube5.push(RED);
    expect(tube5.getHeuristic(), cCase);
    tube5.push(RED);
    expect(tube5.getHeuristic(), hCase);
    tube5.push(RED);
    expect(tube5.getHeuristic(), mCase);

    Tube tube4 = Tube();
    tube4.push(BLUE);
    expect(tube4.getHeuristic(), bCase);
    tube4.push(RED);
    expect(tube4.getHeuristic(), cCase);
    tube4.push(BLUE);
    expect(tube4.getHeuristic(), hCase);
    tube4.push(BLUE);
    expect(tube4.getHeuristic(), lCase);


    Tube tube7 = Tube();
    tube7.push(GREEN);
    expect(tube7.getHeuristic(), bCase);
    tube7.push(RED);
    expect(tube7.getHeuristic(), cCase);
    tube7.push(RED);
    expect(tube7.getHeuristic(), hCase);
    tube7.push(BLUE);
    expect(tube7.getHeuristic(), oCase);


    Tube tube1 = Tube();
    tube1.push(GREEN);
    expect(tube1.getHeuristic(), bCase);
    tube1.push(RED);
    expect(tube1.getHeuristic(), cCase);
    tube1.push(GREEN);
    expect(tube1.getHeuristic(), hCase);
    tube1.push(BLUE);
    expect(tube1.getHeuristic(), qCase);
  });

  test('should get the same heuristic value PCAse', () {

    Tube tube5 = Tube();
    tube5.push(GREEN);
    expect(tube5.getHeuristic(), bCase);
    tube5.push(RED);
    expect(tube5.getHeuristic(), cCase);
    tube5.push(BLUE);
    expect(tube5.getHeuristic(), iCase);
    tube5.push(GREEN);
    expect(tube5.getHeuristic(), pCase);

    Tube tube6 = Tube();
    tube6.push(GREEN);
    expect(tube6.getHeuristic(), bCase);
    tube6.push(RED);
    expect(tube6.getHeuristic(), cCase);
    tube6.push(BLUE);
    expect(tube6.getHeuristic(), iCase);
    tube6.push(BLUE);
    expect(tube6.getHeuristic(), rCase);

    Tube tube8 = Tube();
    tube8.push(GREEN);
    expect(tube8.getHeuristic(), bCase);
    tube8.push(RED);
    expect(tube8.getHeuristic(), cCase);
    tube8.push(BLUE);
    expect(tube8.getHeuristic(), iCase);
    tube8.push(RED);
    expect(tube8.getHeuristic(), sCase);

    Tube tube88 = Tube();
    tube88.push(GREEN);
    expect(tube88.getHeuristic(), bCase);
    tube88.push(RED);
    expect(tube88.getHeuristic(), cCase);
    tube88.push(BLUE);
    expect(tube88.getHeuristic(), iCase);
    tube88.push(YELLOW);
    expect(tube88.getHeuristic(), tCase);
  });
  });
}
