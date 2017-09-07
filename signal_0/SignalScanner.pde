class SignalScanner {

  float scannerWidth;
  float scannerVel;
  float scannerPos;
  int scannerRes;


  SignalScanner() {

    scannerRes = 20;
    scannerWidth = width * 0.25;

    reset();
  }


  void render() {

    if (scannerPos > -scannerWidth * 2) {
      scannerPos += scannerVel;

      noStroke();

      pushMatrix();
      translate(scannerPos, 0);
      for (int i=0; i < scannerRes; i++) {
        float opacity = map(i, 0, scannerRes, 0, PI);
        opacity = sin(opacity) * 255;
        fill(255, opacity);
        rect((scannerWidth / (float)scannerRes) * i, 0, (scannerWidth / (float)scannerRes), height);
      }
      popMatrix();
    }
  }

  void trigger() {
    reset();
  }

  void reset() {
    scannerVel = -random(40,70);
    scannerPos = width + scannerWidth;
  }
}
