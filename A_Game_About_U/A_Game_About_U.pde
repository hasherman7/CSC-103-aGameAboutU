// Bird sounds from SoundGator
// Sewer sounds, city ambience, and piano from pixabay

import processing.sound.*;

int gameState;
int proProg;
int zone;
int park;
int sewer;
int scape;
int deaths;
boolean isPausible;
boolean isPaused;
boolean cutscene;
boolean known;
boolean upKnown;
boolean leftKnown;
boolean rightKnown;
int startCut;
int endCut;
int pauseForEffect;
U player;
Movable move1;
Movable move2;
Movable move3;
Movable move4;
Movable move5;
Movable move6;
int floorHeight;
ArrayList<Platform> platList;
SoundFile jump;
SoundFile birds;
SoundFile splash;
SoundFile sewage;
SoundFile cityAmb;
SoundFile wind;
SoundFile piano;

void setup() {
  size(1200, 800);
  background(0);
  isPaused = false;
  isPausible = false;
  cutscene = false;
  deaths = 0;
  player = new U(370, height - 75);
  pauseForEffect = 3000;
  move1 = new Movable(350, 325, 100, color(50), 200, 500, 645, 645, -2, 0);
  move2 = new Movable(850, 375, 100, color(50), 700, 1000, 645, 645, 2, 0);
  move3 = new Movable(300, 375, 100, color(50), 300, 300, 275, 575, 0, 2);
  move4 = new Movable(500, 275, 100, color(50), 500, 500, 175, 475, 0, -1);
  move5 = new Movable(700, 400, 100, color(50), 700, 700, 300, 600, 0, 1);
  move6 = new Movable(900, 300, 100, color(50), 900, 900, 200, 500, 0, -2);
  jump = new SoundFile(this, "jump.mp3");
  birds = new SoundFile(this, "birdChirping.mp3");
  splash = new SoundFile(this, "splash.mp3");
  sewage = new SoundFile(this, "sewage.mp3");
  cityAmb = new SoundFile(this, "city.mp3");
  wind = new SoundFile(this, "wind.mp3");
  piano = new SoundFile(this, "piano.mp3");
}

