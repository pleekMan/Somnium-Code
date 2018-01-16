class OctahedronFlat {

  float r = 30;
  PVector center;

  OctahedronFlat() {

    center = new PVector();
  } 

  public void render() {
    fill(0,255,255);
    stroke(255,255,0);
    beginShape();
    for (int i=0; i<4; i++) {
      float x = center.x + (r * (cos(TWO_PI / 4*(i+1))));
      float y = center.y + (r * (sin(TWO_PI / 4*(i+1))));
      
      vertex(x,y,0);
      text(i,x,y);
    }
    endShape(CLOSE);
  }
}
