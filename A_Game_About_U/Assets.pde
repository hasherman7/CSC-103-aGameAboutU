class Floor {
  int y;
  color c;

  Floor(int fY, color fC) {
    y = fY;
    c = fC;
  }

  void render() {
    textAlign(LEFT);
    fill(150);
    stroke(150);
    textSize(50);
    text("_____________________________________________________________________________", 0, y);
  }
}

class Tree {
  int x;
  int y;
  int s;
  color c;
  int spacing;

  Tree(int tx, int ty, int ts, color tc) {
    x = tx;
    y = ty;
    s = ts;
    c = tc;
    spacing = 50;
  }

  void render() {
    textAlign(CENTER);
    fill(c);
    stroke(c);
    textSize(s);
    text("/ \\", x, y - 7*spacing - spacing/2 - 10);
    text("/     \\", x, y - 6*spacing - spacing/2 - 10);
    text("/         \\", x, y - 5*spacing - spacing/2 - 10);
    text("/             \\", x, y - 4*spacing - spacing/2 - 10);
    text("/                 \\", x, y - 3*spacing - spacing/2 - 10);
    text("/                     \\", x, y - 2*spacing - spacing/2 - 10);
    text("---------------", x, y - spacing - spacing/2 - 10);
    text("||", x, y - spacing/2 - 10);
    text("||", x, y - 10);
  }
}

class Stars {
  int s;
  color c;
  int spacing;
  int y;

  Stars(color starC) {
    s = 50;
    c = starC;
    spacing = 25;
  }

  void render() {
    textAlign(CENTER);
    fill(c);
    stroke(c);
    textSize(s);
    text(" ", 0, y - 4*spacing);
    text("                            *         --                       *                              *                           *  ", width/2, 0 + s);
    text("            *                        ||               *                                                *                     ", width/2, spacing + s);
    text("                               *      --                                          *                            *             ", width/2, 2*spacing + s);
    text(" *       *                                                                *                                                  ", width/2, 3*spacing + s);
    text("                    *                          *                                        *                   *                ", width/2, 4*spacing + s);
  }
}

class Wall {
  int x;
  int y;
  int topWall;
  color c;
  int top;
  int bottom;
  int left;
  int right;

  Wall(int wallX, int wallY, int wallH, color wallC) {
    x = wallX;
    y = wallY;
    topWall = wallH;
    c = wallC;
    top = wallY - wallH;
    bottom = wallY;
    left = wallX - 10;
    right = wallX + 10;
  }

  void render() {
    textAlign(CENTER);
    textSize(50);
    fill(c);
    stroke(c);
    for (int wallHeight = y; wallHeight >= y - topWall; wallHeight -= 65) {
      text("|", x, wallHeight);
    }
  }

  void collision(U aplayer) {
    if (left < aplayer.right + 10 &&
      right > aplayer.left - 10 &&
      top < aplayer.bottom &&
      bottom > aplayer.top) {
      if (player.playXSpeed > 0 && player.playX < x) {
        player.playX = left - 10;
      } else if (player.playXSpeed < 0 && player.playX > x) {
        player.playX = right + 10;
      }
    }
  }
}

class Platform {
  int x;
  int y;
  int w;
  color c;

  int top;
  int bottom;
  int left;
  int right;

  Platform(int platX, int platY, int platW, color platC) {
    x = platX;
    y = platY;
    w = platW;
    c = platC;
    top = platY - 10;
    bottom = platY + 10;
    left = platX - platW/2;
    right = platX + platW/2;
  }

  void render() {
    fill(c);
    stroke(c);
    textAlign(CENTER);
    textSize(50);
    for (int platWidth = x - w/2; platWidth <= x + w/2; platWidth += 25) {
      text("_", platWidth, y - 20);
    }
  }

  void collision(U aplayer) {
    if (left < aplayer.right &&
      right > aplayer.left &&
      top - 11 < aplayer.bottom &&
      bottom > aplayer.top) {
      if (player.playYSpeed >= 0) {
        floorHeight = top - 10;
      }
    }
  }
}