void draw() {
  if (gameState == 1 || gameState == 3) {
    isPausible = true;
  } else {
    isPausible = false;
  }

  switch(gameState) {

    ///////////////////
    // Prolouge
    ///////////////////
  case 0:
    switch(proProg) {
    case 0:
      isPaused = true;
      background(0);
      fill(255);
      stroke(255);
      textSize(50);
      textAlign(CENTER);
      text("press SPACEBAR to start", width/2, height/2);
      break;

    case 1:
      isPaused = true;
      background(0);
      text("press arrow keys to move", width/2, height/2);
      if (upKnown == true) {
        text("up", width/2, height/4);
      }
      if (leftKnown == true) {
        text("left", width/4 - 100, height/2);
      }
      if (rightKnown == true) {
        text("right", 3*width/4 + 100, height/2);
      }
      if (upKnown == true && leftKnown == true && rightKnown == true) {
        text("good!", width/2, 3*height/4);
        text("(press SPACEBAR to continue)", width/2, 3*height/4 + 100);
        known = true;
      }
      break;

    case 2:
      isPaused = true;
      background(0);
      text("this is a game about u", width/2, height/2);
      break;

    case 3:
      isPaused = true;
      background(0);
      text("no, not you", width/2, height/2);
      break;

    case 4:
      isPaused = true;
      background(0);
      text("u", width/2, height/2);
      break;

    case 5:
      isPaused = true;
      background(0);
      text("your friend, v", width/2, height/2);
      break;

    case 6:
      isPaused = true;
      background(0);
      text("they're missing", width/2, height/2);
      break;

    case 7:
      isPaused = true;
      background(0);
      text("find them", width/2, height/2);
      break;
    }
    break;

    ///////////////////
    // Gameplay
    ///////////////////
  case 1:
    if (isPaused == true) {
      gameState = 3;
    }
    switch(zone) {
    case 0:
      sewage.stop();
      if (birds.isPlaying() == false) {
        birds.play();
      }
      background(0, 0, 25);
      switch(park) {
      case 0:
        floor00();
        if (player.playX >= width) {
          park = 1;
          player.playX = player.playerSize;
        }
        break;

      case 1:
        floor01();
        if (player.playX >= width) {
          park = 2;
          player.playX = player.playerSize;
        }
        if (player.playX <= 0) {
          park = 0;
          player.playX = width - 1;
        }
        break;

      case 2:
        cityAmb.stop();
        floor02();
        if (player.playX >= width) {
          park = 3;
          player.playX = player.playerSize;
        }
        if (player.playY >= height) {
          zone = 1;
          sewer = 0;
          player.playY = 0;
        }
        if (player.playX <= 0) {
          park = 1;
          player.playX = width - 1;
        }
        break;

      case 3:
        birds.stop();
        if (cityAmb.isPlaying() == false) {
          cityAmb.play();
        }
        background(25);
        floor03();
        if (player.playX >= width) {
          zone = 2;
          scape = 0;
          player.playX = player.playerSize;
        }
        if (player.playX <= 0) {
          park = 2;
          player.playX = width - 1;
        }
        break;
      }
      break;
    case 1:
      birds.stop();
      cityAmb.stop();
      if (sewage.isPlaying() == false) {
        sewage.play();
      }
      if ((player.playXSpeed > 0 || player.playXSpeed < 0) && player.canJump == true) {
        if (splash.isPlaying() == false) {
          splash.play();
        }
      }
      background(50, 0, 0);


      switch(sewer) {
      case 0:
        floor10();
        if (player.playY >= height) {
          sewer = 1;
          player.playY = 0;
        }
        if (player.playX >= width) {
          sewer = 5;
          player.playX = player.playerSize;
        }
        break;

      case 1:
        if (player.playX >= width) {
          sewer = 2;
          player.playX = player.playerSize;
        }
        floor11();
        break;

      case 2:
        if (player.playY >= height) {
          sewer = 1;
          deaths++;
          player.playY = height - 50;
          player.playX = 632;
        }
        if (player.playX <= 0) {
          sewer = 1;
          player.playX = width - 1;
        }
        if (player.playX >= width) {
          sewer = 3;
          player.playX = player.playerSize;
        }
        floor12();
        break;

      case 3:
        if (player.playY >= height) {
          sewer = 3;
          deaths++;
          player.playY = 225;
          player.playX = 275;
        }
        if (player.playY <= 0) {
          sewer = 4;
          player.playY = height - 1;
        }
        if (player.playX <= 0) {
          sewer = 2;
          player.playX = width - 1;
        }
        floor13();
        break;

      case 4:
        if (player.playY >= height) {
          sewer = 3;
          player.playY = 1;
        }
        if (player.playY <= 0) {
          zone = 2;
          scape = 0;
          player.playY = height - 1;
        }
        if (player.playX <= 0) {
          sewer = 5;
          player.playX = width - 1;
        }
        floor14();
        break;

      case 5:
        if (player.playX <= 0) {
          sewer = 0;
          player.playX = width - 1;
        }
        if (player.playX >= width) {
          sewer = 4;
          player.playX = player.playerSize;
        }
        floor15();
        break;
      }
      break;

    case 2:
      if (cityAmb.isPlaying() == false) {
        cityAmb.play();
      }
      background(25);
      sewage.stop();
      birds.stop();
      switch(scape) {
      case 0:
        if (player.playX <= 0) {
          zone = 0;
          park = 3;
          player.playX = width - 1;
        }
        if (player.playX >= width) {
          scape = 1;
          player.playX = player.playerSize;
        }
        if (player.playY >= height) {
          zone = 1;
          sewer = 4;
          player.playY = 1;
        }
        floor21();
        break;

      case 1:
        if (player.playX <= 0) {
          scape = 0;
          player.playX = width - 1;
        }
        if (player.playX >= width) {
          scape = 2;
          player.playX = player.playerSize;
        }
        floor22();
        break;

      case 2:
        if (player.playX <= 0) {
          scape = 1;
          player.playX = width - 1;
        }
        if (player.playY <= 0) {
          scape = 3;
          player.playY = height - 1;
        }
        if (player.playX >= width) {
          scape = 1;
          player.playX = player.playerSize;
        }
        floor23();
        break;

      case 3:
        wind.stop();
        if (player.playY <= 0) {
          scape = 4;
          player.playY = height - 1;
        }
        if (player.playY >= height) {
          scape = 2;
          player.playY = 1;
        }
        if (player.playX <= 0) {
          player.playX = width - 1;
        }
        if (player.playX >= width) {
          player.playX = player.playerSize;
        }
        floor24();
        break;

      case 4:
        cityAmb.stop();
        piano.stop();
        if (wind.isPlaying() == false) {
          wind.play();
        }
        if (player.playY >= height) {
          deaths++;
          player.playX = 387;
          player.playY = 0;
        }
        if (player.playX <= 0) {
          player.playX = 387;
          player.playY = 0;
        }
        if (player.playX >= width) {
          scape = 5;
          player.playX = player.playerSize;
        }
        floor25();
        break;

      case 5:
        cityAmb.stop();
        if (wind.isPlaying() == false) {
          wind.play();
        }
        if (player.playX <= 0) {
          scape = 4;
          player.playX = width - 1;
        }
        if (player.playX >= width) {
          scape = 6;
          player.playX = player.playerSize;
        }
        if (player.playY >= height) {
          deaths++;
          player.playX = 50;
          player.playY = 0;
        }
        floor26();
        break;

      case 6:
        cityAmb.stop();
        if (wind.isPlaying() == false) {
          wind.play();
        }
        if (player.playX <= 0) {
          scape = 5;
          player.playX = width - 1;
        }
        if (player.playX >= width) {
          scape = 7;
          player.playX = player.playerSize;
        }
        if (player.playY >= height) {
          deaths++;
          player.playX = 50;
          player.playY = 0;
        }
        floor27();
        break;

      case 7:
        cityAmb.stop();
        piano.stop();
        if (wind.isPlaying() == false) {
          wind.play();
        }
        if (player.playX <= 0) {
          scape = 6;
          player.playX = width - 1;
        }
        if (player.playX >= width) {
          scape = 8;
          player.playX = player.playerSize;
        }
        if (player.playY >= height) {
          deaths++;
          player.playX = 50;
          player.playY = 0;
        }
        floor28();
        break;

      case 8:
        cityAmb.stop();
        wind.stop();
        if (piano.isPlaying() == false) {
          piano.play();
        }
        if (player.playX <= 0) {
          scape = 7;
          player.playX = width - 1;
        }
        if (player.playY >= height) {
          scape = 7;
          player.playX = 600;
          player.playY = 0;
        }
        floor29();
        break;
      }
      break;
    }
    fill(255);
    stroke(255);
    textSize(25);
    textAlign(CENTER);
    text("deaths: " + deaths, 50, 25);
    break;
    ///////////////////
    // Win!
    ///////////////////
  case 2:
    background(0);
    fill(255);
    stroke(255);
    textSize(50);
    textAlign(CENTER);
    text("the end", width/2, height/2);
    text("you died " + deaths + " times", width/2, 3*height/4);
    text("(press r to restart)", width/2, 3*height/4 + 100);
    break;

    ///////////////////
    // paused
    ///////////////////
  case 3:
    if (birds.isPlaying() == true) {
      birds.stop();
    }
    if (sewage.isPlaying() == true) {
      sewage.stop();
    }
    if (cityAmb.isPlaying() == true) {
      cityAmb.stop();
    }
    if (wind.isPlaying() == true) {
      wind.stop();
    }
    if (piano.isPlaying() == true) {
      piano.stop();
    }
    if (isPaused == false) {
      gameState = 1;
    }
    background(0);
    fill(255);
    stroke(255);
    textSize(50);
    textAlign(CENTER);
    text("paused", width/2, height/2);
    break;
  }
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      if (proProg == 1) {
        upKnown = true;
      } else if (isPaused == false && cutscene == false) {
        player.isUp = true;
      }
    }
  }
  if (key == CODED) {
    if (keyCode == LEFT) {
      if (proProg == 1) {
        leftKnown = true;
      } else if (isPaused == false && cutscene == false) {
        player.isLeft = true;
      }
    }
  }
  if (key == CODED) {
    if (keyCode == RIGHT) {
      if (proProg == 1) {
        rightKnown = true;
      } else if (isPaused == false && cutscene == false) {
        player.isRight = true;
      }
    }
  }
  if (key == ' ') {
    if (proProg < 7) {
      if (proProg != 1) {
        proProg++;
      } else {
        if (known == true) {
          proProg++;
        } else {
        }
      }
    } else {
      isPaused = false;
      proProg = 0;
      gameState = 1;
    }
  }
  if (key == 'p' && cutscene == false) {
    if (isPausible == true) {
      isPaused = !isPaused;
    }
  }

  if (key == 'r') {
    birds.stop();
    sewage.stop();
    cityAmb.stop();
    wind.stop();
    piano.stop();
    gameState = 0;
    zone = 0;
    park = 0;
    sewer = 0;
    scape = 0;
  }
}

