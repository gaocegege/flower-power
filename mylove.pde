String xrwImg = "./data/xrw.jpg";
PImage photo;

float offsetX = 500;
float offsetY = 400;
List<Bloom> blooms;

FlowerSystem fs;

void setup() {
  frameRate(1);
  fs = new FlowerSystem();
  size(1000, 800);
  photo = loadImage(xrwImg);
  photo.filter(THRESHOLD);
  photo.loadPixels();
  for (int i = 0; i < photo.width; i = i + 6) {
    for (int j = 0; j < photo.height; j = j + 6) {
       if (photo.pixels[j * photo.height + i] == color(0, 0, 0)) {
         fs.addBloom(createBloom(i, j, bloomRadius, color(24, 42, 45), petalCount));
       }
    }
  }
}

void draw() {
  fs.move();
  fs.draw();
}