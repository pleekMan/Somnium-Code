PShader vertexShader;

void setup() {
  size(800, 600, P3D);

  vertexShader = loadShader("frag.glsl", "vert.glsl");
  shader(vertexShader); 
  noStroke();
}

void draw() {
  background(0);
  fill(255, 255*0.5, 0);

  vertexShader.set("mouseX", map(mouseX, 0, width, 0, 100));

  beginShape(TRIANGLE_STRIP);

  for (int i =0; i <11; i ++) {
    float startX = width/2 - 200;
    float startY =  height/4;
    int triangleHeight = 20;
    vertex(startX, startY + (i * triangleHeight), (i * triangleHeight));
    vertex(startX + 400, startY + (i* triangleHeight ), (i * triangleHeight));
  }
  endShape(CLOSE);

}
