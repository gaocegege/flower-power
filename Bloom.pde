import java.util.Random;
import java.util.List;

public class Bloom {
  private int positionX;

  private int positionY;

  private int radius;

  private color colour;

  private int petalCount;

  private List<Petal> petals;

  public Bloom(int positionX, int positionY, int radius, color colour, int petalCount) {
    this.positionX = positionX;
    this.positionY = positionY;
    this.radius = radius;
    this.colour = colour;
    this.petalCount = petalCount;
    this.petals = new ArrayList<Petal>();
  }

  public void move() {
    for (int i = 0; i < this.petals.size(); ++i) {
      Petal p = this.petals.get(i);
      p.move();
    }
  }

  public boolean isDrawable() {
    boolean res = true;
    for (int i = 0; i < this.petals.size(); ++i) {
      res = res & this.petals.get(i).isDrawable();
    }
    return res;
  }

  public void draw() {
    for (int i = 0; i < this.petals.size(); ++i) {
      Petal p = this.petals.get(i);
      p.draw();
    }
  }

  public void setTranslate() {
    translate(this.positionX, this.positionY);
  }

  public double getRadius() {
    return this.radius;
  }

  public int getPetalCount() {
    return this.petalCount;
  }

  public void pushPetal(Petal p) {
    this.petals.add(p);
  }

  private color getColour() {
    return this.colour;
  } 
}
