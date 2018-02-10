// DROP-DOWN LIST FOR CHOOSING TRIG FUNCTION
// AGREGAR BOTON PARA PAUSAR LA ROTACION => oscIncrementoGlobal = 0;
// PEDIRLES DE AGREGAR 2 SLIDERS PARA COLORES -1 -> 1 DE LOS VERTICES => color(control1, control2,0)

import controlP5.*;


float vertXPos[];
float[] vertYPos;
float[] oscTiempo;
float oscIncrementoGlobal;

int cantidadDeVertices = 800;

float centroX;
float centroY;
float radio = 200;
float radioInterno;

float angulo = 0;
float vel = 0.01;

int funcionTrigUsada;
float brillo;

ControlP5 controladores;

Button controlRotacion;

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

  controladores = new ControlP5(this);
  controladores.enableShortcuts();

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

    if (controlRotacion.getBooleanValue()) {
      oscTiempo[i] += oscIncrementoGlobal;
    }
  }

  vel += 1;
}

void dibujarCirculo() {
  for (int i=0; i <  cantidadDeVertices; i++) {


    stroke(brillo);

    //line(vertXPos[i],vertYPos[i], vertXPos[(i+1) % cantidadDeVertices], vertYPos[(i+1) % cantidadDeVertices]);

    ellipse(vertXPos[i], vertYPos[i], 1, 1);
  }
}



void crearControladores() {

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
}

float calcularConFuncion(int numeroDeFuncion, int vertice) {

  float oscTrig = 0;

  switch(numeroDeFuncion) {
  case 0:
    oscTrig = sin(oscTiempo[vertice]);
    break;
  case 1:
    oscTrig = cos(oscTiempo[vertice]);
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