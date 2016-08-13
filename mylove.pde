String xrwImg = "./data/xrw.jpg";
PImage photo;

List<Bloom> blooms;

FlowerSystem fs;
GCXRWDataInjector dataInjector;

void setup() {
  frameRate(1);
  size(1000, 800);

  // Create FlowerSystem and inject data to it.
  fs = new FlowerSystem();
  dataInjector = new GCXRWDataInjector(null, loadImage(xrwImg), fs);
  dataInjector.injectData();
}

void draw() {
  fs.move();
  fs.draw();
}
