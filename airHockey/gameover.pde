void drawGameOver(){
  
  //background(orchid);
   image(introcloud,0,0,800,600);
  
  fill(white);
  textSize(72);
  text("Good Game!", 400,300);
  
  scoreleft = 0;
  scoreright = 0;
  fill(lavender);
  textSize(36);
  text("Another Round?", 400, 380);
  
  

}

void restart(){
  pl.setPosition(200, 300);
  pr.setPosition(600,300);
  
  pl.setVelocity(0,0);
  pr.setVelocity(0,0);
  
  scoreleft =0;
  scoreright = 0;
  
  puck.setPosition(400,300);
  puck.setVelocity(0,0);
  
}