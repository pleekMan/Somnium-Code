//import damkjer.ocd.*;

//import peasy.org.apache.commons.math.*;
//import peasy.*;
//import peasy.org.apache.commons.math.geometry.*;
//PeasyCam camera;


//Camera camera;
PVector cameraVel;

LunarCamera cam;

ArrayList<Crater> craters;
PShape cratersFrozen;
boolean enableCameraControl;

PGraphics canvasLunar;
PShader shader;

float lightDarkControl = 0;

void setup() {
  size(1500, 750, P3D);
  noStroke();
  fill(255, 255, 0);
  strokeWeight(1);
  textureMode(NORMAL);

  canvasLunar = createGraphics(width, height, P3D);
  shader = loadShader("invert.glsl");

  cameraVel = new PVector(0, 0, -0.3);

  cam = new LunarCamera();

  craters = new ArrayList<Crater>();
  cratersFrozen = canvasLunar.createShape(GROUP);

  for (int i=0; i<100; i++) {
    createNewCrater();
  }

  enableCameraControl = true;

  //vertShader = loadShader("frags.glsl", "verts.glsl");
  //shader(vertShader);
}

void draw() {
  //background(255 - (255 * lightDarkControl));
   background(0);
   
  //if (frameCount % 15 == 0)frame.setTitle("FPS: " + frameRate);

  //lights();

  //camera.dolly(cameraVel.z);

  /*
  for (int i=0; i < craters.size (); i++) {
   craters.get(i).render();
   }
   */


  // CAM TRAJECTORY
  //stroke(255, 255, 0);
  //line(0, -1, 0, 0, -1, -10000);

  lightDarkControl = norm(mouseX, 0, width);

  cam.update();
  //cam.render();

  //FOV control
  //float camFov = map(mouseX, 0, width, 0.1, TWO_PI);
  //float camZ = (height/2.0) / tan(camFov/2.0);
  //perspective(camFov, width/(float)height, camZ * 0.1, camZ * 10);

  // CAM
  canvasLunar.camera(cam.camPosition.x, cam.camPosition.y, cam.camPosition.z, cam.target.x, cam.target.y, cam.target.z, 0, 1, 0);

  //drawGround();


  //drawAxisGizmo(100);





  canvasLunar.beginDraw();
  //canvasLunar.background(255 - (255 * lightDarkControl));
  canvasLunar.background(0);
  canvasLunar.shape(cratersFrozen);
  canvasLunar.filter(shader);
  canvasLunar.endDraw();



  // DO STUFF ON EACH CRATER
  /*
  stroke(255);
   //fill(255, 255, 0);
   for (int i=0; i<cratersFrozen.getChildCount (); i++) {
   PVector shapePos = cratersFrozen.getChild(i).getVertex(0);
   
   
   pushMatrix();
   translate(shapePos.x, shapePos.y, shapePos.z);
   //text(i,0,0);
   box(50);
   
   //line(cam.target.x, cam.target.y, cam.target.z,shapePos.x, shapePos.y, shapePos.z);
   popMatrix();
   }
   */

  shader.set("resolution", float(width), float(height));
  shader.set("multiplier", mouseX/(float)width);
  
  shader(shader);

  image(canvasLunar, 0, 0);
  
  resetShader();

  //hint(DISABLE_DEPTH_TEST);
  showFPS();
  //hint(ENABLE_DEPTH_TEST);

  //camera.feed();
}

void keyPressed() {
  if (key == ' ') {
    enableCameraControl = !enableCameraControl;
    //camera.setActive(enableCameraControl);
  }

  if (key == 'c') {
    int randomCrater = floor(random(craters.size()));
    //craters.get(randomCrater)..gsetFill(color(255));
    cratersFrozen.getChild(randomCrater).setFill(color(255, 0, 0));
  }
}

void mousePressed() {
}

void mouseReleased() {
}

void mouseClicked() {
}

void mouseDragged() {

  /*
  for (int i=0; i < craters.size (); i++) {
   craters.get(i).revolveResolution = floor(map(mouseY, height, 0, 4,40));
   }
   */
  //craters.get(0).setCenter(craters.get(0).center.x, craters.get(0).center.y, (mouseY * 10) - 500);

  //camera.zoom(radians(mouseY - pmouseY) / 2.0);

  cam.setAltitude( -(height - mouseY));
}

void createNewCrater() {
  Crater crater = new Crater();

  crater.setCenter(random(-2000, 200), 0, random(-10000, 0));
  //crater.setCenter(0,0,0);
  crater.setStages(random(0, 0.25), random(0.25, 0.5), random(0.5, 0.75), random(0.75, 1));
  crater.setRadius(random(10, 300));
  crater.setHeight(random(3, 20));

  craters.add(crater);

  cratersFrozen.addChild(crater.getShape());
}

void drawGround() {

  stroke(255);
  beginShape();
  fill(255, 255, 0);
  vertex(-1000, 0, 0);
  vertex(1000, 0, 0);
  fill(255, 0, 255);
  vertex(1000, 0, -2000);
  vertex(-1000, 0, -2000);
  endShape(CLOSE);
}


void drawAxisGizmo(float size) {

  pushMatrix();
  //translate(translacionGlobal.x, translacionGlobal.y, translacionGlobal.z);

  noFill();
  stroke(127);
  box(size * 0.1);

  // X
  fill(255, 0, 0);
  stroke(255, 0, 0);
  line(0, 0, 0, size, 0, 0);

  // Y
  fill(0, 255, 0);
  stroke(0, 255, 0);
  line(0, 0, 0, 0, size, 0);

  // Z
  fill(0, 0, 255);
  stroke(0, 0, 255);
  line(0, 0, 0, 0, 0, size);

  popMatrix();
}

void showFPS() {
  hint(DISABLE_DEPTH_TEST);
  textMode(MODEL);
  textAlign(LEFT);
  //pushMatrix();
  //translate(0, 0);
  noStroke();
  fill(0, 0, 100, 100);
  rect(0, 0, 100, 20);
  fill(255);
  text("FPS: " + nf(frameRate, 2, 2), 10, 20);
  //popMatrix();
  hint(ENABLE_DEPTH_TEST);
}