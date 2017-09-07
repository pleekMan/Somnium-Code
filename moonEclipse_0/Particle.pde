class Particle {

  PVector pos, vel;
  float velMultiplier;
  float life;
  float lifeStart;


  Particle(PVector _pos, PVector _vel, float _lifeFrames) {
    pos = _pos.get();
    vel = _vel.get();
    velMultiplier = 1;
    vel.mult(velMultiplier);
    life = _lifeFrames;
    lifeStart = (float)frameCount;

  }

  void update() {
    pos.add(vel);
    

  }

  void render() {
    float opacity = map(frameCount,lifeStart,lifeStart + life,1,0);
    
    stroke(255,255 * opacity);
    point(pos.x, pos.y);
    line(pos.x, pos.y, pos.z, pos.x + (-vel.x * 5), pos.y + (-vel.y * 5), pos.z + (-vel.z * 5));
  }
  
  void setVelocityMultiplier(float velMultiplier){
    vel.mult(velMultiplier);
  }
  
  boolean isDead(){
   if(frameCount > (lifeStart + life)){
    return true;
   } else {
    return false; 
   }
  }
}
