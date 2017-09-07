class LunarCamera {

  PVector masterTransform;
  PVector target;
  PVector camOffset;
  PVector camPosition;


  LunarCamera() {

    masterTransform = new PVector();
    target = new PVector();
    camPosition = new PVector();
    camOffset = new PVector(200,-150,100);
  }

  void update() {
    masterTransform.add(0, 0, -0.5);

    camPosition.set(PVector.add(masterTransform, camOffset));
    target.set(masterTransform);
  }

  void render() {

    noFill();
    stroke(0, 255, 0);

    //MASTER
    pushMatrix();
    translate(masterTransform.x, masterTransform.y, masterTransform.z);
    box(50);
    popMatrix();


    //TARGET
    pushMatrix();
    translate(target.x, target.y, target.z);
    box(20);
    popMatrix();

    //CAMERA
    pushMatrix();
    translate(camPosition.x, camPosition.y, camPosition.z);
    sphere(20);
    popMatrix();
    
    line(camPosition.x, camPosition.y, camPosition.z,target.x, target.y, target.z);
  }
  
  void setAltitude(float alt){
   camOffset.y = alt; 
  }
}
