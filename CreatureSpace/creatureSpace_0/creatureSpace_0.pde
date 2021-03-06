import peasy.*;

PeasyCam cam;

float seaSize = 1000;
Creature bicho;

FlowCloud seaFlow;

ArrayList<Creature> bichos;

color colorPairs[][];

void setup() {
  size(800, 800, P3D);
  //frameRate(2);
  cam = new PeasyCam(this, 500);
  cam.setMinimumDistance(20);
  cam.setMaximumDistance(5000);

  generateColorPairs();

  bicho = new Creature();

  bichos = new ArrayList<Creature>();

  for (int i=0; i<5; i++) {
    PVector spawnPosition = new PVector(random(-seaSize, seaSize), random(-seaSize, seaSize), random(-seaSize, seaSize));

    Creature newBicho = new Creature();
    newBicho.setPosition(spawnPosition);
    newBicho.setOscillation(random(100), random(0.1));
    newBicho.setSize(random(10, 20), random(21, 100));
    newBicho.setSkinType(floor(random(2.99)));
    int randomColorPair = floor(random(colorPairs.length));
    newBicho.setColors(colorPairs[randomColorPair][0], colorPairs[randomColorPair][1]);
    bichos.add(newBicho);
  }

  seaFlow = new FlowCloud(new PVector(seaSize, seaSize, seaSize));
}

void draw() {
  background(0);

  /*
  cam.beginHUD();
   fill(255, 255, 0);
   drawMouseCoordinates();  
   fill(0,3);
   rect(0,0,width, height);
   cam.endHUD();
   */

  drawAxisGizmo(0, 0, 0, 100);

  bicho.render();

  for (int i=0; i<bichos.size (); i++) {    
    bichos.get(i).render();
  }

  seaFlow.render();
}

public void generateColorPairs() {
  colorPairs = new color[4][2];

  colorPairs[0][0] = color(200, 200, 0);
  colorPairs[0][1] = color(0, 200, 200);
  colorPairs[1][0] = color(200, 30, 0);
  colorPairs[1][1] = color(255, 240, 0);
  colorPairs[2][0] = color(0,127,255);
  colorPairs[2][1] = color(255,0,160);
  colorPairs[3][0] = color(235, 0,200);
  colorPairs[3][1] = color(120,255,167);
}


public void drawAxisGizmo(PVector position, float size) {
  drawAxisGizmo(position.x, position.y, position.z, size);
}

public void drawAxisGizmo(float xPos, float yPos, float zPos, float gizmoSize) {

  strokeWeight(1);

  pushMatrix();
  translate(xPos, yPos, zPos);

  noFill();
  box(gizmoSize * 0.05f);

  // X
  fill(255, 0, 0);
  stroke(255, 0, 0);
  line(0, 0, 0, gizmoSize, 0, 0);
  // box(100);

  // Y
  fill(0, 255, 0);
  stroke(0, 255, 0);
  line(0, 0, 0, 0, gizmoSize, 0);

  // Z
  fill(0, 0, 255);
  stroke(0, 0, 255);
  line(0, 0, 0, 0, 0, gizmoSize);

  popMatrix();
}

public void drawMouseCoordinates() {
  // MOUSE POSITION
  fill(255, 255, 0);
  text("FR: " + frameRate, 20, 20);
  text("X: " + mouseX + " | Y: " + mouseY, mouseX, mouseY);
}

void keyPressed() {
}

void mousePressed() {
}

void mouseReleased() {
}

void mouseClicked() {
}

void mouseDragged() {
}

void mouseWheel(MouseEvent event) {
  //float e = event.getAmount();
  //println(e);
}
