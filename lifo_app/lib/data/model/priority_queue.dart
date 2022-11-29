import 'package:collection/collection.dart';
import 'package:lifo_app/data/model/scenario.dart';

class StateQueue {

    //Removes and returns the element with the highest priority.
  final queue = PriorityQueue<Scenario>((Scenario a, Scenario b) => b.compareTo(a));

  bool add(Scenario newScenario){
    if(queue.contains(newScenario)) {
      return false;
    }
    queue.add(newScenario);
    return true;
  }

  int get length => queue.length;
  bool get isNotEmpty => queue.isNotEmpty;

  Scenario? remove(){
    if(queue.isEmpty) {
      return null;
    }
    return queue.removeFirst();
  }

}

class CloseList {
  //work as set
  Map<Scenario,Scenario> cameFrom =  <Scenario, Scenario>{};
  bool add(Scenario key ,Scenario value){
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

  List<Scenario> reconstructPath(Scenario current) {
    List<Scenario> totalPath = <Scenario>[];
    totalPath.add(current);
    while(cameFrom.containsKey(current)) {
      current = cameFrom[current]!;
      //prepend
      totalPath.insert(0, current);
    }
    return totalPath;
  }
}
