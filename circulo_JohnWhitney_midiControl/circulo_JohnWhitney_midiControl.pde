
//import controlP5.*;
import themidibus.*; //Import the library



float vertXPos[];
float[] vertYPos;
float[] oscTiempo;
float oscIncrementoGlobal;

int cantidadDeVertices = floor(TWO_PI * 3) * 100; // TO COINCIDE WITH COLOR %s

float centroX;
float centroY;
float radio = 200;
float radioInterno;

float angulo = 0;
float anguloVel = 0;

float oscilationControl;

int funcionTrigUsada;
float brillo;
float pointSize = 1;


MidiBus midiControl;

void setup() {
  size(600, 600);
  background(45);

  centroX = width * 0.5;
  centroY = height * 0.5;

  vertXPos = new float[cantidadDeVertices];
  vertYPos = new float[cantidadDeVertices];
  oscTiempo = new float[cantidadDeVertices];
  oscIncrementoGlobal = 0.01;

  for (int i=0; i< cantidadDeVertices; i++) {
    vertXPos[i] = 0;
    vertYPos[i] = 0;
    //oscTiempo[i] = i / PI;
    oscTiempo[i] = (TWO_PI / cantidadDeVertices) * i; // GETS WRITTEN OVER BY controlIncrOsc FUNCTION
  }

  radioInterno = 0;
  brillo = 255;


  crearControladores();
}


void draw() {
  //background(0);
  fill(0, 5);
  noStroke();
  rect(0, 0, width, height);

  noStroke();
  fill(255);

  calcularPosiciones();
  dibujarCirculo();
}

void calcularPosiciones() {

  for (int i=0; i <  cantidadDeVertices; i++) {


    float anguloTrig = calcularConFuncion(funcionTrigUsada, i);
    float rangoPantalla = map(anguloTrig, -1, 1, radioInterno, radio);


    angulo = (TWO_PI / cantidadDeVertices) * i;

    vertXPos[i] = centroX + (rangoPantalla * cos(angulo));
    vertYPos[i] = centroY + (rangoPantalla * sin(angulo));

    oscTiempo[i] += (anguloVel * (i/(float) cantidadDeVertices));

    //if (controlRotacion.getBooleanValue()) {
    oscTiempo[i] += oscIncrementoGlobal;
    //}
  }

  for (int i=0; i< oscTiempo.length; i++) {
    //oscTiempo[i] = (oscTiempo[i] * i) + anguloVel;
  }


  //vel += 1;
}

void dibujarCirculo() {

  //stroke(brillo);
  fill(brillo,127);
  for (int i=0; i <  cantidadDeVertices; i++) {
    //line(vertXPos[i],vertYPos[i], vertXPos[(i+1) % cantidadDeVertices], vertYPos[(i+1) % cantidadDeVertices]);
    //line(vertXPos[i], vertYPos[i], centroX, centroY);
      fill(abs(sin(i * 0.01)) * 255,0,abs(sin(i * 0.02)) * 255,127);
    ellipse(vertXPos[i], vertYPos[i], pointSize,pointSize);
    //point(vertXPos[i], vertYPos[i]);
  }


  // WITH FEWER VERTEX
  /*
  fill(255);
   beginShape(QUADS);
   for (int i=0; i <  cantidadDeVertices; i++) {
   //stroke(brillo);
   vertex(vertXPos[i], vertYPos[i]);
   vertex(centroX, centroY);
   }
   endShape();
   */
}


float calcularConFuncion(int numeroDeFuncion, int vertice) {

  float oscTrig = 0;

  switch(numeroDeFuncion) {
  case 0:
    oscTrig = sin(oscTiempo[vertice]);
    break;
  case 1:
    oscTrig = 1 - cos(oscTiempo[vertice]);
    break;
  case 2:
    oscTrig = tan(oscTiempo[vertice]);
    break;
  default:
    oscTrig = 1;
    break;
  }

  return oscTrig;
}


