class Crater {

  PVector[] craterVertices;
  float outerPlateauStart, outerPlateauEnd;
  float outerRampStart, outerRampEnd;
  float innerRampStart, innerRampEnd;
  float innerPlateauStart, innerPlateauEnd;

  PVector center;
  float heightMultiplier;
  float widthMultiplier;
  float underGroundLevel;

  Crater() {

    center = new PVector(0,height * 0.5,0);
    craterVertices = new PVector[100];
    for(int i=0; i<craterVertices.length; i++){
     craterVertices[i] = new PVector( i / float(craterVertices.length), 0,0); 
    }

    innerPlateauStart = 0;
    innerRampStart = 0.2;
    outerRampStart = 0.3;
    outerPlateauStart = 0.9;

    heightMultiplier = 100;
    widthMultiplier = 600;
    underGroundLevel = -0.4;
  }

  void generateProfile() {

    innerRampStart = mouseX / float(width);
    outerRampStart = innerRampStart + 0.1;
    
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
      float vertexY = pow( map(i, innerRampVertexStart, innerRampVertexEnd, 0, 1), 3);
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

    pushMatrix();
    translate(center.x, center.y);
    for (int i=0; i < craterVertices.length; i++) {
      float x = craterVertices[i].x * widthMultiplier;
      float y =  craterVertices[i].y * -heightMultiplier;
      ellipse(x, y, 3, 3);

      //println("|" + i + "| X: " + x + " | Y: " + y);
    }
    
    popMatrix();
  }
}

