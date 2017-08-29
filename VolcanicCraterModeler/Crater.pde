class Crater {

  PVector center;
  float baseRadius, topRadius;
  int levels;
  float craterHeight;
  int ringResolution;

  float noiseBaseStart, noiseTopStart;
  float noiseRange; //  0 -> noiseRange for full circle (higher = more variation)
  float noiseMultiplier;
  
  float backLoopStart;

  Crater() {

    center = new PVector();
    baseRadius = 200;
    topRadius = 50;
    levels = 20;
    ringResolution = 40;
    craterHeight = 70;

    noiseRange = 3;
    noiseBaseStart = random(10);
    noiseTopStart = random(10);
    noiseMultiplier = 200;
    backLoopStart = 0.80;

  }

  void render() {

    //noiseRange = map(mouseY, 0, height, 2, 0);
    backLoopStart = norm(mouseY,height,0);
    
    float angleUnit = TWO_PI / ringResolution;

    stroke(255, 255, 0);

    for (int i=0; i < ringResolution; i++) {
      float noisedRadius = noise(noiseBaseStart + ((noiseRange / ringResolution) * i));
      noisedRadius = baseRadius + (((noisedRadius * 2) - 1) * noiseMultiplier);

     
      if(i >= (ringResolution * backLoopStart)){
        float backLoopPosition = norm(i, (ringResolution * backLoopStart), ringResolution);
        float firstNoisedRadius = baseRadius + (  (noise(noiseBaseStart) * 2 -1) * noiseMultiplier);
        noisedRadius = lerp(noisedRadius,firstNoisedRadius, backLoopPosition);
      }
      
      PVector basePoint = new PVector(noisedRadius * cos(angleUnit * i), 0, noisedRadius * sin(angleUnit * i));
      basePoint.add(center);
 

      //line(center.x, center.y, center.z, basePoint.x, basePoint.y, basePoint.z);


      PVector topPoint = new PVector(topRadius * cos(angleUnit * i), 0, topRadius * sin(angleUnit * i));
      topPoint.add(center.x, -craterHeight, center.z);

      for (int lev=0; lev<levels; lev++) {
        float x = map(lev, 0, levels, basePoint.x, topPoint.x);
        float y = map(lev, 0, levels, basePoint.y, topPoint.y);
        float z = map(lev, 0, levels, basePoint.z, topPoint.z);

        point(x, y, z);
      }
    }
  }
}
