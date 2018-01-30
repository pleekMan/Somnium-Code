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

  float heightMultiplier = -1000;
  float lineLength;

  float alphaMultiplier;
  boolean starting = false;

  Surface(float sceneSize) {

    forwardLength = sceneSize * 6;
    acrossLength = sceneSize * 6;
    /*
    radius = rad;
     float centerY = 0 + radius + (radius * 0.1);
     
     center = new PVector(0, centerY, 0);
     rotation = 0;
     rotationIncrement = 0.01;
     acrossResolution = 20; // line resolution (on half sphere)
     */

    acrossNoiseStart = random(10);
    acrossNoiseEnd = acrossNoiseStart + 4;
    forwardNoiseStart = random(10);
    forwardNoiseEnd = forwardNoiseStart + 0.3;
    forwardNoiseIncrement = -0.02;

    lineLength = (forwardLength / forwardRes);
  }

  void render() {

    if (starting) {
      alphaMultiplier += 0.01;
      if (alphaMultiplier >= 1) {
        starting = false;
        alphaMultiplier = 1;
      }
    }
    //heightMultiplier = map(mouseY,height,0,0,-2000);

    //stroke(255);
    //noFill();
    //fill(255);
    noStroke();

    pushMatrix();
    translate(-(acrossLength * 0.5), -heightMultiplier, -(forwardLength * 0.5));

    for (int i=0; i < forwardRes - 1; i++) {
      float zNorm = (i / (float)forwardRes);
      float zPos = zNorm * forwardLength;

      float zNormNext = ((i+1) / (float)forwardRes);
      float zPosNext = zNormNext * forwardLength;
      //println(i + " Norm: " + zNormNext);
      //println(i + " pos: " + zPosNext);

      beginShape(TRIANGLE_STRIP);
      for (int j=0; j < acrossRes; j++) {
        float xNorm = (j / (float)acrossRes);
        float xPos = (j / (float)acrossRes) * acrossLength;

        float xInNoise = map(xNorm, 0, 1, acrossNoiseStart, acrossNoiseEnd);
        float yInNoise = map(zNorm, 0, 1, forwardNoise, forwardNoiseEnd);
        float yPos = noise(xInNoise, yInNoise) * heightMultiplier;

        float yInNoiseNext = map(zNormNext, 0, 1, forwardNoise, forwardNoiseEnd);
        float yPosNext = noise(xInNoise, yInNoiseNext) * heightMultiplier;

        // CURVATURE BEND
        float bendStrength = abs(map(xNorm, 0, 1, -1, 1)) * -1500;


        fill((255 - (zNorm * 255)) * alphaMultiplier);

        vertex(xPos, yPos + bendStrength, zPos);
        vertex(xPos, yPosNext + bendStrength, zPosNext);
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

  public void trigger() {
    starting = true;
  }
}