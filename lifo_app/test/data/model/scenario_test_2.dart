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

     scenarioToExperiment = Scenario.fromList([
       Tube.fromList([GREEN,BLUE, RED, YELLOW]),
       Tube.fromList([YELLOW,BLUE, GREEN, PINK]),
       Tube.fromList([BLUE,BLUE, GREEN, WITHE]),
       Tube.fromList([RED,WITHE, RED, GREEN]),
       Tube.fromList([YELLOW, RED, PINK, YELLOW]),
       Tube.fromList([WITHE,PINK, PINK, WITHE]),
       Tube.fromList([]), //extratubes
       Tube.fromList([])
     ]);

  });
  group('Scenario class ', () {

    test('compare To', () {

      Tube aTube = Tube.fromList([GREEN,BLUE, RED, YELLOW]);
      expect(aTube.compareTo(aTube), 0);

      Tube bTube = Tube.fromList([GREEN,BLUE, RED, ]);
      expect(bTube.compareTo(bTube), 0);
      expect(bTube.compareTo(aTube), -1);
      expect(aTube.compareTo(bTube), 1);

      Tube dTube = Tube.fromList([RED, RED, ]);
      expect(dTube.compareTo(dTube), 0);
      expect(dTube.compareTo(aTube), -1);
      expect(dTube.compareTo(bTube), -1);

      expect(bTube.compareTo(dTube), 1);
      expect(aTube.compareTo(dTube), 1);

      Tube eTube = Tube.fromList([RED,]);
      expect(eTube.compareTo(eTube), 0);
      expect(eTube.compareTo(aTube), -1);
      expect(eTube.compareTo(bTube), -1);
      expect(eTube.compareTo(dTube), -1);


      expect(dTube.compareTo(eTube), 1);
      expect(bTube.compareTo(eTube), 1);
      expect(aTube.compareTo(eTube), 1);

      Tube fTube = Tube.fromList([]);
      expect(fTube.compareTo(fTube), 0);
      expect(fTube.compareTo(aTube), -1);
      expect(fTube.compareTo(bTube), -1);
      expect(fTube.compareTo(dTube), -1);
      expect(fTube.compareTo(eTube), -1);

      expect(eTube.compareTo(fTube), 1);
      expect(dTube.compareTo(fTube), 1);
      expect(bTube.compareTo(fTube), 1);
      expect(aTube.compareTo(fTube), 1);

      Tube ffTube = Tube.fromList([]);
      expect(ffTube.compareTo(fTube), 0);
      expect(fTube.compareTo(ffTube), 0);

      Tube aaTube = Tube.fromList([BLUE,BLUE, RED, YELLOW]);
      expect(aaTube.compareTo(aTube), -1);
      expect(aTube.compareTo(aaTube), 1);

      Tube bbTube = Tube.fromList([BLUE,BLUE, RED, ]);
      expect(bbTube.compareTo(bTube), -1);
      expect(bTube.compareTo(bbTube), 1);

      Tube ddTube = Tube.fromList([BLUE, RED, ]);
      expect(ddTube.compareTo(dTube), -1);
      expect(dTube.compareTo(ddTube), 1);
      Tube eeTube = Tube.fromList([BLUE,]);
      expect(eeTube.compareTo(eTube), -1);
      expect(eTube.compareTo(eeTube), 1);

    });
    test('compare To', () {

      Scenario second = scenarioToExperiment.fromMove(2,6)!;
      //le bajo la entropia
      second.move(5,6);
      second.move(1,5);
      second.move(5,7);
      second.move(5,7);
      second.move(5,7);
      expect(second.compareTo(scenarioToExperiment), 1);
      expect(second.compareTo(second), 0);
      expect(scenarioToExperiment.compareTo(second), -1);
      expect(scenarioToExperiment.compareTo(scenarioToExperiment), 0);
    });


});

}
