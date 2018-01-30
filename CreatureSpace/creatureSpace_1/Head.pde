class Head {

  PVector pos;
  int iterations;
  int startCount;

  float faceSize;
  int faceVertices;
  int faceSkins;
  float faceRotation;
  float faceRotationVel;

  Antennae antennae;
  int antennaeCount;

  float alphaMultiplier = 0;

  public Head() {

    pos = new PVector();
    iterations = 3;
    startCount = floor(random(5));

    faceVertices = floor(random(3, 8));
    faceSkins = 5;
    faceRotation = 0;
    faceRotationVel = random(0.05);
    faceSize = 50;

    antennae = new Antennae();
    antennaeCount = floor(random(10, 30));
  }

  void render() {

    pushMatrix();

    translate(pos.x, pos.y, pos.z);

    noStroke();
    //eyes(startCount, 100, pos, 0);
    drawAntennae();
    ball();

    popMatrix();
  }

  void ball() {

    //noStroke();
    noFill();

    pushMatrix();

    float rotationUnit = TWO_PI / (faceSkins * 2);

    translate(pos.x, pos.y, pos.z+ (200 * tan(faceRotation)));

    for (int s=0; s<faceSkins; s++) {

      pushMatrix();
      rotateY(faceRotation + (s * rotationUnit));

      float vertexUnit = TWO_PI / faceVertices;

      //fill(255 * (s / (float)faceSkins * 2),0,0);
      stroke((255 * (s / (float)faceSkins * 2)) * alphaMultiplier, 0, 0);

      beginShape();
      for (int v=0; v<faceVertices; v++) {

        float x = faceSize * cos(vertexUnit * v);
        float y = faceSize * sin(vertexUnit * v);

        //vertex(x, y, pos.z + (200 * sin(faceRotation))); // HACE COMO UN PARAPENTE
        vertex(x, y, pos.z);
      }

      endShape(CLOSE);

      popMatrix();
    }

    popMatrix();

    faceRotation += faceRotationVel;
  }

  void drawAntennae() {

    float rotationUnit = TWO_PI / (float)antennaeCount;
    pushMatrix();
    scale(1, 1, 0.3);
    rotateZ(faceRotation);

    for (int i=0; i<antennaeCount; i++) {

      pushMatrix();
      rotateZ(rotationUnit * i);

      antennae.render();

      popMatrix();
    }

    popMatrix();
  }

  void eyes(int count, float radius, PVector pos, int iter) {
    // RECURSIVE FUNCTION, WATCH OUT..!!

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
        ellipse(0, 0, radius, radius);
        //sphere(radius);
        popMatrix();

        //println(iter);
        int newIter = iter + 1;
        eyes(count * 2, radius * 0.5, PVector.add(newPos, new PVector(0, 0, -radius * 2)), newIter);
      }
    }
  }



  void setPosition(PVector _pos) {
    pos = _pos;
  }

  void setFaceSize(float _s) {
    faceSize = _s * 0.5;
  }

  void setOpacity(float value) {
    alphaMultiplier = value;
    antennae.setOpacity(alphaMultiplier);
  }
}