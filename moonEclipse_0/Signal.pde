class Signal {


  int signalResolution;
  float[] signalLinesY;
  float[] lineAttribute;
  float signalLineLength;

  float spikeAccel;
  float spikeVel;
  float spikePos;
  float spikeDamp;
  
  float opacity;
  float opacityFader;


  Signal() {
    signalResolution = 100;
    signalLinesY = new float[signalResolution];
    lineAttribute = new float[signalResolution];

    signalLineLength = (float)width / signalLinesY.length;

    spikeAccel = 0;
    spikeVel = 0;
    spikePos = height * 0.5;
    spikeDamp = 0.98;
    
    opacity = 1;
    opacityFader = -0.001;
  }

  void render() {

    pushStyle();
    
    //drawBlueScreen();

    spikeVel += spikeAccel;
    spikeVel *= spikeDamp; 
    spikePos += spikeVel;

    //float spikeY = (height * 0.5) + (sin(spikePos) * (height * 0.5));
    float spikeY = map(sin(spikePos), -1, 1, height * 0.25, height * 0.75);

    signalLinesY[signalLinesY.length - 1] = spikeY;
    lineAttribute[signalLinesY.length - 1] = 50 * spikeVel;

    stroke(0,0,255,255 * opacity);
    strokeWeight(2);

    for (int i=0; i < signalLinesY.length - 1; i++) {

      signalLinesY[i] = signalLinesY[i+1];
      lineAttribute[i] = lineAttribute[i+1];

      //line(i * signalLineLength, signalLinesY[i], i * signalLineLength, 0);
      //line(i * signalLineLength + (signalLineLength * 0.5), height - signalLinesY[i], i * signalLineLength + (signalLineLength * 0.5), height);
      
      line(i * signalLineLength, signalLinesY[i], width, signalLinesY[i]);
      line(i * signalLineLength + (signalLineLength * 0.5), height - signalLinesY[i], i * signalLineLength + (signalLineLength * 0.5), height);
   
    }

    popStyle();
    
    if(opacity > 0){
     opacity += opacityFader; 
    }
  }


  void trigger() {
    spikeAccel = random(TWO_PI * 0.5);
    spikeVel = spikeAccel;
    spikeAccel = 0;
    
    opacity = 1;
  }
  
  void drawBlueScreen(){
    fill(0,0,255,1 - opacity);
    rect(0,0,width,height);
  }
  
  void setOpacity(float _opacity){
    opacity = _opacity;
  }
}
