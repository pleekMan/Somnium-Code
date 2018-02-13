import peasy.*;

PeasyCam cam;

Stripe stripe;

PImage water;

void setup() {
  size(800, 800, P3D); 
  textureMode(NORMAL);
  
  cam = new PeasyCam(this, 3000);
  cam.setMinimumDistance(20);
  cam.setMaximumDistance(5000);

  water = loadImage("water_0.jpg");

  stripe = new Stripe();
  stripe.setTexture(water);
}


void draw() {
  background(50);

  drawAxisGizmo(0, 0, 0, 400);
  stripe.update();
  stripe.render();
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