class greenbutterfly {
  PImage gb;
  float gx, gy;
  float gbs;
  float dx, dy;
  float a,b;

  greenbutterfly() {
    gb = loadImage("green-butterfly.png");
    a =400;//random(pl.getX()-20, pl.getX()+20);
    b =200;//random(pl.getY(),pl.getY()-100);
    
    gx = a;
    gy = b;
    
    //gx = pl.getX()-dx;
    //gy = pl.getY()-dy;

    //dy = random(2, 7);
    //dx = random(-5, 5);
    
    gbs = 40;
    
    dx = 1;
    dy = 1;
  }

  void show() {
    image(gb, gx, gy, gbs, gbs);
  }

  void act() {

    
    //gx = gx - dx;
    //dx = dx + random(-1,1);
    
    gy = gy - dy;
    dy = dy - 2;
    //dy = dy + random(2, 7);
    //dx = dx + random(2, 5);
    
    //gx = gx - dx;
    //gy = gy - dy;
    
    //if (gy<pl.getY()-100) {
    //  gbs = gbs - 15;
    //}

  }
}

void drawGreenButterflies() {
  int n = 5;
  greenbutterfly[] greens = new greenbutterfly[n];
  for (int i = 0; i<n; i++) {
    greens[i] = new greenbutterfly();
    //greens[i].show();
    //greens[i].act();
  }
  
  for (int i =0; i<n; i++) {
        greens[i].show();
        greens[i].act();
      }
  
  
}
class bluebutterfly {
  PImage bb;

  bluebutterfly() {
    bb = loadImage("blue-butterfly.png");
  }

  void show() {
  }

  void act() {
  }
}