void keyReleased() {
  if (key == CODED) {
    if (keyCode == UP) {
      player.isUp = false;
    }
  }
  if (key == CODED) {
    if (keyCode == LEFT) {
      player.isLeft = false;
    }
  }
  if (key == CODED) {
    if (keyCode == RIGHT) {
      player.isRight = false;
    }
  }
}

/////////////////////////////////////////
// AREA 1-1
/////////////////////////////////////////
void floor00() {
  Floor floorA;
  House house;
  Tree tree3;
  Tree tree4;
  Sign park;
  Wall wall1;
  Stars background;
  floorHeight = height - 60;
  background = new Stars(color(200));
  floorA = new Floor(floorHeight, color(150));
  house = new House(375, floorHeight, 50, color(100));
  tree3 = new Tree(750, floorHeight, 50, color(100, 120, 100));
  tree4 = new Tree(1050, floorHeight, 50, color(100, 120, 100));
  park = new Sign(1100, floorHeight, 50, color(150), "PARK ->");
  wall1 = new Wall(75, floorHeight, 150, color(150));
  background.render();
  floorA.render();
  house.render();
  tree3.render();
  tree4.render();
  park.render();
  wall1.render();
  wall1.collision(player);
  player.render();
  player.move();
}

/////////////////////////////////////////
// AREA 1-2
/////////////////////////////////////////
void floor01() {
  Floor floorA;
  Tree tree1;
  Tree tree2;
  Tree tree3;
  Tree tree4;
  Platform plat1;
  Platform plat2;
  Platform plat3;
  Stars background;
  floorHeight = height - 60;
  background = new Stars(color(200));
  floorA = new Floor(floorHeight, color(150));
  tree1 = new Tree(150, floorHeight, 50, color(100, 120, 100));
  tree2 = new Tree(450, floorHeight, 50, color(100, 120, 100));
  tree3 = new Tree(750, floorHeight, 50, color(100, 120, 100));
  tree4 = new Tree(1050, floorHeight, 50, color(100, 120, 100));
  plat1 = new Platform(750, floorHeight - 95, 80, color(150));
  plat2 = new Platform(600, floorHeight - 205, 80, color(150));
  plat3 = new Platform(450, floorHeight - 95, 80, color(150));
  platList = new ArrayList<Platform>();
  platList.add(plat1);
  platList.add(plat2);
  platList.add(plat3);
  background.render();
  floorA.render();
  tree1.render();
  tree2.render();
  tree3.render();
  tree4.render();
  for (Platform aplatform : platList) {
    aplatform.render();
    aplatform.collision(player);
  }
  player.render();
  player.move();
}

