import 'package:collection/collection.dart';
import 'package:lifo_app/view/model/scenarioView.dart';

class StateQueueView {

    //Removes and returns the element with the highest priority.
  final queue = PriorityQueue<ScenarioView>((ScenarioView a, ScenarioView b) => b.compareTo(a));

  bool add(ScenarioView newScenario){
    if(queue.contains(newScenario)) {
      return false;
    }
    queue.add(newScenario);
    return true;
  }

  int get length => queue.length;
  bool get isNotEmpty => queue.isNotEmpty;

  ScenarioView? remove(){
    if(queue.isEmpty) {
      return null;
    }
    return queue.removeFirst();
  }

}

class CloseListView {
  //work as set
  Map<ScenarioView,ScenarioView> cameFrom =  <ScenarioView, ScenarioView>{};
  bool add(ScenarioView key ,ScenarioView value){
    if(cameFrom.containsKey(key)){
      return false;
    }
    //in a start context
    //a close list key should be diferent to value
    if(key == value) {
      //WTF case
      return false;
    }

    if(key.hashCode == value.hashCode) {
      //colition case
      //avoid a loop
      return false;
    }
    cameFrom[key] = value;
    return true;
  }

  List<ScenarioView> reconstructPath(ScenarioView current) {
    List<ScenarioView> totalPath = <ScenarioView>[];
    totalPath.add(current);
    while(cameFrom.containsKey(current)) {
      current = cameFrom[current]!;
      //prepend
      totalPath.insert(0, current);
    }
    return totalPath;
  }
}
