class SpaceWarp {

  PVector center;
  PVector boxSize;
  float multiplier = 1;
  String name;
  boolean[] affectAxis = {true,true,true}; 

  SpaceWarp() {
    center = new PVector();
    boxSize = new PVector (100, 100, 100);
  }

  public void update() {
  }

  public void warp(PVector particle) {
  }

  
  float getDistanceTo(PVector pos1, PVector pos2) {
    return dist(pos1.x, pos1.y, pos1.z, pos2.x, pos2.y, pos2.z);
  }
  
  void affectAxis(boolean x, boolean y, boolean z){
    affectAxis[0]=x;
    affectAxis[1]=y;
    affectAxis[3]=z;
  }
  
}