/////////////////////////////////////////
// AREA 1-3
/////////////////////////////////////////
void floor02() {
  floorHeight = width + 10;
  Tree tree1;
  Sign city;
  Wall wall1;
  Wall wall2;
  Platform plat1;
  Platform plat2;
  Platform plat3;
  Stars background;
  background = new Stars(color(200));
  tree1 = new Tree(150, height - 60, 50, color(100, 120, 100));
  city = new Sign(300, height - 60, 50, color(150), "CITY ->");
  wall1 = new Wall(width/2 - 55, height, 40, color(150));
  wall2 = new Wall(width/2 + 120, height, 40, color(150));
  plat1 = new Platform(272, height - 40, 545, color(150));
  plat2 = new Platform(width - 240, height - 40, 480, color(150));
  plat3 = new Platform(851, height - 45, 175, color(175));
  platList = new ArrayList<Platform>();
  platList.add(plat1);
  platList.add(plat2);
  platList.add(plat3);
  wall1.render();
  wall1.collision(player);
  wall2.render();
  wall2.collision(player);
  background.render();
  tree1.render();
  city.render();
  for (Platform aplatform : platList) {
    aplatform.render();
    aplatform.collision(player);
  }
  player.render();
  player.move();
}

/////////////////////////////////////////
// AREA 1-4 / 3-0
/////////////////////////////////////////
void floor03() {
  Floor floorA;
  Sign closed;
  Wall wall1;
  Wall wall2;
  Wall wall3;
  Wall wall4;
  Wall wall5;
  floorHeight = height - 60;
  floorA = new Floor(floorHeight, color(150));
  closed = new Sign(1000, floorHeight, 50, color(150), "CLOSED");
  wall1 = new Wall(width - 75, floorHeight, 200, color(150));
  wall2 = new Wall(35, floorHeight, height, color(50));
  wall3 = new Wall(445, floorHeight, height, color(50));
  wall4 = new Wall(675, floorHeight, height, color(50));
  wall5 = new Wall(1050, floorHeight, height, color(50));
  floorA.render();
  wall2.render();
  wall3.render();
  wall4.render();
  wall5.render();
  closed.render();
  wall1.render();
  wall1.collision(player);
  player.render();
  player.move();
}

/////////////////////////////////////////
// AREA 2-1
/////////////////////////////////////////
void floor10() {
  floorHeight = width + 10;
  Wall wall1;
  Wall wall2;
  Wall wall3;
  Wall wall4;
  Ceiling c1;
  Ceiling c2;
  Platform plat1;
  Platform plat2;
  wall1 = new Wall(width/2 - 55, height, height, color(150));
  wall2 = new Wall(width/2 + 120, 600, 600, color(150));
  wall3 = new Wall(width/2 + 120, height, 100, color(150));
  wall4 = new Wall(900, 485, 100, color(150));
  c1 = new Ceiling(1050, 400, 300, color(150));
  c2 = new Ceiling(width - 240, 600, 480, color(150));
  plat1 = new Platform(1050, 500, 300, color(150));
  plat2 = new Platform(width - 240, 700, 480, color(150));
  platList = new ArrayList<Platform>();
  platList.add(plat1);
  platList.add(plat2);
  wall1.render();
  wall1.collision(player);
  wall2.render();
  wall2.collision(player);
  wall3.render();
  wall3.collision(player);
  wall4.render();
  wall4.collision(player);
  c1.render();
  c1.collision(player);
  c2.render();
  c2.collision(player);
  for (Platform aplatform : platList) {
    aplatform.render();
    aplatform.collision(player);
  }
  player.render();
  player.move();
}

