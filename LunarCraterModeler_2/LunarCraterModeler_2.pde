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

PShader vertShader;

void setup() {
  size(1500, 750, P3D);
  noStroke();
  fill(255, 255, 0);
  strokeWeight(1);

  /*
  camera = new Camera(this, 0, -50, 0);
   camera.jump(0, -50, 100);
   camera.aim(0, -50, -1000);
   */
  //camera.zoom(HALF_PI);

  cameraVel = new PVector(0, 0, -0.3);


  //  camera = new PeasyCam(this, 500);
  //  camera.setMinimumDistance(25);
  //  camera.setMaximumDistance(2000);
  //  camera.setSuppressRollRotationMode();
  //  //camera.lookAt(0, -100, -2000, 100000);

  cam = new LunarCamera();


  craters = new ArrayList<Crater>();
  cratersFrozen = createShape(GROUP);

  for (int i=0; i<100; i++) {
    createNewCrater();
  }

  enableCameraControl = true;
  
  vertShader = loadShader("frags.glsl","verts.glsl");
  shader(vertShader);
}

void draw() {
  background(0);

  //if (frameCount % 15 == 0)frame.setTitle("FPS: " + frameRate);

  //lights();

  //camera.dolly(cameraVel.z);

  /*
  for (int i=0; i < craters.size (); i++) {
   craters.get(i).render();
   }
   */
   

  shape(cratersFrozen);

  //drawGround();

  // CAM TRAJECTORY
  //stroke(255, 255, 0);
  //line(0, -1, 0, 0, -1, -10000);


  drawAxisGizmo(100);

  cam.update();
  //cam.render();
  camera(cam.camPosition.x, cam.camPosition.y, cam.camPosition.z, cam.target.x, cam.target.y, cam.target.z, 0, 1, 0);

  showFPS();

  //camera.feed();
}

void keyPressed() {
  if (key == ' ') {
    enableCameraControl = !enableCameraControl;
    //camera.setActive(enableCameraControl);
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

  noStroke();
  fill(50);
  beginShape(QUAD);
  vertex(-1000, 0, 0);
  vertex(1000, 0, 0);
  vertex(1000, 0, -2000);
  vertex(-1000, 0, -2000);
  endShape();
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
