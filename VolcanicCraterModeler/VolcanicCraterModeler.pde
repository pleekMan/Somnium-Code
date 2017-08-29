import peasy.org.apache.commons.math.*;
import peasy.*;
import peasy.org.apache.commons.math.geometry.*;

//Arraylist<Crater> craters;
PeasyCam camera;

Crater crater;

void setup() {
  size(1000, 500, P3D);

  camera = new PeasyCam(this, 500);
  camera.setMinimumDistance(25);
  camera.setMaximumDistance(2000);

  crater = new Crater();
}


void draw() {
  background(0);

  crater.render();
  //noLoop();
}