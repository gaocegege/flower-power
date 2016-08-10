String xrwImg = "./data/xrw.jpg";
PImage photo;

Bloom b;
Bloom c;

void setup() {
  size(1000, 800);
  photo = loadImage(xrwImg);
  b = createBloom(500, 200, bloomRadius, color(24, 42, 45), petalCount);
  c = createBloom(111, 200, bloomRadius, color(24, 42, 45), petalCount);
}

void draw() {
  b.draw();
  c.draw();
}