import peasy.test.*;
import peasy.org.apache.commons.math.*;
import peasy.*;
import peasy.org.apache.commons.math.geometry.*;

PeasyCam cam;
Dodecahedron dode;
OctahedronFlat octa;

void setup() {
  size(500, 500, P3D);

  cam = new PeasyCam(this, 500);
  cam.setMinimumDistance(50);
  cam.setMaximumDistance(3000);

  dode = new Dodecahedron();
  octa = new OctahedronFlat();
}

void draw() {
  background(0);

  drawAxisGizmo();

  //scale(((float)mouseX/width) * 30);

  //dode.setRadius(mouseX);
  //dode.update();
  //dode.render();
  
  octa.render();
}

void drawMouseCoordinates() {
  // MOUSE POSITION
  fill(255, 0, 0);
  text("FR: " + frameRate, 20, 20);
  text("X: " + mouseX + " / Y: " + mouseY, mouseX, mouseY);
}

void drawAxisGizmo() {

  pushMatrix();
  //translate(translacionGlobal.x, translacionGlobal.y, translacionGlobal.z);

  noFill();
  box(10);

  // X
  fill(255, 0, 0);
  stroke(255, 0, 0);
  line(0, 0, 0, 200, 0, 0);
  // box(100);

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


void keyPressed() {
  if (key == 'q') {
    dode.setRadius(dode.getRadius() +10);
  }
  if (key == 'a') {
    dode.setRadius(dode.getRadius() - 10);
  }
}

void mousePressed() {
}

void mouseReleased() {
}

void mouseClicked() {
}

void mouseDragged() {
  if (mouseButton == LEFT) {
    //dode.multA((float) width/mouseX);
  }
}

void mouseWheel(MouseEvent event) {
  //float e = event.getAmount();
  //println(e);
}
