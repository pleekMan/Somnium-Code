class Surface { //<>//

  /*
  PVector center;
   float radius;
   
   int acrossResolution;
   float rotation;
   float rotationIncrement;
   */

  float acrossNoiseStart; // noiseStart
  float acrossNoiseEnd; // noiseWidth
  float forwardNoiseStart;
  float forwardNoise;
  float forwardNoiseEnd;
  float forwardNoiseIncrement;

  int acrossRes = 50;
  int forwardRes = 100;

  float acrossLength = 3000;
  float forwardLength = 3000;

  float heightMultiplier = -800;
  float lineLength;

  Surface(float sceneSize) {

    forwardLength = sceneSize * 4;
    acrossLength = sceneSize * 4;
    /*
    radius = rad;
     float centerY = 0 + radius + (radius * 0.1);
     
     center = new PVector(0, centerY, 0);
     rotation = 0;
     rotationIncrement = 0.01;
     acrossResolution = 20; // line resolution (on half sphere)
     */

    acrossNoiseStart = random(10);
    acrossNoiseEnd = acrossNoiseStart + 3;
    forwardNoiseStart = random(10);
    forwardNoiseEnd = forwardNoiseStart + 0.5;
    forwardNoiseIncrement = -0.02;

    lineLength = (forwardLength / forwardRes);
  }

  void render() {

    stroke(255);
    noFill();

    pushMatrix();
    translate(-(acrossLength * 0.5), -heightMultiplier, -(forwardLength * 0.5));

    for (int i=0; i < forwardRes - 1; i++) {
      float zNorm = (i / (float)forwardRes);
      float zPos = zNorm * forwardLength;

      float zNormNext = ((i+1) / (float)forwardRes);
      float zPosNext = zNormNext * forwardLength;
      //println(i + " Norm: " + zNormNext);
      //println(i + " pos: " + zPosNext);

      beginShape(LINES);
      for (int j=0; j < acrossRes; j++) {
        float xNorm = (j / (float)acrossRes);
        float xPos = (j / (float)acrossRes) * acrossLength;

        float xInNoise = map(xNorm, 0, 1, acrossNoiseStart, acrossNoiseEnd);
        float yInNoise = map(zNorm, 0, 1, forwardNoise, forwardNoiseEnd);
        float yPos = noise(xInNoise, yInNoise) * heightMultiplier;

        float yInNoiseNext = map(zNormNext, 0, 1, forwardNoise, forwardNoiseEnd);
        float yPosNext = noise(xInNoise, yInNoiseNext) * heightMultiplier;


        vertex(xPos, yPos, zPos);
        vertex(xPos, yPosNext, zPosNext);
      }
      endShape();
    }

    popMatrix();


    forwardNoise += forwardNoiseIncrement;
    forwardNoiseEnd += forwardNoiseIncrement; 
    /*
    pushStyle();
     sphereDetail(40);
     
     noFill();
     stroke(0, 255, 255);
     
     pushMatrix();
     translate(center.x, center.y, center.z);
     rotateZ(HALF_PI);
     rotateY(rotation);
     
     
     
     
     //sphere(radius);
     popMatrix();
     
     popStyle();
     rotation+=rotationIncrement;
     
     */
  }
}