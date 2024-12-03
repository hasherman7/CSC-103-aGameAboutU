class U {
  int playX;
  int playY;
  int playXSpeed;
  int playGravity;
  int playYSpeed;
  int playerSize;

  boolean isUp;
  boolean isLeft;
  boolean isRight;
  boolean canJump;
  boolean isFalling;

  int left;
  int right;
  int top;
  int bottom;

  U(int x, int y) {
    playX = x;
    playY = y;
    playXSpeed = 0;
    playYSpeed = 0;
    playGravity = 1;
    isUp = false;
    isLeft = false;
    isRight = false;
    canJump = false;
    playerSize = 50;
  }

  void render() {
    textAlign(CENTER);
    fill(255);
    stroke(255);
    textSize(playerSize);
    text("u", playX, playY);
  }

  void move() {
    playX += playXSpeed;
    playYSpeed += playGravity;
    playY += playYSpeed;
    if (isUp == true && canJump == true) {
      jump.play();
      playYSpeed = -17;
    }

    if (isRight == true && isLeft == false) {
      playXSpeed = 5;
    } else if (isLeft == true && isRight == false) {
      playXSpeed = -5;
    } else {
      playXSpeed = 0;
    }

    if (playY >= floorHeight) {
      playY = floorHeight;
      playYSpeed = 0;
    }
    
    
  if (playY < floorHeight) {
    canJump = false;
  } else {
    canJump = true;
  }

    if (isUp == true && canJump == true) {
      playYSpeed = -15;
    }

    left = playX - 10;
    right = playX + 10;
    top = playY - 10;
    bottom = playY + 10;
  }
}
