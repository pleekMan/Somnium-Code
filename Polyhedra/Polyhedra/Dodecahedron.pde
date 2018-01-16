class Dodecahedron {

  float phi =  (sqrt(5) - 1) / 2;// The golden ratio
  float a = 1 / sqrt(3);
  float b = a / phi;
  float c = a * phi;
  //float r = sqrt(3);
  float r = sqrt(3) * 20;


  ArrayList<PVector> vertices;

  public Dodecahedron() {

    vertices = new ArrayList<PVector>();
    for (int i=0; i< 20; i++) {
      vertices.add(new PVector());
    }
  } 


  void update() {
    float inverses[] = {
      -1, 1
    };
    int count = 0;
    for (int i=0; i< inverses.length; i++) {
      for (int j=0; j< inverses.length; j++) {
        vertices.get(count).set(0, inverses[i] * c * r, inverses[j] * b * r);
        count++;
        vertices.get(count).set(inverses[i] * c * r, inverses[j] * b * r, 0);
        count++;
        vertices.get(count).set(inverses[i] * b * r, 0, inverses[j] * c * r);

        count++;
        for (int k=0; k<inverses.length; k++) {
          vertices.get(count).set(inverses[i] * a * r, inverses[j] * a * r, inverses[k] * a * r);
          count++;
        }
      }
    }
  }

  void render() {
    fill(255, 255, 0);
    noStroke();
    for (int i=1; i<vertices.size (); i++) {
      //int randomPoint = (int)random(vertices.size());
      //line(vertices.get(i).x,vertices.get(i).y,vertices.get(i).z,vertices.get(randomPoint).x,vertices.get(randomPoint).y,vertices.get(randomPoint).z);
      
      pushMatrix();
      translate(vertices.get(i).x, vertices.get(i).y, vertices.get(i).z);
      sphere(5);
      point(0,0);
      popMatrix();
    }
  }

  public void setRadius(float _r) {
    r = _r;
  }

  public float getRadius() {
    return r;
  }

  public void multA(float mult) {
    a = (1 / sqrt(3)) * mult;
  }
}
