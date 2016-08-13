public class Petal {
  private int posX;

  private int posY;

  private double sketchA;

  private double sketchB;

  private int startAngle;

  private int angle;

  private final Bloom bloom;

  private double growFactor;

  private double radius;

  public Petal(int posX, int posY, double sketchA, double sketchB, int startAngle, int angle, Bloom bloom, double growFactor) {
    this.posX = posX;
    this.posY = posY;
    this.sketchA = sketchA;
    this.sketchB = sketchB;
    this.startAngle = startAngle;
    this.angle = angle;
    this.bloom = bloom;
    this.growFactor = growFactor;
    this.radius = 1;
  }

  public void drawNow(){
    float v1x = (float) Utils.rotateX(0, this.radius, Utils.degrad(this.startAngle));
    float v1y = (float) Utils.rotateY(0, this.radius, Utils.degrad(this.startAngle));
    float v2x = (float) Utils.rotateX(v1x, v1y, Utils.degrad(this.angle));
    float v2y = (float) Utils.rotateY(v1x, v1y, Utils.degrad(this.angle));
    float v3x = (float) (v1x * this.sketchA);
    float v3y = (float) (v1y * this.sketchA);
    float v4x = (float) (v2x * this.sketchB);
    float v4y = (float) (v2y * this.sketchB);
    fill(this.bloom.getColour());
    noStroke();
    bezier(v1x + posX, v1y + posY, v3x + posX, v3y + posY, v4x + posX, v4y + posY, v2x + posX, v2y + posY);
  }

  public void move() {
    if (this.radius <= this.bloom.getRadius()) {
      this.radius += this.growFactor; // / 10;
    }
  }

  public boolean isDrawable() {
    return (this.radius <= this.bloom.getRadius());
  }

  public void draw() {
    if (this.radius <= this.bloom.getRadius()) {
      this.drawNow();
    }
  }
}
