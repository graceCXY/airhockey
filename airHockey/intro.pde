void drawIntro() {
  //background(lavender);
  image(gameovercloud,0,0,800,600);

  textSize(72);
  fill(black);
  text("Air Hockey", 400, 300);

  textSize(36);
  fill(violet);
  strokeWeight(40);
  text("Click to Start", 400, 380);
  textAlign(CENTER);
}