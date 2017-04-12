class Particle {
  PVector pos, vel;
  float size;
  float duration;
  float life = 1;
  boolean grow;
  PImage img;

  color[] gradient;

  color getColour(float f) {
    if (gradient.length == 0) {
      return color(0);
    }
    if (gradient.length == 1) {
      return gradient[0];
    }
    if (f == 1) {
      return gradient[gradient.length - 1];
    }
    float i1 = f * (gradient.length - 1);
    int i2 = (int)i1 + 1;
    color c1 = gradient[(int)i1];
    color c2 = gradient[i2];
    return lerpColor(c1, c2, i1 % 1);
  }

  Particle(float x, float y, float s, float a, float d, float size, color[] g, boolean gr, PImage i) {
    pos = new PVector(x, y);
    vel = PVector.fromAngle(a).mult(s/60f);
    this.size = size;
    duration = d;
    gradient = g;
    grow = gr;
    img = i;
  }

  void update() {
    if (life <= 0) {
      return;
    }
    pos.add(vel);
    life -= 1f/60/duration;
    if (life < 0) {
      life = 0;
    }
  }

  void draw() {
    if (life <= 0) {
      return;
    }
    float s = lerp(0, size, grow ? 1 - life : life);
    color c = getColour(1 - life);
    tint(c, life * alpha(c));
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(vel.heading());
    image(img, 0, 0, s, s);
    popMatrix();
  }
}