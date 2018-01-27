class FlowCloud {

  PVector[] particlesPosition;
  PVector[] particlesVelocity;

  PVector size;
  float sizeMultiplier = 4;
  
  color[] colorPair;

  public FlowCloud(PVector _size) {
    size = _size.get();
    size.mult(sizeMultiplier);
    
    colorPair = new color[2];

    particlesPosition = new PVector[200];
    particlesVelocity = new PVector[200];


    for (int i=0; i<particlesPosition.length; i++) {
      particlesPosition[i] = new PVector(random(size.x), random(size.y), random(size.z));
      particlesVelocity[i] = new PVector(0,0, random(5,20));
    }
  }

  public void render() {
    stroke(255);
    strokeWeight(2);
    //noFill();
    //noStroke();
    
    pushMatrix();
    translate(size.x * -0.5, -size.y, size.z * -0.5);
    
    //beginShape(TRIANGLES);
    for (int i=0; i<particlesPosition.length; i++) {
      particlesPosition[i].add(particlesVelocity[i]);

      if (particlesPosition[i].z > size.z) {
        particlesPosition[i].set(random(size.x), random(size.y), 0);
      }
      
      stroke(lerpColor(colorPair[0],colorPair[1],(particlesPosition[i].z / size.z)));
      line(particlesPosition[i].x, particlesPosition[i].y, particlesPosition[i].z, particlesPosition[i].x - particlesVelocity[i].x * 5, particlesPosition[i].y - particlesVelocity[i].y* 5, particlesPosition[i].z - particlesVelocity[i].z* 5);
      //vertex(particlesPosition[i].x, particlesPosition[i].y, particlesPosition[i].z);  
    }
    endShape();
    popMatrix();
  }
  
  void setColorPair(color c1, color c2){
    colorPair[0] = c1;
    colorPair[1] = c2;
  }
}