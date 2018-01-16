class FlowCloud {

  PVector[] particlesPosition;
  PVector[] particlesVelocity;

  PVector size;
  float sizeMultiplier = 4;

  public FlowCloud(PVector _size) {
    size = _size.get();
    size.mult(sizeMultiplier);

    particlesPosition = new PVector[200];
    particlesVelocity = new PVector[200];


    for (int i=0; i<particlesPosition.length; i++) {
      particlesPosition[i] = new PVector(random(size.x), random(size.y), random(size.z));
      particlesVelocity[i] = new PVector(0,0, random(2,10));
    }
  }

  public void render() {
    stroke(255);
    strokeWeight(2);
    //noFill();
    //noStroke();
    
    pushMatrix();
    translate(size.x * -0.5, size.y * -0.5, size.z * -0.5);
    
    //beginShape(TRIANGLES);
    for (int i=0; i<particlesPosition.length; i++) {
      particlesPosition[i].add(particlesVelocity[i]);

      if (particlesPosition[i].z > size.z) {
        particlesPosition[i].set(random(size.x), random(size.y), 0);
      }
      line(particlesPosition[i].x, particlesPosition[i].y, particlesPosition[i].z, particlesPosition[i].x - particlesVelocity[i].x * 5, particlesPosition[i].y - particlesVelocity[i].y* 5, particlesPosition[i].z - particlesVelocity[i].z* 5);
      //vertex(particlesPosition[i].x, particlesPosition[i].y, particlesPosition[i].z);  
    }
    endShape();
    popMatrix();
  }
}
