class Attractor extends SpaceWarp {

  float attractRadius;
  float strengthMin;
  float strengthMax;


  Attractor() {
    super();
  }

  void update() {
    super.update();
  }

  void warp(PVector particle) {
    super.warp(particle);

    float distanceToattractor = getDistanceTo(particle, center);
    if (distanceToattractor < attractRadius) {
      float keepZ = particle.z;
      PVector toAttractorVector = PVector.sub(attractor, particle);
      float strength = map(distanceToattractor, 0, attractRadius, strengthMax, strengthMin);
      toAttractorVector.mult(strength * multiplier);
      particle.add(toAttractorVector);
      particle.z = keepZ;
    }
  }

  public void setStrengthMax(float s) {
    strengthMax = s;
  }

  public void setStrengthMin(float s) {
    strengthMin = s;
  }
}