/////////////////////////////////////////
// AREA 2-2
/////////////////////////////////////////
void floor11() {
  Floor floor;
  floorHeight = height - 70;
  Wall wall1;
  Wall wall2;
  Wall wall3;
  Ceiling c1;
  Ceiling c2;
  floor = new Floor(floorHeight, color(150));
  wall1 = new Wall(width/2 - 55, floorHeight - 150, height, color(150));
  wall2 = new Wall(width/2 + 120, floorHeight - 150, height, color(150));
  wall3 = new Wall(200, floorHeight + 15, 150, color(150));
  c1 = new Ceiling(272, floorHeight - 125, 545, color(150));
  c2 = new Ceiling(width - 240, floorHeight - 125, 480, color(150));
  wall1.render();
  wall1.collision(player);
  wall2.render();
  wall2.collision(player);
  wall3.render();
  wall3.collision(player);
  c1.render();
  c2.render();
  c1.collision(player);
  c2.collision(player);
  floor.render();
  player.render();
  player.move();
}

/////////////////////////////////////////
// AREA 2-3
/////////////////////////////////////////
void floor12() {
  floorHeight = width + 10;
  Sign danger;
  Ceiling ceiling;
  Ceiling cA;
  Ceiling cB;
  Wall wall1;
  Wall wall2;
  Wall wall3;
  Wall wall4;
  Platform platA;
  Platform platB;
  Platform plat1;
  Platform plat2;
  Platform plat3;
  Platform plat4;
  Platform plat5;
  Platform plat6;
  danger = new Sign(750, height, 50, color(150), "DANGER");
  ceiling = new Ceiling(600, 100, 1000, color(150));
  cA = new Ceiling(50, height - 175, 100, color(150));
  cB = new Ceiling(1150, 200, 100, color(150));
  wall1 = new Wall(100, height, 50, color(150));
  wall2 = new Wall(100, height - 175, height - 175 - 100, color(150));
  wall3 = new Wall(1100, height, 500, color(150));
  wall4 = new Wall(1100, 200, 100, color(150));
  platA = new Platform(75, height - 50, 150, color(150));
  platB = new Platform(width - 75, 300, 150, color(150));
  plat1 = new Platform(350, height - 50, 100, color(150));
  plat2 = new Platform(350, height - 250, 100, color(150));
  plat3 = new Platform(550, height - 150, 100, color(175));
  plat4 = new Platform(600, height - 350, 100, color(150));
  plat5 = new Platform(875, height - 250, 100, color(150));
  plat6 = new Platform(1000, height - 400, 100, color(175));
  platList = new ArrayList<Platform>();
  platList.add(platA);
  platList.add(platB);
  platList.add(plat1);
  platList.add(plat2);
  platList.add(plat3);
  platList.add(plat4);
  platList.add(plat5);
  platList.add(plat6);
  ceiling.render();
  ceiling.collision(player);
  cA.render();
  cA.collision(player);
  cB.render();
  cB.collision(player);
  wall1.render();
  wall1.collision(player);
  wall2.render();
  wall2.collision(player);
  wall3.render();
  wall3.collision(player);
  wall4.render();
  wall4.collision(player);
  danger.render();
  for (Platform aplatform : platList) {
    aplatform.render();
    aplatform.collision(player);
  }
  player.render();
  player.move();
}

/////////////////////////////////////////
// AREA 2-4
/////////////////////////////////////////
void floor13() {
  floorHeight = width + 10;
  Ceiling cA;
  Ceiling cB;
  Wall wall1;
  Wall wall2;
  Wall wall3;
  Wall wall4;
  Wall wall5;
  Platform platA;
  Platform platB;
  Platform plat1;
  Platform plat2;
  Platform plat3;
  Platform plat4;
  Platform plat5;
  Platform plat6;
  cA = new Ceiling(225, 200, 450, color(150));
  cB = new Ceiling(width - 225, 200, 450, color(150));
  wall1 = new Wall(450, height, 500, color(150));
  wall2 = new Wall(450, 200, 200, color(150));
  wall3 = new Wall(750, height, 500, color(150));
  wall4 = new Wall(750, 200, 200, color(150));
  wall5 = new Wall(1000, 285, 100, color(150));
  platA = new Platform(225, 300, 450, color(150));
  platB = new Platform(width - 225, 300, 450, color(150));
  plat1 = new Platform(675, 600, 50, color(150));
  plat2 = new Platform(525, 500, 50, color(150));
  plat3 = new Platform(675, 400, 50, color(175));
  plat4 = new Platform(525, 300, 50, color(150));
  plat5 = new Platform(675, 200, 50, color(150));
  plat6 = new Platform(525, 100, 50, color(175));
  platList = new ArrayList<Platform>();
  platList.add(platA);
  platList.add(platB);
  platList.add(plat1);
  platList.add(plat2);
  platList.add(plat3);
  platList.add(plat4);
  platList.add(plat5);
  platList.add(plat6);
  cA.render();
  cA.collision(player);
  cB.render();
  cB.collision(player);
  wall1.render();
  wall1.collision(player);
  wall2.render();
  wall2.collision(player);
  wall3.render();
  wall3.collision(player);
  wall4.render();
  wall4.collision(player);
  wall5.render();
  wall5.collision(player);
  for (Platform aplatform : platList) {
    aplatform.render();
    aplatform.collision(player);
  }
  player.render();
  player.move();
}

