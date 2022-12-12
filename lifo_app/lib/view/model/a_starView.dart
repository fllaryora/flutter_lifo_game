
import 'package:lifo_app/view/model/priority_queueView.dart';
import 'package:lifo_app/view/model/scenarioView.dart';

class AStarSearchView {
  // The set of discovered nodes that may need to be (re-)expanded.
  // Initially, only the start node is known.
  // This is usually implemented as a min-heap or priority queue rather than a hash-set.
  final StateQueueView openSet = StateQueueView();

  // For node n, cameFrom[n] is the node immediately preceding it on the cheapest path from start
  // to n currently known.
  final CloseListView cameFrom =  CloseListView();

  // For node n, gScore[n] is the cost of the cheapest path from start to n currently known.
  //gScore := map with default value of Infinity
  final Map<ScenarioView,int> gScore =  <ScenarioView, int>{};

  // For node n, fScore[n] := gScore[n] + h(n). fScore[n] represents our current best guess as to
  // how cheap a path could be from start to finish if it goes through n.
  //fScore := map with default value of Infinity
  final Map<ScenarioView,int> fScore =  <ScenarioView, int>{};
  final int infinite = 0x7fffffffffffffff;
  ScenarioView start;

  AStarSearchView(this.start){
    openSet.add(start);
    gScore[start] = 0;
    //fScore[start] := h(start)
    fScore[start] = start.getHeuristic();
  }

  //bugfix
  //some heuristics match 0
  //at low balls
  bool isGoal(ScenarioView current) {
    return current.isFinish;
    //return current.getHeuristic() == 0;
  }

  Set<ScenarioView> neighbors(ScenarioView current) {
    Set<ScenarioView> neighborList = <ScenarioView>{};
    for(int _tubePop = 0;_tubePop < current.content.length;_tubePop++){
      for(int _tubePush = 0;_tubePush < current.content.length;_tubePush++){
        if(_tubePop != _tubePush) {
          ScenarioView? newMovement = current.fromMove(_tubePop, _tubePush);
          if(newMovement != null){
            neighborList.add(newMovement);
            //bool result = neighborList.add(newMovement);
            //if (result) {
            //  print(" from "+_tubePop.toString()+" to "+ _tubePush.toString() );
            //}
          }
        }
      }
    }
    return neighborList;
  }

  //La diferencia en Dijkstra's algorithm
  //es que en el otro algoritmo todo nodo es el objetivo
  //goal is a ScenarioView with heuristic == 0
  List<ScenarioView>? solve(){

    // For node n, gScore[n] is the cost of the cheapest path from start to n currently known.
    //gScore := map with default value of Infinity
    //gScore[start] := 0

    // This operation can occur in O(Log(N)) time if openSet is a min-heap or a priority queue
    while(openSet.isNotEmpty) {
        //current := the node in openSet having the lowest fScore[] value
      ScenarioView current = openSet.remove()!;
      //if current = goal
      if(isGoal(current)) {
        return cameFrom.reconstructPath(current);
      }
      //for each neighbor of current
      for(ScenarioView neighbor in neighbors(current)){
        // d(current,neighbor) is the weight of the edge from current to neighbor
        // tentative_gScore is the distance from start to the neighbor through current
        //tentative_gScore := gScore[current] + d(current, neighbor)
        int gscoreCurrent = gScore[current] != null ? gScore[current]! : infinite;
        int gscoreNeighbor = gScore[neighbor] != null ? gScore[neighbor]! : infinite;
        // d(current, neighbor) == siempre es 1
        int tentativeGScore = gscoreCurrent + 1;
        // This path to neighbor is better than any previous one. Record it!
        if (tentativeGScore < gscoreNeighbor) {
          //
          cameFrom.add(neighbor, current);
          //gScore[neighbor] := tentative_gScore
          gScore[neighbor] = tentativeGScore;
          //fScore[neighbor] := tentative_gScore + h(neighbor)
          fScore[neighbor] = tentativeGScore + neighbor.getHeuristic();
          //if neighbor not in openSet
            //openSet.add(neighbor)
          openSet.add(neighbor);//lo valida solo
        }
      }
    }
    // Open set is empty but goal was never reached
    return null;
  }

}