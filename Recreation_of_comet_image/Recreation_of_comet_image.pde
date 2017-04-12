Comet comet;
PImage trail;
PImage smoke;
PImage background;

//Main particle trail
color[] gradient1 = {
  0xa0ff8040, 
  0x40ffffff,
  0x00ffffff
};

//Smoke
color[] gradient2 = {
  0x20a099ff
};
//Smoke center
color[] gradient3 = {
  0x40a099ff
};
//Dots
color[] gradient4 = {
  0xffffffff
};

void setup() {
  size(800, 800, P2D);
  imageMode(CENTER);
  noStroke();

  comet = new Comet(width/2, height/2, random(TWO_PI), 230);

  PGraphics g = createGraphics((int)comet.size + 20, (int)comet.size + 20);
  g = createGraphics(width, height);
  g.beginDraw();
  g.clear();
  g.background(10, 0, 30);
  g.noStroke();
  for (float x = 0; x<width; x += 2) {
    for (float y = 0; y<height; y += 2) {
      float n = noise(x/300, y/300);
      g.fill(color(150, 0, 255), n * 255);
      g.rect(x, y, 2, 2);
    }
  }
  g.endDraw();
  background = g.get();

  trail = loadImage("Trail.png");
  smoke = loadImage("Smoke.png");
}

void draw() {
  background(10, 0, 30);
  tint(255, 80);
  //image(background, width/2, height/2);
  comet.update();
  comet.draw();
}

void keyReleased() {
  save("Comet.png");
}