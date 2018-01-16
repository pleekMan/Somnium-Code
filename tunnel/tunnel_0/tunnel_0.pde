import peasy.test.*;
import peasy.org.apache.commons.math.*;
import peasy.*;
import peasy.org.apache.commons.math.geometry.*;
import java.util.Iterator;

PeasyCam cam;

ArrayList<PVector> nodes;

int ringPoints = 100;
float topLimit = -3000;
float bottomLimit = 100;
float ringRadius = 300;

PVector downVel;

PVector attractor;
float attractorWarpingRadius;
float attractorStrengthMin;
float attractorStrengthMax;

int elementMode = 0;

void setup() {
  size(1280, 720, P3D);
  frameRate(30);
  sphereDetail(5);
  smooth();
  strokeWeight(2);

  cam = new PeasyCam(this, 100);
  cam.setMinimumDistance(50);
  cam.setMaximumDistance(10000);
  //frustum(-10, 0, 0, 10, 10, 10000);
  cam.setActive(false);



  nodes = new ArrayList<PVector>();
  downVel = new PVector(0, 0, 20);

  attractor = new PVector();
  attractorWarpingRadius = 200;
  attractorStrengthMin = 0;
  attractorStrengthMax = 0.8;
}

void draw() {
  background(0);

  /*
  cam.beginHUD();
   fill(0,5);
   rect(0,0,width,height);
   cam.endHUD();
   */


  drawAxisGizmo(0, 0, 0, 100);

  attractor.set(mouseX - (width * 0.5), mouseY - (height * 0.5), topLimit);
  drawattractor();

  if (frameCount % 2 == 0) {
    spawnRing();
  }

  //noStroke();
  //fill(255, 127, 0);
  noFill();
  stroke(255, 127, 0);

  for (int i=0; i< nodes.size (); i++) {
    PVector thisNode = nodes.get(i);

    // move downwards
    thisNode.add(downVel);

    //WARP TO attractor
    float distanceToattractor = getDistanceTo(thisNode, attractor);
    if (distanceToattractor < attractorWarpingRadius) {
      float keepZ = thisNode.z;
      PVector toattractorVector = PVector.sub(attractor, thisNode);
      float strength = map(distanceToattractor, 0, attractorWarpingRadius, attractorStrengthMax, attractorStrengthMin);
      toattractorVector.mult(strength);
      thisNode.add(toattractorVector);
      thisNode.z = keepZ;
    }

    pushMatrix();
    //translate(thisNode.x, thisNode.y, thisNode.z);
    //point(0,0);

    if (elementMode == 0) {
      if (i >= ringPoints) {
        line(thisNode.x, thisNode.y, thisNode.z, nodes.get(i - ringPoints).x, nodes.get(i - ringPoints).y, nodes.get(i - ringPoints).z);
      }
    } else if (elementMode == 1) {
      //if (i % ringPoints != 0 ) {
      if (i > ringPoints ) {
        line(thisNode.x, thisNode.y, thisNode.z, nodes.get(i-1).x, nodes.get(i-1).y, nodes.get(i-1).z);
      }
    }

    popMatrix();
  }

  deleteRings();




  cam.beginHUD();
  fill(255, 255, 0);
  text("Cantidad de nodos: " + nodes.size(), 20, 20);
  text("FR: " + frameRate, 20, 50);
  cam.endHUD();
}

void spawnRing() {

  for (int i=0; i< ringPoints; i++) {
    float x = ringRadius * cos((TWO_PI / ringPoints) * i);    
    float y = ringRadius * sin((TWO_PI / ringPoints) * i);
    float z = topLimit;

    PVector newPoint = new PVector(x, y, z);
    nodes.add(newPoint);
  }
}

void deleteRings() {

  Iterator nodeIterator = nodes.iterator();
  while (nodeIterator.hasNext ()) {
    PVector thisNode = (PVector)nodeIterator.next();
    if (thisNode.z > bottomLimit) {
      nodeIterator.remove();
    }
  }
}
void drawattractor() {
  pushMatrix();
  translate(attractor.x, attractor.y, attractor.z);

  fill(0, 255, 255);
  sphere(20);

  noFill();
  stroke(255, 255, 0);
  ellipse(0, 0, attractorWarpingRadius * 2, attractorWarpingRadius * 2);

  popMatrix();
}

float getDistanceTo(PVector pos1, PVector pos2) {
  return dist(pos1.x, pos1.y, pos1.z, pos2.x, pos2.y, pos2.z);
}

void drawAxisGizmo(float xPos, float yPos, float zPos, float gizmoSize) {

  pushMatrix();
  translate(xPos, yPos, zPos);

  noFill();
  box(gizmoSize * 0.05);

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

void keyPressed() {
  if (key == '1') {
    elementMode = 0;
  } else if (key == '2') {
    elementMode = 1;
  }
}

void mousePressed() {
}

void mouseReleased() {
}

void mouseClicked() {
}

void mouseDragged() {
  /*
  if (mouseButton == RIGHT) {
   topLimit = map(mouseY, height, 0, -100, -5000);
   println(topLimit);
   }
   */
}

void mouseWheel(MouseEvent event) {
  //float e = event.getAmount();
  //println(e);
}
