class Head {

  PVector pos;
  int iterations;
  int startCount;

  public Head() {

    pos = new PVector();
    iterations = 3;
    startCount = floor(random(5));
  }

  void render() {

    pushMatrix();

    translate(pos.x, pos.y, pos.z);

    noStroke();
    eyes(startCount, 100, pos, 0);

    popMatrix();
  }

  void eyes(int count, float radius, PVector pos, int iter) {

    if (iter < iterations) {

      float xPos = 0;
      float yPos = 0;

      float angleSeparation = TWO_PI / count;

      PVector newPos = new PVector();
      
      fill(50 + (iter * 50) );
      
      for (int i=0; i<count; i++) {
        xPos = radius * cos((angleSeparation * i));
        yPos = radius * sin((angleSeparation * i));

        newPos.set(xPos, yPos, pos.z);

        pushMatrix();
        translate(newPos.x, newPos.y, newPos.z);
        ellipse(0,0,radius,radius);
        //sphere(radius);
        popMatrix();

        //println(iter);
        int newIter = iter + 1;
        eyes(count * 2, radius * 0.5, PVector.add(newPos,new PVector(0,0,-radius * 2)), newIter);
        
      }
    }
  }

  void setPosition(PVector _pos) {
    pos = _pos;
  }
}
