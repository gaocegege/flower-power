import java.util.Random;
import java.util.List;

Bloom createBloom(int positionX, int positionY, int radius, color colour, int petalCount) {
  Bloom b = new Bloom(positionX, positionY, radius, colour, petalCount);  
    
  int angle = 360 / b.getPetalCount();
  int startAngle = randInt(0, 90);
  for (int i = 0; i < b.getPetalCount(); i++) {
    b.pushPetal(new Petal(petalStretch, petalStretch, startAngle + i * angle, angle, b, growFactor));
  }
  return b;
}

static int randInt(int min, int max) {
  Random rand = new Random();

  // nextInt is normally exclusive of the top value,
  // so add 1 to make it inclusive
  int randomNum = rand.nextInt((max - min) + 1) + min;

  return randomNum;
}

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

	public void draw() {
    translate(this.positionX, this.positionY);
    boolean isFinished = false;
		for (int i = 0; i < this.petals.size(); ++i) {
			Petal p = this.petals.get(i);
			p.draw();
			isFinished &= p.getIsFinished();
		}
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
}