void controllerChange(int channel, int number, int value) {
  // Receive a controllerChange

  if (channel == 0) {

    // OSCILATION DISPLACEMENT (POSITION)
    if (number == 0) {
      for (int i=0; i< oscTiempo.length; i++) {
        oscilationControl = map(value, 0, 127, 0, TWO_PI);
        oscTiempo[i] = oscilationControl * i;
      }
    }

    if (number == 1) {
      brillo= map(value, 0, 127, 0, 255);
    }

    // SELECT TRIG FUNCTION
    switch(number) {
    case 2:
      funcionTrigUsada = 0;
      break;
    case 3:
      funcionTrigUsada = 1;
      break;
    case 4:
      funcionTrigUsada = 2;
      break;
    default:
      break;
    }
  }


  if (channel == 1) {
    // OSCILATION DISPLACEMENT (VELOCITY FORWARD)
    if (number == 0) {
      for (int i=0; i< oscTiempo.length; i++) {
        anguloVel = map(value, 0, 127, 0, 0.2);
      }
    }
    
    if (number == 1) {
      pointSize = map(value,0,127,1,300);
    }
  }

  if (channel == 2) {
    // INNER RADIUS
    if (number == 1) {
      radioInterno = map(value, 0, 127, 0, height * 0.8);
    }
  }
  
    if (channel == 3) {
    // INNER RADIUS
    if (number == 1) {
      radio = map(value, 0, 127, 0, height * 0.8);
    }
  }



  println();
  println("Controller Change:");
  println("--------");
  println("Channel:"+channel);
  println("Number:"+number);
  println("Value:"+value);
}

void noteOn(int channel, int pitch, int velocity) {
  // Receive a noteOn




  println();
  println("Note On:");
  println("--------");
  println("Channel:"+channel);
  println("Pitch:"+pitch);
  println("Velocity:"+velocity);
}

void noteOff(int channel, int pitch, int velocity) {
  // Receive a noteOff
  println();
  println("Note Off:");
  println("--------");
  println("Channel:"+channel);
  println("Pitch:"+pitch);
  println("Velocity:"+velocity);
}

void crearControladores() {

  MidiBus.list();
  midiControl = new MidiBus(this, "SLIDER/KNOB", -1); // Create a new MidiBus with no input device and the default Java Sound Synthesizer as the output device.

  /*

   Range controlRadios = controladores.addRange("controlRadios");
   controlRadios.setLabel("RADIO INTERNO/EXTERNO");
   controlRadios.setWidth(int(width*0.5));
   //controlRadios.setPosition(width * 0.5, height*0.5);
   controlRadios.setPosition(width * 0.5, 20);
   controlRadios.setMin(0);
   controlRadios.setMax(width * 0.5);
   controlRadios.setArrayValue(new float[]{0, 150});
   controlRadios.setColorForeground(color(0, 200, 100));
   controlRadios.getCaptionLabel().getStyle().marginLeft = -int(width * 0.5);
   controlRadios.getCaptionLabel().getStyle().marginTop = 10;
   
   
   Knob controlOscilacion = controladores.addKnob("incrementoOscilacion");
   controlOscilacion.setLabel("INCREMENTO OSCILACION");
   controlOscilacion.setPosition(width * 0.45, 50);
   controlOscilacion.setRange(0, TWO_PI);
   controlOscilacion.setValue(0);
   
   DropdownList selectorDeFuncion = controladores.addDropdownList("selectorDeFuncion");
   selectorDeFuncion.setLabel("SELECTOR DE FUNCION");
   selectorDeFuncion.setPosition(20, 20);
   selectorDeFuncion.addItems(new String[]{"SENO", "COSENO", "TANGENTE"});
   selectorDeFuncion.setValue(0);
   selectorDeFuncion.setOpen(false);
   
   
   controlRotacion = controladores.addButton("habilitarRotacion");
   controlRotacion.setLabel("HABILITAR ROTACION");
   controlRotacion.setSwitch(true);
   controlRotacion.setOn();// SI AGREGAMOS ESTA LINEA, EL BOTON SE CONVIERTE EN TOGGLE AUTOMATICAMENTE
   controlRotacion.setWidth(80);
   controlRotacion.setPosition(20, 100);
   
   Slider controlBrillo = controladores.addSlider("controlBrillo");
   controlBrillo.setLabel("BRILLO");
   controlBrillo.setRange(0, 255);
   controlBrillo.setValue(255);
   controlBrillo.setPosition(20, 130);
   
   */
}

/*
void controlEvent(ControlEvent theControlEvent) {
 
 // CONTROL DE RADIOS
 if (theControlEvent.isFrom("controlRadios")) {
 radioInterno = theControlEvent.getController().getArrayValue(0);
 radio = theControlEvent.getController().getArrayValue(1);
 }
 
 // CONTROL DE INCREMENTO DE ANGULO
 if (theControlEvent.isFrom("incrementoOscilacion")) {
 for (int i=0; i< oscTiempo.length; i++) {
 float valorDelControlador = theControlEvent.getController().getValue();
 oscTiempo[i] = valorDelControlador * i;
 }
 }
 
 if (theControlEvent.isFrom("selectorDeFuncion")) {
 // check if the Event was triggered from a ControlGroup
 funcionTrigUsada = (int)theControlEvent.getController().getValue();
 }
 
 if (theControlEvent.isFrom("controlBrillo")) {
 brillo = (int)theControlEvent.getController().getValue();
 }
 }
 */