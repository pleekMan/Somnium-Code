import java.util.Iterator;

float moonDiameter;
PVector moonPos;
float eclipseTransition;
boolean enableEclipseTransition;
PShape moon;

boolean enableBigRay;

//PImage fullMoon;

ParticleSystem particleSystem;

Signal signal;


void setup() {
  size(displayWidth, displayHeight,P3D);
  frameRate(30);
  imageMode(CENTER);

  moonDiameter = height  * 0.75;
  moonPos = new PVector(width * 0.5, height * 0.5);
  eclipseTransition = 0;
  enableEclipseTransition = false;

  enableBigRay = true;

  createMoon();

  particleSystem = new ParticleSystem();

  signal = new Signal();

  //fullMoon = loadImage("fullMoon.png");
}

void draw() {
  frame.setTitle("FR: " + frameRate);

  background(0);


  if (enableBigRay) {
    showBigRay();
  }


  // BLACK MOON

  fill(0);
  noStroke();
  ellipse(moonPos.x, moonPos.y, moonDiameter, moonDiameter);

  // HALF MOON WHITE
  shape(moon);

  //image(fullMoon,moonPos.x, moonPos.y, moonDiameter, moonDiameter);

  //MOON OUTLINE
  noFill();
  stroke(50);
  ellipse(moonPos.x, moonPos.y, moonDiameter, moonDiameter);





  // BLACK ECLIPSE MOON
  pushMatrix();
  translate(moonPos.x, moonPos.y);
  scale(1 - eclipseTransition, 1);
  fill(0);
  noStroke();
  ellipse(0, 0, moonDiameter + 2, moonDiameter + 2);
  popMatrix();

  // BLACK RECT TO HIDE WHAT IS SEEN WHEN SCALING THE ELLIPSE
  //rect(width * 0.5, 0, (moonDiameter * 0.5) + 2, height);

  // AURA
  /*
  float auraWidth = moonDiameter + 30; 
   //float auraSep = 3;
   
   for (int i=0; i < 10; i++) {
   fill(255 - (i/(float)10 * 255));
   ellipse(moonPos.x, moonPos.y, lerp(auraWidth, moonDiameter, 1 - ((float)i/10)), lerp(auraWidth, moonDiameter, 1 - ((float)i/10)));
   }
   */


  particleSystem.update();
  particleSystem.render();




  if (enableEclipseTransition) {
    if (eclipseTransition <= 1) {
      eclipseTransition += 0.001;
    }
  }
}

void createMoon() {

  int moonRes = 50;
  float angleStep = TWO_PI / moonRes;

  moon = createShape();
  moon.beginShape();
  moon.fill(255);
  moon.noStroke();

  for (int i=0; i<50; i++) {
    float x = (moonDiameter * 0.5) * cos(angleStep * i);
    float y = (moonDiameter * 0.5) * sin(angleStep * i);

    x = x > 0 ? 0 : x;

    moon.vertex(x, y);
  }
  moon.endShape();

  moon.translate(width * 0.5, height * 0.5);
}

void showBigRay() {
  noStroke();

  // BIG RAY
  /*
  for (int i=0; i<5; i++) {
   float intensity = ((float(i)/5) * 255) * (1 - particleSystem.blastLife);
   float size = (height * 0.2) + (50 * i);
   
   fill(0, 0, 255, intensity);
   rect(0, (height * 0.5) - (size * 0.5), width, size);
   }
   */

  //fill(0,0,255, 255 * (1 - particleSystem.blastLife));
  //rect(0, 0, width, height);

  pushMatrix();
  translate(0, 0, -1);
  signal.render();
  popMatrix();
  /*
  pushMatrix();
   translate(0,0,1);
   fill(255, 255 * (1 - particleSystem.blastLife));
   rect(0, 0, width, height*0.25);
   rect(0, height, width, -(height * 0.25));
   popMatrix();
   */
}

void keyPressed() {

  if (key == 'e') {

    float angleForSurfaceOnLeftOnMoon = random(PI) - HALF_PI;
    float spawnX = moonPos.x + ((moonDiameter * 0.5) * cos(angleForSurfaceOnLeftOnMoon));
    float spawnY = moonPos.y + ((moonDiameter * 0.5) * sin(angleForSurfaceOnLeftOnMoon));

    particleSystem.setOriginPoint(new PVector(spawnX, spawnY) );
    PVector direction = PVector.fromAngle(angleForSurfaceOnLeftOnMoon);
    direction.add(0, 0, random(-1, 1)); // ADD Z VALUES
    particleSystem.setDirectionUnique(direction);
    particleSystem.createAndTrigger(50, ParticleSystem.EXPLOSION);
  }

  if (key == 't') {
    enableEclipseTransition = !enableEclipseTransition;
  }

  if (key == 'r') {
    enableBigRay = !enableBigRay;
  }

  if (key == 'f') {

    // SIGNAL TRIGGER
    signal.trigger();
  }
}

void mousePressed() {
}

void mouseReleased() {
}

void mouseClicked() {
}

void mouseDragged() {
}

void mouseWheel(MouseEvent event) {
  //float e = event.getAmount();
  //println(e);
}
