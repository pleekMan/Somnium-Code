class Stripe {

  float radius = 1000;
  float stripeWidth = radius * 0.2;

  float yRot = 0;
  float yRotVel = 0.01;
  float xRot = 0;
  float xRotVel = 0.01;

  PImage textureImage;

  public Stripe() {
  }

  public void update() {

    //xRot += xRotVel;
    yRot += yRotVel;
  }

  public void render() {

    pushMatrix();

    setRotation();

    int resAlong = 30;
    int resAcross = 6;
    //float perimeter = (radius * 2) * PI;
    float unitAlong = TWO_PI / resAlong;
    float unitAcross = stripeWidth / resAcross;

    translate(0, 0, -(stripeWidth * 0.5));

    //stroke(255, 255, 0);
    for (int i=0; i < resAlong; i++) {
      float x1 = radius * (cos(unitAlong * i));
      float x2 = radius * (cos(unitAlong * (i+1)));
      float y1 = radius * (sin(unitAlong * i));
      float y2 = radius * (sin(unitAlong * (i+1)));

      float u1 = i/(float) resAlong;
      float u2 = (i+1)/(float) resAlong;

      //fill((i/(float) resAlong) * 255, 0, 0);

      for (int j=0; j < resAcross; j++) {
        //if (j % 2 == 0) {
          float z1 = unitAcross * j;
          float z2 = unitAcross * (j+1);

          //float v1 = (stripeWidth / (radius * 2) * PI) * (j / (float) resAcross);
          //float v2 = (stripeWidth / (radius * 2) * PI) * ((j+1) / (float) resAcross);

          float v1 = j / (float) resAcross;
          float v2 = (j+1) / (float) resAcross;


          beginShape(QUADS);
          texture(textureImage);
          vertex(x1, y1, z1, u1, v1);
          vertex(x2, y2, z1, u2, v1);
          vertex(x2, y2, z2, u2, v2);
          vertex(x1, y1, z2, u1, v2);
          endShape();
        //}
      }
    }
    popMatrix();

    drawOutline();
  }

  public void setRotation() {
    rotateY(map(sin(yRot), -1, 1, -QUARTER_PI, QUARTER_PI));
    rotateX(xRot);
  }


  public void drawOutline() {

    noFill();
    stroke(34, 82, 234);
    pushMatrix();
    setRotation();

    translate(0, 0, stripeWidth * 0.5);
    ellipse(0, 0, radius * 2, radius * 2);
    translate(0, 0, -stripeWidth);
    ellipse(0, 0, radius * 2, radius * 2);
    popMatrix();
  }

  public void setTexture(PImage t) {
    textureImage = t;
  }
}