// file: inanimate.dart
// contains: Inanimate, Portal, Pickupable

part of common;

class Inanimate extends Actor {
  
  Inanimate(x,y) : super(x,y) {
    color = "purple";
    height = 5;
    width = 15;
  }
}

//==========================================
// Common Inanimates
//==========================================
class Portal extends Inanimate {
  num targx, targy; // the end position of going through the portal
  String targmap; // the map we are going to
  
  Portal(x,y,this.targx,this.targy,this.targmap) : super(x,y) {
    height = 30;
    width = 30;
  }
  void interact(Hero hero) {
    // open the portal and go through it
    hero.mapid = targmap;
    hero.x = targx;
    hero.y = targy;
  }
}

class BattlePortal extends Inanimate {
  // Takes Beings to a different instance of the map they are on
  Battle battle; // The battle this portal leads to
  BattlePortal(x,y,this.battle) : super(x,y) {
    battle.entrances.add(this); // add ourselves to the markers on the target instance so that we can be removed
    height = 30;
    width = 30;
    color = "lightpurple";
  }
  void interact(Hero hero) {
    battle.addHero(hero);
  }
}


class Pickupable extends Inanimate {
  Item item;
  
  Pickupable(x,y,item) : super(x,y) {
    this.item = item;
    color = item.color;
  }
  
  // kills the actor copy of the item, 
  // then places pickupable thing in hero's inventory
  // and immediately equips if possible.
  void interact(Hero hero){
    dead = true;
    hero.inv.put(item);
    if(item is Equipable){
      hero.inv.equip(item);
    }
  }
}

class Bank extends Inanimate {
  // actor that's interacted with to access your bank inventory
  Bank(x, y) : super(x,y){
    height = 30;
    width = 60;
    color = "gold";
  }
  
  void interact(Hero hero){
    // pretend the bank is an npc for now
    //hero.convHandler.add(new Conversation(bank));
  }
}