class Particle {

  PVector position, velocity, acceleration;
  float damp;

  //ArrayList<SpaceWarp> spaceWarps;


  Particle() {
    position = new PVector();
    velocity = new PVector();
    acceleration = new PVector();
    damp = 1;
  }

  public void update() {
    velocity.add(acceleration);
    position.add(velocity);
    position.mult(damp);
  }
  
  public void render(){
    
  }
}