/////////////////////////////////////////
// AREA 2-5
/////////////////////////////////////////
void floor14() {
  floorHeight = width + 10;
  Ceiling ceiling;
  Ceiling cA;
  Ceiling cB;
  Wall wall1;
  Wall wall2;
  Wall wall3;
  Wall wall4;
  Wall wall5;
  Platform platA;
  Platform plat1;
  Platform plat2;
  Platform plat3;
  Platform plat4;
  Platform plat5;
  Platform plat6;
  Platform plat7;
  Platform plat8;
  ceiling = new Ceiling(225, 400, 450, color(150));
  cA = new Ceiling(500, 200, 100, color(150));
  cB = new Ceiling(700, 200, 100, color(150));
  wall1 = new Wall(450, height, 300, color(150));
  wall2 = new Wall(450, 400, 200, color(150));
  wall3 = new Wall(550, 200, 200, color(150));
  wall4 = new Wall(750, height, 600, color(150));
  wall5 = new Wall(650, 200, 200, color(150));
  platA = new Platform(225, 500, 450, color(150));
  plat1 = new Platform(675, 800, 50, color(150));
  plat2 = new Platform(525, 700, 50, color(150));
  plat3 = new Platform(675, 600, 50, color(175));
  plat4 = new Platform(525, 500, 50, color(150));
  plat5 = new Platform(675, 400, 50, color(150));
  plat6 = new Platform(600, 300, 100, color(175));
  plat7 = new Platform(600, 200, 100, color(175));
  plat8 = new Platform(600, 100, 100, color(175));
  platList = new ArrayList<Platform>();
  platList.add(platA);
  platList.add(plat1);
  platList.add(plat2);
  platList.add(plat3);
  platList.add(plat4);
  platList.add(plat5);
  platList.add(plat6);
  platList.add(plat7);
  platList.add(plat8);
  ceiling.render();
  ceiling.collision(player);
  cA.render();
  cA.collision(player);
  cB.render();
  cB.collision(player);
  wall1.render();
  wall1.collision(player);
  wall2.render();
  wall2.collision(player);
  wall3.render();
  wall3.collision(player);
  wall4.render();
  wall4.collision(player);
  wall5.render();
  wall5.collision(player);
  for (Platform aplatform : platList) {
    aplatform.render();
    aplatform.collision(player);
  }
  player.render();
  player.move();
}

/////////////////////////////////////////
// AREA 2-6
/////////////////////////////////////////
void floor15() {
  floorHeight = width + 10;
  Ceiling cA;
  Ceiling cB;
  Wall wall1;
  Platform plat1;
  Platform plat2;
  cA = new Ceiling(600, 400, width, color(150));
  cB = new Ceiling(150, 600, 300, color(150));
  wall1 = new Wall(300, 685, 100, color(150));
  plat1 = new Platform(600, 500, width, color(150));
  plat2 = new Platform(150, 700, 300, color(150));
  platList = new ArrayList<Platform>();
  platList.add(plat1);
  platList.add(plat2);
  cA.render();
  cA.collision(player);
  cB.render();
  cB.collision(player);
  wall1.render();
  wall1.collision(player);
  for (Platform aplatform : platList) {
    aplatform.render();
    aplatform.collision(player);
  }
  player.render();
  player.move();
}

/////////////////////////////////////////
// AREA 3-1
/////////////////////////////////////////
void floor21() {
  floorHeight = width + 10;
  Wall wall1;
  Wall wall2;
  Wall wall3;
  Wall wall4;
  Wall wall5;
  Wall wall6;
  Platform plat1;
  wall1 = new Wall(550, height, 40, color(150));
  wall2 = new Wall(650, height, 40, color(150));
  wall3 = new Wall(200, height - 60, height, color(50));
  wall4 = new Wall(600, height - 60, height, color(50));
  wall5 = new Wall(700, height - 60, height, color(50));
  wall6 = new Wall(1100, height - 60, height, color(50));
  plat1 = new Platform(600, height - 40, width, color(150));
  platList = new ArrayList<Platform>();
  platList.add(plat1);
  wall1.render();
  wall1.collision(player);
  wall2.render();
  wall2.collision(player);
  wall3.render();
  wall4.render();
  wall5.render();
  wall6.render();
  for (Platform aplatform : platList) {
    aplatform.render();
    aplatform.collision(player);
  }
  player.render();
  player.move();
}

/////////////////////////////////////////
// AREA 3-2
/////////////////////////////////////////
void floor22() {
  Floor floorA;
  Wall wall2;
  Wall wall3;
  Wall wall4;
  Wall wall5;
  floorHeight = height - 60;
  floorA = new Floor(floorHeight, color(150));
  wall2 = new Wall(35, floorHeight, height, color(50));
  wall3 = new Wall(445, floorHeight, height, color(50));
  wall4 = new Wall(675, floorHeight, height, color(50));
  wall5 = new Wall(1050, floorHeight, height, color(50));
  floorA.render();
  wall2.render();
  wall3.render();
  wall4.render();
  wall5.render();
  player.render();
  player.move();
}

