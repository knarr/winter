// file: gamemap.dart
part of common;

class Tile {
  static const int AIR = 0;
  static const int WALL = 1;
  static const int CLOUD = 2;
  static const int LADDER = 3;
  static const int ICE = 4;
  static const int BANK = 10; //we should eventually make a new subclass out of interactable tiles
  
  // Are there any solid tiles?
  static bool solid(List<int> ts) =>
    ts.any((t) => t == WALL || t == ICE);
}

class GameMap {
  // Represents a game map instance
  // Handles the map scenery, as well as all the actors on the map
  
  String id; // The id of the map, used by players

  List<List<int>> tdata; // Row major representation of the tile data
  
  List<Instance> instances = []; // The instances of this map

  GameMap(this.id,List<Actor> actors, this.tdata) {
    Instance world = new Instance(); // create the main world instance
    addInstance(world);
    for (Actor act in actors) { // add all the actors to the world
      world.addActor(act);
    }
  }
  
  bool addHero(Hero hero) {
    if (instances.first != null ) { // There needs to be an instance to add it to
      return instances.first.addHero(hero); // try to add the hero to the instance
    }
    return false;
  }
  
  void addInstance(Instance instance) {
    instance.map = this;
    instances.add(instance);
  }
  
  void update(num dt) {
    instances.removeWhere((Instance instance) => !instance.open); // remove instances which are no longer open
    var tmp = instances.toList(); // copy for concurrency
    for (Instance instance in tmp) {
      instance.update(dt); // update all the instances of the map
    }
  }
  
  // get the tile at position x,y
  num get(x,y) {
    if (x >= 0 && x < tdata[0].length*ts && y >= 0 && y < tdata.length*ts)
      return tdata[y ~/ ts][x ~/ ts];
    else
      return 1; // everything outside the map is unwalkable by default
  }
  
  
  // ==== PACKING ====
  GameMap.fromPack(data) {
    unpack(data);
  }
  pack() {
    return {
      "id"      : id,
      "tdata"   : tdata
    };
  }
  unpack(data) {
    id = data["id"];
    tdata = data["tdata"]; // load the map tiles
  }
}