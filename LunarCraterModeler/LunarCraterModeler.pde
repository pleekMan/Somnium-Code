
Crater crater;

void setup(){
  size(800,500);
  noStroke();
  fill(255,255,0);
  
  crater = new Crater();
}

void draw(){
  background(0);
  
  crater.generateProfile();
  crater.render();
  
  //noLoop();
}

void keyPressed(){
  
}

void mousePressed(){
  
}

void mouseReleased(){
  
}

void mouseClicked(){
  
}

void mouseDragged(){
  
}

void mouseWheel(MouseEvent event) {
  //float e = event.getAmount();
  //println(e);
}