/////////////////////////////////////////
// AREA 3-3
/////////////////////////////////////////
void floor23() {
  floorHeight = height - 60;
  Floor floorA;
  Wall wall1;
  Wall wall2;
  Wall wall3;
  Wall wall4;
  Wall wall5;
  Wall wall6;
  Platform plat1;
  Platform plat2;
  Platform plat3;
  Platform plat4;
  Platform plat5;
  floorA = new Floor(floorHeight, color(150));
  wall1 = new Wall(450, floorHeight, floorHeight, color(#937B00));
  wall2 = new Wall(750, floorHeight, floorHeight, color(#937B00));
  wall3 = new Wall(75, floorHeight, height, color(50));
  wall4 = new Wall(400, floorHeight, height, color(50));
  wall5 = new Wall(705, floorHeight, height, color(50));
  wall6 = new Wall(1100, floorHeight, height, color(50));
  plat1 = new Platform(675, floorHeight - 125, 50, color(#B29500));
  plat2 = new Platform(525, floorHeight - 250, 50, color(#B29500));
  plat3 = new Platform(675, floorHeight - 375, 50, color(#B29500));
  plat4 = new Platform(525, floorHeight - 500, 50, color(#B29500));
  plat5 = new Platform(675, floorHeight - 625, 50, color(#B29500));
  platList = new ArrayList<Platform>();
  platList.add(plat1);
  platList.add(plat2);
  platList.add(plat3);
  platList.add(plat4);
  platList.add(plat5);
  floorA.render();
  wall1.render();
  wall2.render();
  wall3.render();
  wall4.render();
  wall5.render();
  wall6.render();
  for (Platform aplatform : platList) {
    aplatform.render();
    aplatform.collision(player);
  }
  player.render();
  player.move();
}

/////////////////////////////////////////
// AREA 3-4
/////////////////////////////////////////
void floor24() {
  floorHeight = height + 10;
  Wall wall1;
  Wall wall2;
  Wall wall3;
  Wall wall4;
  Wall wall5;
  Wall wall6;
  Wall wall7;
  Wall wall8;
  Platform platA;
  Platform platB;
  Platform plat1;
  Platform plat2;
  Platform plat3;
  Platform plat5;
  Platform plat6;
  wall1 = new Wall(450, height, 400, color(#937B00));
  wall2 = new Wall(750, height, 400, color(#937B00));
  wall3 = new Wall(50, 300, 300, color(#937B00));
  wall4 = new Wall(350, 300, 300, color(#937B00));
  wall5 = new Wall(75, height, height, color(50));
  wall6 = new Wall(400, height, height, color(50));
  wall7 = new Wall(705, height, height, color(50));
  wall8 = new Wall(1100, height, height, color(50));
  platA = new Platform(600, 400, 300, color(#B29500));
  platB = new Platform(200, 300, 300, color(#B29500));
  plat1 = new Platform(525, height - 10, 50, color(#B29500));
  plat2 = new Platform(675, height - 135, 50, color(#B29500));
  plat3 = new Platform(525, height - 260, 50, color(#B29500));
  plat5 = new Platform(125, 175, 50, color(#B29500));
  plat6 = new Platform(275, 50, 50, color(#B29500));
  platList = new ArrayList<Platform>();
  platList.add(platA);
  platList.add(platB);
  platList.add(plat1);
  platList.add(plat2);
  platList.add(plat3);
  platList.add(plat5);
  platList.add(plat6);
  wall1.render();
  wall2.render();
  wall3.render();
  wall4.render();
  wall5.render();
  wall6.render();
  wall7.render();
  wall8.render();
  for (Platform aplatform : platList) {
    aplatform.render();
    aplatform.collision(player);
  }
  player.render();
  player.move();
}

/////////////////////////////////////////
// AREA 3-5
/////////////////////////////////////////
void floor25() {
  background(0);
  Stars background;
  floorHeight = height + 10;
  Wall wall1;
  Wall wall2;
  Wall wall3;
  Wall wall4;
  Wall wall5;
  Platform platA;
  Platform platB;
  Platform platC;
  Platform platD;
  Platform plat1;
  Platform plat2;
  background = new Stars(color(200));
  wall1 = new Wall(25, height, 400, color(50));
  wall2 = new Wall(750, height, 400, color(50));
  wall3 = new Wall(50, height, 300, color(#937B00));
  wall4 = new Wall(350, height, 300, color(#937B00));
  wall5 = new Wall(900, height, 475, color(50));
  platA = new Platform(387, 400, 775, color(50));
  platB = new Platform(1050, 325, 300, color(50));
  platC = new Platform(200, 500, 300, color(#B29500));
  platD = new Platform(200, 775, 300, color(#B29500));
  plat1 = new Platform(125, height - 75, 50, color(#B29500));
  plat2 = new Platform(275, height - 200, 50, color(#B29500));
  platList = new ArrayList<Platform>();
  platList.add(platA);
  platList.add(platB);
  platList.add(platC);
  platList.add(platD);
  platList.add(plat1);
  platList.add(plat2);
  background.render();
  wall1.render();
  wall2.render();
  wall3.render();
  wall4.render();
  wall5.render();
  for (Platform aplatform : platList) {
    aplatform.render();
    aplatform.collision(player);
  }
  player.render();
  player.move();
}

/////////////////////////////////////////
// AREA 3-6
/////////////////////////////////////////
void floor26() {
  background(0);
  Stars background;
  floorHeight = height + 10;
  Wall wall1;
  Wall wall2;
  Platform platA;
  Platform platB;
  background = new Stars(color(200));
  wall1 = new Wall(100, height, 475, color(50));
  wall2 = new Wall(1100, height, 425, color(50));
  platA = new Platform(50, 325, 100, color(50));
  platB = new Platform(1150, 375, 100, color(50));
  platList = new ArrayList<Platform>();
  platList.add(platA);
  platList.add(platB);
  background.render();
  wall1.render();
  wall2.render();
  move1.render();
  move1.collision(player, move1);
  move1.move();
  move2.render();
  move2.collision(player, move2);
  move2.move();
  for (Platform aplatform : platList) {
    aplatform.render();
    aplatform.collision(player);
  }
  player.render();
  player.move();
}

/////////////////////////////////////////
// AREA 3-7
/////////////////////////////////////////
void floor27() {
  background(0);
  Stars background;
  floorHeight = height + 10;
  Wall wall1;
  Wall wall2;
  Platform platA;
  Platform platB;
  background = new Stars(color(200));
  wall1 = new Wall(100, height, 425, color(50));
  wall2 = new Wall(1100, height, 500, color(50));
  platA = new Platform(50, 375, 100, color(50));
  platB = new Platform(1150, 300, 100, color(50));
  platList = new ArrayList<Platform>();
  platList.add(platA);
  platList.add(platB);
  background.render();
  wall1.render();
  wall2.render();
  move3.render();
  move3.collision(player, move3);
  move3.move();
  move4.render();
  move4.collision(player, move4);
  move4.move();
  move5.render();
  move5.collision(player, move5);
  move5.move();
  move6.render();
  move6.collision(player, move6);
  move6.move();
  for (Platform aplatform : platList) {
    aplatform.render();
    aplatform.collision(player);
  }
  player.render();
  player.move();
}

/////////////////////////////////////////
// AREA 3-8
/////////////////////////////////////////
void floor28() {
  background(0);
  Stars background;
  floorHeight = height + 10;
  Wall wall1;
  Wall wall2;
  Wall wall3;
  Wall wall4;
  Platform platA;
  Platform platB;
  Platform platC;
  background = new Stars(color(200));
  wall1 = new Wall(200, height, 500, color(50));
  wall2 = new Wall(300, height, 400, color(50));
  wall3 = new Wall(900, height, 400, color(50));
  wall4 = new Wall(1000, height, 300, color(50));
  platA = new Platform(100, 300, 200, color(50));
  platB = new Platform(600, 400, 600, color(50));
  platC = new Platform(1100, 500, 200, color(50));
  platList = new ArrayList<Platform>();
  platList.add(platA);
  platList.add(platB);
  platList.add(platC);
  background.render();
  wall1.render();
  wall2.render();
  wall3.render();
  wall4.render();
  for (Platform aplatform : platList) {
    aplatform.render();
    aplatform.collision(player);
  }
  player.render();
  player.move();
}

/////////////////////////////////////////
// AREA 3-9
/////////////////////////////////////////
void floor29() {
  background(0);
  Stars background;
  floorHeight = height + 10;
  Wall wall1;
  Wall wall2;
  Platform platA;
  Platform platB;
  background = new Stars(color(200));
  wall1 = new Wall(450, height, 300, color(50));
  wall2 = new Wall(500, height, 275, color(50));
  platA = new Platform(225, 500, 450, color(50));
  platB = new Platform(850, 525, 700, color(50));
  platList = new ArrayList<Platform>();
  platList.add(platA);
  platList.add(platB);
  background.render();
  wall1.render();
  wall2.render();
  for (Platform aplatform : platList) {
    aplatform.render();
    aplatform.collision(player);
  }
  player.render();
  player.move();
  textAlign(CENTER);
  fill(255);
  stroke(255);
  textSize(player.playerSize);
  text("v", 1000, 505);
  if (player.playY > 490) {
    player.canJump = false;
    player.isLeft = false;
    player.playY = 505;
  }
  if (player.playX >= 975) {
    cutscene = true;
    player.playXSpeed = 0;
    endCut = millis();
    if (endCut - startCut >= pauseForEffect) {
      textAlign(CENTER);
      fill(255, 0, 0);
      stroke(255, 0, 0);
      textSize(player.playerSize);
      text("<3", 987, 450);
      if (endCut - startCut >= 8000) {
        gameState = 2;
      }
    }
  }
  if (cutscene == false) {
    startCut = millis();
  }
}

// There is no spoon
