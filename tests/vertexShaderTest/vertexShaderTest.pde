import peasy.*;
import peasy.org.apache.commons.math.*;
import peasy.org.apache.commons.math.geometry.*;

PeasyCam cam;

PVector node;
float nodeOsc;
PShader shader;

void setup() {
  size(500, 500, P3D);
  fill(127);
  stroke(0, 200, 127);
  //noStroke();

  cam = new PeasyCam(this, 500);
  cam.setMinimumDistance(200);
  cam.setMaximumDistance(3000);

  shader = loadShader("fragShader.glsl", "vertShader.glsl");

  node = new PVector(0, 0, 50);
}

void draw() {
  background(0);


  node.x = map(sin(nodeOsc), -1, 1, 0, 100);
  nodeOsc += 0.01;

  shader.set("resolution", (float)width, (float)height);
  shader.set("nodePos", node);
  shader(shader);

  pushMatrix();
  translate(node.x, node.y, node.z);
  fill(0, 0, 255);
  sphere(10);
  popMatrix();




  for (int z=0; z < 10; z++) {
    float zPos = z * 10;

    beginShape(QUADS);
    //fill((z / 10.0) * 255,(z / 10.0) * 255,0);
    fill(255);
    for (int x=0; x < 10; x++) {
      float xPos = x * 10;

      vertex(xPos, 0, zPos);
      vertex(xPos + 10, 0, zPos);
      vertex(xPos + 10, 0, zPos + 10);
      vertex(xPos, 0, zPos + 10);
    }
    endShape();
  }
}