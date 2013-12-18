// file: stage.dart
library stage;
import 'dart:html';
import '../utils/utils.dart';
import 'dart:math';
part 'map.dart';
part 'actors.dart';
part 'hero.dart';
part 'projectiles.dart';


class Stage {
  // The non-gui part of the game, containing the map and all actors
  Viewport view;
  GameMap map;
  Hero hero;
  List<Actor> actors = [];
  
  Stage(mdata,view) {
    this.view = view;
    map = new GameMap(mdata,this.view);
    hero = new Hero(50,650,map,actors);
    var rand = new Random();
    actors.add(new RandEnemy(100,650,map,actors));
    actors.add(new RandEnemy(900,650,map,actors));
    actors.add(new RandEnemy(400,900,map,actors));
    actors.add(new RandEnemy(200,50,map,actors));
    this.view.follow(hero);
  }
  
  void update() {
    // update the hero
    hero.update();
    // update all other actors on the stage
    actors.removeWhere((act) => act.dead());
    
    for (Actor act in actors) {
        act.update();
    }
  }
  
  void draw() {
    // draw the map and hero
    map.draw();
    hero.draw();
    // draw all other actors
    for (Actor act in actors) {
      act.draw();
    }
  }
}