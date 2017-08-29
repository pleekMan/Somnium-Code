class Crater {

  PVector[] craterVertices; // ONlY PROFILE, NOT THE ENTIRE REVOLUTION
  float outerPlateauStart;
  float outerRampStart;
  float innerRampStart;
  float innerPlateauStart;

  PVector center;
  float heightMultiplier;
  float widthMultiplier;
  float underGroundLevel;

  int revolveResolution;

  Crater() {

    center = new PVector(0, height * 0.5, 0);
    craterVertices = new PVector[100];
    for (int i=0; i<craterVertices.length; i++) {
      craterVertices[i] = new PVector( i / float(craterVertices.length), 0, 0);
    }

    innerPlateauStart = 0;
    innerRampStart = 0.3;
    outerRampStart = 0.6;
    outerPlateauStart = 0.9;

    heightMultiplier = 10;
    widthMultiplier = 200;
    underGroundLevel = -0.0;

    revolveResolution = 30;

    generateProfile();
  }

  void setCenter(float x, float y, float z) {
    center.set(x, y, z);
  }

  void generateProfile() {

    //innerRampStart = mouseX / float(width);
    //outerRampStart = innerRampStart + 0.1;

    // INNER PLATEAU
    int innerPlateauVertexStart = floor(craterVertices.length * 0);
    int innerPlateauVertexEnd = floor(craterVertices.length * innerRampStart);

    for (int i=innerPlateauVertexStart; i<innerPlateauVertexEnd; i++) {
      craterVertices[i].y = underGroundLevel;
    }


    // INNER RAMP = pow(x,5);
    int innerRampVertexStart = floor(craterVertices.length * innerRampStart);
    int innerRampVertexEnd = floor(craterVertices.length * outerRampStart);

    for (int i=innerRampVertexStart; i<innerRampVertexEnd; i++) {
      float vertexY = pow( map(i, innerRampVertexStart, innerRampVertexEnd, 0, 1), 5);
      craterVertices[i].y = map(vertexY, 0, 1, underGroundLevel, 1);
      //print(map(i, innerRampVertexStart, innerRampVertexEnd, 0, 1) + " -> ");
      //println(vertexY);
    }

    // OUTER RAMP = pow(x,2);
    int outerRampVertexStart = floor(craterVertices.length * outerRampStart);
    int outerRampVertexEnd = floor(craterVertices.length * outerPlateauStart);

    for (int i=outerRampVertexStart; i<outerRampVertexEnd; i++) {
      float vertexY = pow( map(i, outerRampVertexStart, outerRampVertexEnd, 1, 0), 2);
      craterVertices[i].y = vertexY;
      //print(map(i, innerRampVertexStart, innerRampVertexEnd, 0, 1) + " -> ");
      //println(vertexY);
    }

    // OUTER PLATEAU
    int outerPlateauVertexStart = floor(craterVertices.length * outerPlateauStart);
    int outerPlateauVertexEnd = floor(craterVertices.length * 1);

    for (int i=outerPlateauVertexStart; i<outerRampVertexEnd; i++) {
      craterVertices[i].y = 0;
    }
  }

  void render() {

    //stroke(255, 255, 0);
    noStroke();
    fill(255,255,0);

    float angleUnit = TWO_PI / revolveResolution;

    pushMatrix();
    translate(center.x, center.y, center.z);

    for (int r=0; r < revolveResolution; r++) {

      pushMatrix(); 
      rotateY(angleUnit * r);

      beginShape(QUADS);

      for (int i=0; i < craterVertices.length; i++) {

        float x = craterVertices[i].x * widthMultiplier;
        float y =  craterVertices[i].y * -heightMultiplier;

        float x1 = craterVertices[(i + 1) % craterVertices.length].x * widthMultiplier;
        float y1 =  craterVertices[(i + 1) % craterVertices.length].y * -heightMultiplier;

        pushMatrix();
        rotate(angleUnit);
        float x2 = craterVertices[(i + 1) % craterVertices.length].x * widthMultiplier;
        float y2 =  craterVertices[(i + 1) % craterVertices.length].y * -heightMultiplier;

        float x3 = craterVertices[i].x * widthMultiplier;
        float y3 =  craterVertices[i].y * -heightMultiplier;
        
        vertex(x, y, 0);
        vertex(x1,y1,0);
        vertex(x2,y2,0);
        vertex(x3,y3,0);
        
        popMatrix();

        //ellipse(x, y, 3, 3);
        //stroke(255 * craterVertices[i].y, 255 - 255 * craterVertices[i].x, 0);
        //stroke(255);

        

        //println("|" + i + "| X: " + x + " | Y: " + y);
      }

      endShape(CLOSE);

      popMatrix();
    }

    popMatrix();
  }

  void setStages (float ips, float irs, float ors, float ops) {
    setInnerPlateauStart(ips);
    setInnerRampStart(irs);
    setOuterRampStart(ors);
    setOuterPlateauStart(ops);

    generateProfile();
  }

  void setInnerPlateauStart(float percentStart) {
    // percent means 0 -> 1
    innerPlateauStart = constrain(percentStart, 0 + 0.01, innerRampStart);
  }
  void setInnerRampStart(float percentStart) {
    // percent means 0 -> 1
    innerRampStart = constrain(percentStart, innerPlateauStart + 0.01, outerRampStart - 0.01);
  }
  void setOuterRampStart(float percentStart) {
    // percent means 0 -> 1
    outerRampStart = constrain(percentStart, innerRampStart + 0.01, outerPlateauStart - 0.01);
  }
  void setOuterPlateauStart(float percentStart) {
    // percent means 0 -> 1
    outerPlateauStart = constrain(percentStart, outerRampStart + 0.01, 1 - 0.01);
  }

  void setSize(float w, float h) {
    widthMultiplier = w;
    heightMultiplier = h;
  }
}

