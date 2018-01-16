class Creature {

  PVector position;
  PVector velocity;
  PVector rotation;

  //PVector size;

  int bodyResRadial = 10;
  int bodyResAlong = 20;
  float radiusMax = 50;
  float radiusMin = 10;
  float tall = 300;

  float radiusOsc = random(100);
  float radiusOscIncrement = random(0.1);

  float waveOscX = random(10);
  float waveOscY = random(10);
  float waveIncrement = random(0.3);

  public Creature() {

    position = new PVector();
  } 

  public void render() {

    //stroke(255,0,0);
    //strokeWeight(4);
    noStroke();

    pushMatrix();

    float xSwim = map(sin(radiusOsc * 0.2), -1, 1, -50, 50);
    float ySwim = map(cos(radiusOsc * 0.2), -1, 1, -50, 50) * 1.5;
    float zSwim = xSwim * ySwim * 0.2;


    translate(position.x + xSwim, position.y + ySwim, position.z + zSwim);
    scale(1, 1, 1 + (abs(xSwim) * 0.05)); // ABS creates a pulling gesture in the creatures

    //translate(position.x, position.y, position.z);

    for (int z=0; z<bodyResAlong - 1; z++) {
      float zPos = (tall / bodyResAlong) * z;// + position.z
      float zPosNext = (tall / bodyResAlong) * (z+1);// + position.z


      float ringOscillation = sin(radiusOsc + (zPos * -0.05));
      float ringOscillationNext = sin(radiusOsc + (zPosNext * -0.05));

      //float ringOscillation2 = cos((radiusOsc * 1.2) + (zPos * -0.05));

      float nowRadius = map(ringOscillation, -1, 1, radiusMin, radiusMax);
      float nowRadiusNext = map(ringOscillationNext, -1, 1, radiusMin, radiusMax * 1.2);


      color c = lerpColor(color(200, 200, 0), color(0, 200, 200), z / (float)bodyResAlong);
      //fill(c, ((ringOscillation + 1) * 0.5) * 255);
      //stroke(c, 255);


      float waveShiftX = sin(waveOscX + (waveIncrement * z)) * 20;
      float waveShiftY = cos(waveOscY + (waveIncrement * z)) * 20;

      pushMatrix();
      translate(waveShiftX, waveShiftY);


      for (int j=0; j<bodyResRadial; j++) {
        float x = nowRadius * (cos((TWO_PI / bodyResRadial) * j));
        float y = nowRadius * (sin((TWO_PI / bodyResRadial) * j));
        float x1 = nowRadius * (cos((TWO_PI / bodyResRadial) * (j+1)));
        float y1 = nowRadius * (sin((TWO_PI / bodyResRadial) * (j+1)));
        float x2 = nowRadiusNext * (cos((TWO_PI / bodyResRadial) * (j+1)));
        float y2 = nowRadiusNext * (sin((TWO_PI / bodyResRadial) * (j+1)));
        float x3 = nowRadiusNext * (cos((TWO_PI / bodyResRadial) * j));
        float y3 = nowRadiusNext * (sin((TWO_PI / bodyResRadial) * j));

        noStroke();
        fill(c, ((ringOscillation + 1) * 0.5) * 255);

        beginShape(QUADS);
        vertex(x, y, zPos);
        vertex(x1, y1, zPos);
        vertex(x2, y2, zPosNext);
        vertex(x3, y3, zPosNext);
        endShape();

        stroke((ringOscillation + 1)  * 255);
        drawSpikes(x, y, zPos, x1, y1, zPos, x2, y2, zPosNext);
      }

      popMatrix();
    }

    popMatrix();

    radiusOsc += radiusOscIncrement;
    waveOscX += waveIncrement;
    waveOscY += waveIncrement;
  }

  public void setPosition(PVector pos) {
    position.set(pos);
  }

  public void setOscillation(float seed, float oscVelocity) {
    radiusOsc = seed;
    radiusOscIncrement = oscVelocity;
  }

  public void setSize(float minRadius, float maxRadius) {
    radiusMin = minRadius;
    radiusMax = maxRadius;
  }

  public void drawSpikes(float x1, float y1, float z1, float x2, float y2, float z2, float x3, float y3, float z3) {
    // THE SPIKES ARE THE QUAD NORMALS
    PVector side1 = new PVector(x2 - x1, y2 - y1, z2 - z1);
    PVector side2 = new PVector(x3 - x1, y3 - y1, z3 - z1);

    side1.normalize();
    side2.normalize();

    PVector normalVector = side1.cross(side2);
    normalVector.mult(50);

    line(x1, y1, z1, normalVector.x + x1, normalVector.y + y1, normalVector.z + z1);
  }
}
