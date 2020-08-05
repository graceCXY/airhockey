import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

import fisica.*;

//pallette
color darkpurple = color(176, 166, 183);
color violet = color(143, 85, 149);
color orchid = color(215, 202, 225);
color lavender = color(241, 216, 243);
color white = color(255, 255, 255);
color black = color(0, 0, 0);

//mode
final int intro = 1;
final int playing = 2;
final int pausing = 3;
final int gameover = 4;
int mode;

//paddle
float vxl, vyl;
float vxr, vyr;
FCircle pl;
FCircle pr;

//puck
FCircle puck;

//scores
int scoreleft = 0;
int scoreright = 0;

//movement
boolean up, left, right, down;
boolean w, a, d, s;

FWorld world;

//images
PImage introcloud, gameovercloud;

//sound
Minim minim;
AudioPlayer oink;
AudioPlayer bleat;
AudioPlayer bounce;
AudioPlayer scoresound;

//animation
boolean postcollision;
int count = 90;

void setup() {
  size(800, 600, FX2D);
  mode = intro;

  Fisica.init(this);
  world = new FWorld();
  world.setGravity(0, 0);

  minim = new Minim(this);
  oink = minim.loadFile("pigoink.wav");
  bleat = minim.loadFile("sheepbleat.wav");
  bounce = minim.loadFile("bounce.wav");
  scoresound = minim.loadFile("score.wav");

  introcloud = loadImage("introcloud.jpg");
  gameovercloud = loadImage("gameovercloud.jpg");



  //make rink
  makeRink();

  //make puck
  makePuck();

  //make paddle
  makePaddle();

  w = false;
  a = false;
  s = false;
  d = false;

  up = false;
  down = false;
  right = false;
  left = false;

  vxl = 0;
  vyl = 0;
  vxr = 0;
  vyr = 0;

  postcollision = false;
}

void draw() {
  if (mode == intro) {
    drawIntro();
    restart();
  } else if (mode == playing) {
    drawThings();
    world.step();  //get box2D to calculate all the forces and new positions
    world.draw();

    moveThings();

    collision();
    count--;
    if (postcollision == true && count >0) {
      drawGreenButterflies();
      
    }
    //scoring
    scoring();
  } else if (mode == pausing) {
    world.draw();
    scoring();
  } else if (mode == gameover) {
    drawGameOver();
  }
}
void mouseReleased() {
  if (mode == intro) {
    mode = playing;
  } else if (mode == playing && dist(750, 50, mouseX, mouseY) <= 60) {
    mode = pausing;
  } else if (mode == pausing && dist(750, 50, mouseX, mouseY) <= 60) {
    mode = playing;
  } else if (mode == gameover) {
    mode = intro;
  }
}

void keyPressed() {

  if (keyCode == UP) {
    up = true;
  }  
  if (keyCode == DOWN) {
    down = true;
  }
  if (keyCode == LEFT) {
    left = true;
  }
  if (keyCode == RIGHT) {
    right = true;
  }
  if (key == 'W' || key == 'w') {
    w = true;
  }
  if (key == 'a' || key == 'A') {
    a = true;
  }
  if (key == 's' || key == 'S') {
    s = true;
  }
  if (key == 'd' || key == 'D') {
    d = true;
  }
  println(up);
}

void keyReleased() {
  if (keyCode == UP) {
    up = false;
  }  
  if (keyCode == DOWN) {
    down = false;
  }
  if (keyCode == LEFT) {
    left = false;
  }
  if (keyCode == RIGHT) {
    right = false;
  }
  if (key == 'W' || key == 'w') {
    w = false;
  }
  if (key == 'a' || key == 'A') {
    a = false;
  }
  if (key == 's' || key == 'S') {
    s = false;
  }
  if (key == 'd' || key == 'D') {
    d = false;
  }
  if (keyCode == ENTER) {
    mode = gameover;
  }
}

