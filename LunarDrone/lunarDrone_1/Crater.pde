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
    craterVertices = new PVector[50];

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

    revolveResolution = 40;

    //generateProfile();
  }

  void setCenter(float x, float y, float z) {
    center.set(x, y, z);
  }

  void generateProfile() {
    // NOT USED (CONTRUCTED AT getShape())
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

    for (int i=outerPlateauVertexStart; i<outerPlateauVertexEnd; i++) {
      craterVertices[i].y = 0;
    }
  }

  void render() {
    // NOT USED (DIRECTLY RENDERING THE SHAPE OBJECT (WITH ALL THE CRATERS AS ADDED AS CHILDS))
    //stroke(127, 127, 255);
    //noStroke();
    fill(255, 255, 0);

    float angleUnit = TWO_PI / revolveResolution;

    pushMatrix();
    translate(center.x, center.y, center.z);

    for (int r=0; r < revolveResolution; r++) {

      pushMatrix(); 
      rotateY(angleUnit * r);

      beginShape(QUADS);

      for (int i=1; i < craterVertices.length; i++) {

        float x = craterVertices[i].x * widthMultiplier;
        float y =  craterVertices[i].y * -heightMultiplier;

        vertex(x, y);

        //fill(255, 255, 0);
        point(x, y);
        //line(x, y, x +1000, y);

        //println("|" + i + "| X: " + x + " | Y: " + y);
      }

      endShape();

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

  void setHeight(float h) {
    heightMultiplier = h;
  }
  void setRadius(float r) {
    widthMultiplier = r;
  }

  PShape getShape() {

    PShape crater = createShape();

    //noFill();
    //stroke(127, 127, 255);
    //fill(0, 127, 255);

    float angleUnit = TWO_PI / revolveResolution;
    float tinyHeightOffset = random(1); // TO AVOID Z-FIGHT ON OVERLAPPING CRATERS;

    //float randomForHeights = random(0.5);
    //float randomForHeights2 = random(0.5);

    for (int r=0; r < revolveResolution; r++) {

      crater.beginShape(QUADS);


      for (int i=1; i < craterVertices.length; i++) {

        float x = craterVertices[i].x * (cos(angleUnit * r));
        float z = craterVertices[i].x * (sin(angleUnit * r));
        float y = craterVertices[i].y;// + -randomForHeights;
        float x2 = craterVertices[i-1].x * (cos(angleUnit * r));
        float z2 = craterVertices[i-1].x * (sin(angleUnit * r));
        float y2 = craterVertices[i-1].y;// + -randomForHeights2;
        float x3 = craterVertices[i-1].x * (cos((angleUnit * r) + angleUnit));
        float z3 = craterVertices[i-1].x * (sin((angleUnit * r) + angleUnit));
        float x4 = craterVertices[i].x * (cos((angleUnit * r) + angleUnit));
        float z4 = craterVertices[i].x * (sin((angleUnit * r) + angleUnit));

        x = center.x + (x * widthMultiplier);
        z = center.z + (z * widthMultiplier);
        y = center.y + (y * -heightMultiplier) - tinyHeightOffset; 
        y2 = center.y + (y2 * -heightMultiplier) - tinyHeightOffset; 


        x2 = center.x + (x2 * widthMultiplier);
        z2 = center.z + (z2 * widthMultiplier);
        x3 = center.x + (x3 * widthMultiplier);
        z3 = center.z + (z3 * widthMultiplier);
        x4 = center.x + (x4 * widthMultiplier);
        z4 = center.z + (z4 * widthMultiplier);

        //float x = craterVertices[i].x * widthMultiplier;
        //float y =  craterVertices[i].y * -heightMultiplier;

        crater.fill(((i/(float)craterVertices.length) * 255));
        //crater.fill(i * 10);

        crater.vertex(x, y, z);
        crater.vertex(x2, y2, z2);
        crater.vertex(x3, y2, z3);
        crater.vertex(x4, y, z4);

        //println("|" + i + "| X: " + x + " | Y: " + y);
      }
      
      //randomForHeights = randomForHeights2;
      //randomForHeights2 = random(0.2);
      crater.endShape();
    }


    return crater;
  }
}