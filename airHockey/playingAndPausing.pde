void drawThings(){
   background(lavender);
    if (w == true) {
      vyl = -275;
    }else
    if (s == true) {
      vyl = 275;
    }else {
      vyl = 0;
    }
    if (a == true) {
      vxl = -275;
    }else
    if (d == true) {
      vxl = 275;
    }else{
      vxl = 0;
    }
    pl.setVelocity(vxl, vyl);
    if (up == true) {
      vyr = -275;
    }else
    if (down == true) {
      vyr = 275;
    }else{
      vyr = 0;
    }
    if (left == true) {
      vxr = -275;
    }else
    if (right == true) {
      vxr = 275;
    }else{
      vxr = 0;
    }
    pr.setVelocity(vxr, vyr);
    
    //pause button
    fill(white);
    stroke(white);
    strokeWeight(0);
    ellipse(750,50,40,40);
    
}

void moveThings(){
  
}