void makeRink() {
  FPoly top = new FPoly();
  FPoly bottom = new FPoly();

  top.setName("wall");
  bottom.setName("wall");

  top.vertex(0, 0);
  top.vertex(800, 0);
  top.vertex(800, 260);
  top.vertex(750, 260);
  top.vertex(750, 70);
  top.vertex(730, 50);
  top.vertex(70, 50);
  top.vertex(50, 70);
  top.vertex(50, 260);
  top.vertex(0, 260);

  bottom.vertex(0, 340);
  bottom.vertex(50, 340);
  bottom.vertex(50, 530);
  bottom.vertex(70, 550);
  bottom.vertex(730, 550);
  bottom.vertex(750, 530);
  bottom.vertex(750, 340);
  bottom.vertex(800, 340);
  bottom.vertex(800, 600);
  bottom.vertex(0, 600);

  top.setStatic(true);
  top.setFillColor(darkpurple);
  top.setFriction(0);
  top.setRestitution(1);
  top.setGrabbable(false);

  bottom.setGrabbable(false);
  bottom.setStatic(true);
  bottom.setFillColor(darkpurple);
  bottom.setRestitution(1);
  bottom.setFriction(0);

  world.add(top);
  world.add(bottom);
}

void makePuck() {
  puck = new FCircle(30);

  puck.setName("pig");
  puck.setStroke(0);
  puck.setStrokeWeight(5);
  puck.setFillColor(white);

  puck.setGrabbable(false);
  puck.setStatic(false);
  puck.setPosition(400, 300);
  puck.setDensity(0.2);
  puck.setFriction(0.2);
  puck.setRestitution(1);

  world.add(puck);
}

void makePaddle() {
  pl = new FCircle(50);
  pr = new FCircle(50);

  pl.setName("pleft");
  pr.setName("pright");

  pl.setStroke(100);
  pl.setStrokeWeight(1);
  pl.setFillColor(violet);

  pr.setStroke(0);
  pr.setStrokeWeight(1);
  pr.setFillColor(violet);

  pl.setGrabbable(false);
  pl.setStatic(false);
  pl.setPosition(200, 300);
  pl.setDensity(1);
  pl.setFriction(0);
  pl.setRestitution(1.5);

  pr.setGrabbable(false);
  pr.setStatic(false);
  pr.setPosition(600, 300);
  pr.setDensity(1);
  pr.setFriction(0);
  pr.setRestitution(1.5);

  world.add(pl);
  world.add(pr);
}

void scoring() {
  if ( puck.getX()< -10) {
    scoresound.play();
    scoresound.rewind();
    scoreright++;
    puck.setPosition(400, 300);
    puck.setVelocity(0, 0);
  }
  if (puck.getX()> 810) {
    scoresound.play();
    scoresound.rewind();
    scoreleft++;
    puck.setPosition(400, 300);
    puck.setVelocity(0, 0);
  }
  if (scoreleft==3||scoreright==3) {
    mode = gameover;
  }

  fill(black);
  textSize(36);
  text(scoreleft, 350, 50);
  text(":", 400, 50);
  text(scoreright, 450, 50);

  //pause button
  fill(white);
  stroke(white);
  strokeWeight(0);
  ellipse(750, 50, 60, 60);

  if (mode == playing) {
    fill(black);
    ellipse(740, 50, 10, 30);
    ellipse(760, 50, 10, 30);
  }
  if (mode == pausing) {
    fill(black);
    triangle(735, 30, 735, 70, 765, 50);
  }
}

void collision() {
  ArrayList<FContact> contacts = puck.getContacts();

  for (FContact c : contacts) {
    if (c.contains("pleft")) {
      oink.play();
      //oink.pause();
      oink.rewind();
      count = 90;
      postcollision = true;
    }
    if (c.contains("pright")) {
      bleat.play();
      //bleat.pause();
      bleat.rewind();
    }
    if (c.contains("wall")) {
      bounce.play();
      //bounce.pause();
      bounce.rewind();
    }
  }
}