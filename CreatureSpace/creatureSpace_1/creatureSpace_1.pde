import peasy.*;

PeasyCam cam;

float seaSize = 1000;
float creatureCount = 20;
Creature bicho;

FlowCloud seaFlow;
Surface moonSurface;

ArrayList<Creature> bichos;
int bichosStartCounter = 0;

color colorPairs[][];

// INTERACTIVITY AND TRIGGERS
boolean enableColorDimer = false;
boolean enableSpikesLength = false;

void setup() {
  size(800, 800, P3D);
  frameRate(30);
  cam = new PeasyCam(this, 3000);
  cam.setMinimumDistance(20);
  cam.setMaximumDistance(5000);

  generateColorPairs();

  // EL BICHO CENTRAL, EL PRIMERO

  bicho = new Creature();
  bicho.setPosition(new PVector());
  bicho.setOscillation(random(100), random(0.1));
  bicho.setSize(random(10, 20), random(21, 100));
  bicho.setSkinType(floor(random(2.99)));
  int randomColorPair = floor(random(colorPairs.length));
  bicho.setColors(colorPairs[randomColorPair][0], colorPairs[randomColorPair][1]);
  //println("-|| Color Pair: " + randomColorPair);


  bichos = new ArrayList<Creature>();

  for (int i=0; i<creatureCount; i++) {
    PVector spawnPosition = new PVector(random(-seaSize, seaSize), random(-seaSize * 0.1, seaSize * 0.1), random(-seaSize, seaSize));

    Creature newBicho = new Creature();
    newBicho.setPosition(spawnPosition);
    newBicho.setOscillation(random(100), random(0.1));
    newBicho.setSize(random(10, 20), random(21, 100));
    newBicho.setSkinType(0);
    randomColorPair = floor(random(colorPairs.length));
    newBicho.setColors(colorPairs[randomColorPair][0], colorPairs[randomColorPair][1]);

    bichos.add(newBicho);
  }

  setPrimaryBicho();

  seaFlow = new FlowCloud(new PVector(seaSize, seaSize, seaSize));
  seaFlow.setColorPair(colorPairs[0][0], colorPairs[0][1]);

  moonSurface = new Surface(seaSize);
}

void draw() {
  background(0);

  /*
  cam.beginHUD();
   fill(255, 255, 0);
   drawMouseCoordinates();  
   fill(0, 3);
   rect(0, 0, width, height);
   println(frameRate);
   cam.endHUD();
   */

  // INTERACTIVITY AND TRIGGERS. Also at keyPressed
  if (enableColorDimer) {
    for (int i=0; i<bichos.size (); i++) {
      bichos.get(i).opacityMultiplier = map(mouseY, height, 0, 0, 1);
    }
  }
  if (enableSpikesLength) {
    for (int i=0; i<bichos.size (); i++) {
      bichos.get(i).spikesLengthMultiplier = map(mouseY, height, 0, 0, 5);
    }
  }

  //drawAxisGizmo(0, 0, 0, 100);

  tint(map(mouseY, height, 0, 0, 255));
  moonSurface.render();
  seaFlow.render();

  tint(255);

  bicho.render();

  pushMatrix();
  translate(0, 0, -seaSize);
  for (int i=0; i<bichos.size (); i++) {
    bichos.get(i).update();
    bichos.get(i).render();
  }
  popMatrix();


  //drawGroundPlane();
  //drawSceneBoundingBox();
}

public void generateColorPairs() {
  colorPairs = new color[4][2];

  colorPairs[0][0] = color(200, 200, 0);
  colorPairs[0][1] = color(0, 200, 200);
  colorPairs[1][0] = color(200, 30, 0);
  colorPairs[1][1] = color(255, 240, 0);
  colorPairs[2][0] = color(0, 127, 255);
  colorPairs[2][1] = color(255, 0, 160);
  colorPairs[3][0] = color(235, 0, 200);
  colorPairs[3][1] = color(120, 255, 167);
}

public void setPrimaryBicho() {


  Creature firstBicho = bichos.get(0);
  firstBicho.setPosition(new PVector());
  firstBicho.setOscillation(random(10), 0.05);
  firstBicho.setSize(15, 80);
  firstBicho.setSkinType(0);
  int randomColorPair = floor(random(colorPairs.length));
  firstBicho.setColors(colorPairs[randomColorPair][0], colorPairs[randomColorPair][1]);
  firstBicho.trigger();
}

void drawGroundPlane() {
  // GROUND PLANE

  pushMatrix();
  translate(0, seaSize*0.6, 0);
  rotateX(HALF_PI);
  rectMode(CENTER);
  fill(0);
  rect(0, 0, seaSize * 10, seaSize * 10);
  popMatrix();
}

void drawSceneBoundingBox() {
  // SCENE BOUNDING BOX
  noFill();
  stroke(50);
  box(seaSize * 2);
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

  if (key == 'f') {
    bichos.get(floor(random(bichos.size()))).radiusMaxMultiplier = random(8, 15);
  }

  if (key == 's') {
    for (int i=0; i<bichos.size (); i++) {    
      bichos.get(i).spikesWidthMultiplier = 50;
    }
  }

  if (key == 'c') {
    enableColorDimer = !enableColorDimer;
  }
  if (key == 'x') {
    enableSpikesLength = !enableSpikesLength;
  }

  if (key == 'w') {
    int randomBicho = floor(random(bichos.size()));
    bichos.get(randomBicho).swimMultiplier = 5;
    bichos.get(randomBicho).radiusMaxMultiplier = random(8, 15);
  }

  if (key == 'p') {
    int randomColor = floor(random(colorPairs.length * 2));
    color selected = colorPairs[floor(randomColor * 0.5)][randomColor % 2];
    seaFlow.setColorPair(seaFlow.colorPair[1], selected);
  }

  if (key == ' ') {
    bichos.get(bichosStartCounter % bichos.size()).trigger();
    bichosStartCounter++;
  }

  if (key == '3') {
    moonSurface.trigger();
  }
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