class ParticleSystem {

  ArrayList<Particle> particles;

  static final int EXPLOSION = 0;
  static final int AREA = 1;

  PVector originPoint;
  PVector directionUnique;

  float blastLife;
  float blastLifeIncr;

  ParticleSystem() {
    particles = new ArrayList<Particle>();
    originPoint = new PVector(width * 0.75, height * 0.50);
    directionUnique = new PVector(0, 1);


    blastLife = 1; 
    blastLifeIncr = 0.005;
  }

  void render() {

    for (int i=0; i<particles.size (); i++) {
      Particle currentParticle = particles.get(i);

      currentParticle.render();
    }

    // SPAWN POINT
    noStroke();
    fill(0, 0, (1 - blastLife) * 255);
    ellipse(originPoint.x, originPoint.y, 5, 5);

    // SPAWN POINT RAY
    PVector rayEnd = PVector.mult(directionUnique, blastLife * 1000);
    rayEnd.add(originPoint);
    strokeWeight(2);
    stroke(0, 0, (1 - blastLife) * 255);
    line(originPoint.x, originPoint.y, originPoint.z, rayEnd.x, rayEnd.y, rayEnd.z);
    strokeWeight(1);
  }

  void update() {

    for (int i=0; i<particles.size (); i++) {
      Particle currentParticle = particles.get(i);
      currentParticle.update();
    }

    removeDeadParticles();

    if (!blastEnded()) {
      blastLife += blastLifeIncr;
    }
  }

  void createAndTrigger(int quantity, int TYPE) {

    if (TYPE == EXPLOSION) {
      createExplosion(quantity);
    }
  }

  void createExplosion(int quantity) {

    float divergentAngleMax = QUARTER_PI;

    for (int i=0; i<quantity; i++) {

      //      PVector divergedDirection = PVector.fromAngle(directionUnique.heading() +  random(-divergentAngleMax, divergentAngleMax)); //directionUnique.get(); // ALL NORMALIZED
      PVector divergedDirection = PVector.fromAngle(directionUnique.heading());// +  random(-divergentAngleMax, divergentAngleMax)); //directionUnique.get(); // ALL NORMALIZED
      PVector position = originPoint;
      position.add(new PVector(random(-5, 5), random(-5, 5)));
      float velMultiplier = random(0.5, 3);
      float particleLife = random(90, 240);

      Particle newParticle = new Particle(position, divergedDirection, particleLife);
      newParticle.setVelocityMultiplier(velMultiplier);

      particles.add(newParticle);
    }

    blastLife = 0;
  }

  void setOriginPoint(PVector origin) {
    originPoint = origin;
  }

  void setDirectionUnique(PVector dir) {
    directionUnique = dir;
  }

  void removeDeadParticles() {
    Iterator iterator = particles.iterator();
    while (iterator.hasNext ()) {
      Particle currentParticle = (Particle)iterator.next();
      if (currentParticle.isDead()) iterator.remove(); //
    }
    //println("ParticleCount: " + particles.size());
  }

  boolean blastEnded() {
    if (blastLife >= 1) {
      return true;
    } else {
      return false;
    }
  }
}
