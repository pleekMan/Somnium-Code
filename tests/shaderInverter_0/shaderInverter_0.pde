
PShader inverter;
PGraphics layer;

boolean useShader = true;

void setup() {
  size(255, 100, P2D);
  textureMode(NORMAL);

  inverter = loadShader("invert.glsl");

  layer = createGraphics(width, height);
}


void draw() {



  layer.beginDraw();
  for (int i=0; i < 256; i++) {
    layer.stroke(i); 
    layer.line(i, 0, i, 24);

    layer.stroke(i, 0, 0); 
    layer.line(i, 25, i, 49);

    layer.stroke(0, i, 0); 
    layer.line(i, 50, i, 74);

    layer.stroke(0, 0, i); 
    layer.line(i, 75, i, 100);
  }
  layer.endDraw();



  inverter.set("resolution", float(width), float(height));
  inverter.set("multiplier", mouseX/(float)width);
  
  image(layer,0,0);
  
  if(useShader)shader(inverter);
  
  image(layer, 0, 0);
  
  resetShader();
}

void keyPressed(){
 if(key == 's'){
  useShader = !useShader; 
 }
}