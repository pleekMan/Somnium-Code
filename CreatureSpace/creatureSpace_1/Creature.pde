class Creature {

  PVector position;
  PVector velocity;
  PVector rotation;

  int skinType;
  color color1;
  color color2;

  PVector headPos;

  //PVector size;

  int bodyResRadial = 10;
  int bodyResAlong = 20;
  float radiusMax = 50;
  float radiusMin = 10;
  float tall = 300;

  // INTERACTIVITY & TRIGGERS  
  float radiusMaxMultiplier = 1;
  float spikesLengthMultiplier = 1;
  float spikesWidthMultiplier = 1;
  float opacityMultiplier = 1;
  float swimMultiplier = 1;


  float radiusOsc = random(100);
  float radiusOscIncrement = random(0.1);

  float waveOscX = random(10);
  float waveOscY = random(10);
  float waveIncrement = random(0.3);

  Head head;

  public Creature() {

    position = new PVector();
    headPos = new PVector();

    skinType = 0;

    tall = random(100, 500);

    head = new Head();
    head.setFaceSize(radiusMax);
  } 

  public void render() {
    pushStyle();
    sphereDetail(5);
    //stroke(255,0,0);
    //strokeWeight(4);
    noStroke();

    // INTERACTIVITY & TRIGGERS  
    radiusMaxMultiplier *= 0.95;
    radiusMaxMultiplier = constrain(radiusMaxMultiplier, 1, 999);

    spikesWidthMultiplier *= 0.9;
    spikesWidthMultiplier = constrain(spikesWidthMultiplier, 1, 100);

    swimMultiplier *= 0.99;
    swimMultiplier = constrain(swimMultiplier, 1, 20);


    pushMatrix();

    // GLOBAL CREATURE TRANSLATION, LIKE SWIMMING IN WAVES
    float xSwim = map(sin((radiusOsc * swimMultiplier) * 0.2), -1, 1, -100, 100);
    float ySwim = map(cos((radiusOsc * swimMultiplier) * 0.2), -1, 1, -100, 100) * 1.3;
    //float zSwim = xSwim * ySwim * 0.2;
    float zSwim = sin(waveOscX * 0.2) * 200;

    translate(position.x + xSwim, position.y + ySwim, position.z + zSwim);

    // HEAD
    head.setPosition(new PVector());
    head.render();

    //noStroke();
    //fill(255);
    //sphere(30);

    scale(1, 1, 1 + (abs(xSwim) * 0.05)); // ABS creates a pulling gesture in the creatures

    //translate(position.x, position.y, position.z);

    for (int z=0; z<bodyResAlong - 1; z++) {
      float zPos = (tall / bodyResAlong) * z;// + position.z
      float zPosNext = (tall / bodyResAlong) * (z+1);// + position.z


      float ringOscillation = sin(radiusOsc + (zPos * -0.05));
      float ringOscillationNext = sin(radiusOsc + (zPosNext * -0.05));

      //float ringOscillation2 = cos((radiusOsc * 1.2) + (zPos * -0.05));

      float nowRadius = map(ringOscillation, -1, 1, radiusMin, radiusMax) * radiusMaxMultiplier;
      float nowRadiusNext = map(ringOscillationNext, -1, 1, radiusMin, radiusMax * 1.2) * radiusMaxMultiplier;


      color c = lerpColor(color1, color2, z / (float)bodyResAlong);
      //fill(c, ((ringOscillation + 1) * 0.5) * 255);
      //stroke(c, 255);

      // SHIFT EACH RING OVER A WAVE
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
        fill(c, (((ringOscillation + 1) * 0.5) * 255) * opacityMultiplier);

        drawSkin(skinType, x, y, x1, y1, x2, y2, x3, y3, zPos, zPosNext);


        stroke((ringOscillation + 1)  * 255);
        drawSpikes(x, y, zPos, x1, y1, zPos, x2, y2, zPosNext);
      }

      popMatrix();
    }

    popMatrix();

    radiusOsc += radiusOscIncrement;
    waveOscX += waveIncrement;
    waveOscY += waveIncrement;
    
    popStyle();
  }

  void drawSkin(int skinType, float x, float y, float x1, float y1, float x2, float y2, float x3, float y3, float zPos, float zPosNext) {

    if (skinType == 0) {
      beginShape(QUADS);
      vertex(x, y, zPos);
      vertex(x1, y1, zPos);
      vertex(x2, y2, zPosNext);
      vertex(x3, y3, zPosNext);
      endShape();
    } else if (skinType == 1) {
      beginShape(TRIANGLE_FAN);
      vertex(x, y, zPos);
      vertex(x1, y1, zPos);
      vertex(x2, y2, zPosNext);
      endShape();
    }
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
    head.setFaceSize(radiusMax);
  }

  public void drawSpikes(float x1, float y1, float z1, float x2, float y2, float z2, float x3, float y3, float z3) {
    // THE SPIKES ARE THE QUAD NORMALS
    PVector side1 = new PVector(x2 - x1, y2 - y1, z2 - z1);
    PVector side2 = new PVector(x3 - x1, y3 - y1, z3 - z1);

    side1.normalize();
    side2.normalize();

    PVector normalVector = side1.cross(side2);
    normalVector.mult(50 * spikesLengthMultiplier);

    strokeWeight(spikesWidthMultiplier);
    line(x1, y1, z1, normalVector.x + x1, normalVector.y + y1, normalVector.z + z1);
    strokeWeight(1);
  }

  public void setSkinType(int type) {
    skinType = type;
  }

  public void setColors(color c1, color c2) {
    color1 = c1;
    color2 = c2;
  }
}