class Movable {
  int x;
  int y;
  int w;
  color c;

  int minX;
  int maxX;
  int minY;
  int maxY;
  int xSpeed;
  int ySpeed;

  Movable(int moveX, int moveY, int moveW, color moveC, int miniX, int maxiX, int miniY, int maxiY, int xSpe, int ySpe) {
    x = moveX;
    y = moveY;
    w = moveW;
    c = moveC;
    minX = miniX;
    maxX = maxiX;
    minY = miniY;
    maxY = maxiY;
    xSpeed = xSpe;
    ySpeed = ySpe;
  }

  void render() {
    fill(c);
    stroke(c);
    textAlign(CENTER);
    textSize(50);
    for (int moveWidth = x - w/2; moveWidth <= x + w/2; moveWidth += 25) {
      text("_", moveWidth, y - 20);
    }
  }

  void collision(U aplayer, Movable amove) {
    int top;
    int bottom;
    int left;
    int right;
    top = amove.y - 10;
    bottom = amove.y + 10;
    left = amove.x - amove.w/2;
    right = amove.x + amove.w/2;
    if (left < aplayer.right &&
      right > aplayer.left &&
      top - 11 < aplayer.bottom &&
      bottom > aplayer.top) {
      if (player.playYSpeed >= 0) {
        floorHeight = top - 10;
        if(amove.xSpeed != 0  && keyPressed == false){
          player.playXSpeed = amove.xSpeed;
        }
      }
    }
  }

  void move() {
    x += xSpeed;
    y += ySpeed;
    if (x >= maxX || x <= minX) {
      xSpeed = -xSpeed;
    }
    if (y >= maxY || y <= minY) {
      ySpeed = -ySpeed;
    }
  }
}

class Ceiling {
  int x;
  int y;
  int w;
  color c;

  int top;
  int bottom;
  int left;
  int right;

  Ceiling(int cX, int cY, int cW, color cC) {
    x = cX;
    y = cY;
    w = cW;
    c = cC;
    top = cY - 10;
    bottom = cY + 10;
    left = cX - cW/2;
    right = cX + cW/2;
  }

  void render() {
    fill(c);
    stroke(c);
    textAlign(CENTER);
    textSize(50);
    for (int cWidth = x - w/2; cWidth <= x + w/2; cWidth += 25) {
      text("_", cWidth, y - 20);
    }
  }

  void collision(U aplayer) {
    if (left < aplayer.right &&
      right > aplayer.left &&
      top < aplayer.bottom &&
      bottom > aplayer.top) {
      player.playYSpeed = abs(player.playYSpeed);
      player.playY = bottom + 1;
    }
  }
}

class House {
  int x;
  int y;
  int s;
  color c;

  House(int hX, int hY, int hS, color hC) {
    x = hX;
    y = hY;
    s = hS;
    c = hC;
  }

  void render() {
    fill(c);
    stroke(c);
    textSize(s);
    textAlign(CENTER);
    text("| |", x - 150, y - 250);
    text("_______", x, y - 250);
    text("| |", x - 150, y - 200);
    text("___/                    \\___", x, y - 200);
    text("/                                      \\", x, y - 150);
    text("|                  __                   |", x, y - 100);
    text("|      []        |    |         []      |", x, y - 50);
    text("|                 |    |                  |", x, y);
  }
}

class Sign {
  int x;
  int y;
  int s;
  color c;
  String text;

  Sign(int sX, int sY, int sS, color sC, String stext) {
    x = sX;
    y = sY;
    s = sS;
    c = sC;
    text = stext;
  }

  void render() {
    fill(c);
    stroke(c);
    textSize(s);
    textAlign(CENTER);
    rectMode(CENTER);
    text("______", x, y - 150);
    text("|               |", x, y - 100);
    text("|______|", x, y - 50);
    text("|", x, y);
    fill(0);
    stroke(0);
    rect(x, y - 95, 150, 90);
    fill(c);
    stroke(c);
    textSize(s - 10);
    text(text, x, y - 80);
  }
}
