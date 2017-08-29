import damkjer.ocd.*;
/*
import peasy.org.apache.commons.math.*;
 import peasy.*;
 import peasy.org.apache.commons.math.geometry.*;
 
 PeasyCam camera;
 */

Camera camera;
PVector cameraVel;

ArrayList<Crater> craters;
boolean enableCameraControl;

void setup() {
  size(1000, 500, P3D);
  noStroke();
  fill(255, 255, 0);
  strokeWeight(2);

  camera = new Camera(this, 0, -50, 0);
  camera.jump(0, -50, 100);
  camera.aim(0, -50, -1000);

  //camera.zoom(HALF_PI);

  cameraVel = new PVector(0, 0, -0.3);

  /*
  camera = new PeasyCam(this, 500);
   camera.setMinimumDistance(25);
   camera.setMaximumDistance(2000);
   camera.setSuppressRollRotationMode();
   camera.lookAt(0,-100,-2000, 100000);
   camera.setPosition(0,0,0);
   `*/
  craters = new ArrayList<Crater>();

  for (int i=0; i<10; i++) {

    createNewCrater();
  }

  enableCameraControl = true;
}

void draw() {
  background(0);
  lights();

  camera.dolly(cameraVel.z);

  for (int i=0; i < craters.size (); i++) {
    craters.get(i).render();
  }

  //drawGround();
  drawAxisGizmo();

  camera.feed();
}

void keyPressed() {
  if (key == ' ') {
    enableCameraControl = !enableCameraControl;
    //camera.setActive(enableCameraControl);
  }
}

void mousePressed() {
}

void mouseReleased() {
}

void mouseClicked() {
}

void mouseDragged() {

  //craters.get(0).setCenter(craters.get(0).center.x, craters.get(0).center.y, (mouseY * 10) - 500);

  camera.zoom(radians(mouseY - pmouseY) / 2.0);
}

void createNewCrater() {
  Crater crater = new Crater();

  crater.setCenter(random(-1000, 1000), 0, random(-1000, 0));
  crater.setStages(random(0, 0.25), random(0.25, 0.5), random(0.5, 0.75), random(0.75, 1));
  crater.setSize(random(20, 200), random(10, 20));

  craters.add(crater);
}

void drawGround() {

  noStroke();
  fill(50);
  beginShape(QUAD);
  vertex(-1000, 0, 0);
  vertex(1000, 0, 0);
  vertex(1000, 0, -2000);
  vertex(-1000, 0, -2000);
  endShape();
}


void drawAxisGizmo() {

  pushMatrix();
  //translate(translacionGlobal.x, translacionGlobal.y, translacionGlobal.z);

  noFill();
  stroke(127);
  box(10);

  // X
  fill(255, 0, 0);
  stroke(255, 0, 0);
  line(0, 0, 0, 200, 0, 0);

  // Y
  fill(0, 255, 0);
  stroke(0, 255, 0);
  line(0, 0, 0, 0, 200, 0);

  // Z
  fill(0, 0, 255);
  stroke(0, 0, 255);
  line(0, 0, 0, 0, 0, 200);

  popMatrix();
}

