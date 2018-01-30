class Antennae {

  PVector[] nodes;

  float motion = 39;
  float motionIncrement = random(0.001, 0.01);
  float alphaMultiplier = 0;

  public Antennae() {

    nodes = new PVector[floor(random(5, 20))];

    nodes[0] = new PVector(0, 0, 10);

    for (int i=1; i<nodes.length; i++) {
      float x = nodes[i-1].x + random(-10, 10);
      float y = nodes[i-1].y + random(5, 20);
      float z = nodes[i-1].z * 1.3;//random(20, 10);

      nodes[i] = new PVector(x, y, z);
    }
  }

  public void render() {
    noFill();


    beginShape();
    for (int i=1; i<nodes.length; i++) {
      stroke(300 - (255 * (i / (float)nodes.length)), alphaMultiplier * 255);
      vertex(nodes[i].x + random(-10, 10), nodes[i].y  + random(-10, 10), nodes[i].z);
    }
    endShape();

    motion+=motionIncrement;
  }
  
  public void setOpacity(float value){
    alphaMultiplier = value;
  }
}