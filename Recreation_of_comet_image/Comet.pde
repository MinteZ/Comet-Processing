class Comet {

  ArrayList<Particle> particles = new ArrayList<Particle>();
  PVector pos, vel, acc = new PVector();
  int updates = 0;
  float size = 20;

  Comet(float x, float y, float a, float s) {
    pos = new PVector(x, y);
    vel = PVector.fromAngle(radians(a)).mult(s/60f);
  }

  void update() {
    //Main trail
    for (int i = 0; i<3; i++) {
      particles.add(new Particle(pos.x, pos.y, 0, vel.heading() + PI + radians(random(-45, 45)), random(1, 1.5), size * 3, gradient1, false, trail));
    } 

    //Smoke
    float s = random(size, size * 50);
    for (int i = 0; i<2; i++) {
      float ox = random(-15, 15);
      float oy = random(-15, 15);
      particles.add(new Particle(pos.x + ox, pos.y + oy, 6, random(TWO_PI), 3, s, gradient2, true, smoke));
      particles.add(new Particle(pos.x, pos.y, 5, random(TWO_PI), 6, s * (2/3f), gradient3, true, smoke));
    }

    //Trail dots
    float a = random(TWO_PI);
    s = random(size/4, size/2);
    particles.add(new Particle(cos(a) * s + pos.x, sin(a) * s + pos.y, 2, random(TWO_PI), 4, 5, gradient4, false, trail));

    acc.set(mouseX - pos.x, mouseY - pos.y);
    acc.normalize();
    acc.div(8);
    vel.add(acc);
    vel.limit(6);
    pos.add(vel);
    updates++;
  }

  void draw() {
    blendMode(ADD);
    for (int i = 0; i<particles.size(); i++) {
      Particle p = particles.get(i);
      if (p.life <= 0) {
        particles.remove(i);
        i--;
      } else {
        p.update();
        p.draw();
      }
    }
    blendMode(NORMAL);
    fill(0);
    ellipse(pos.x, pos.y, size, size);
  }
}