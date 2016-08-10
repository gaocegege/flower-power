public class Petal {
	private double sketchA;

	private double sketchB;

	private int startAngle;

	private int angle;

	private final Bloom bloom;

	private double growFactor;

	private double radius;

	private boolean isFinished = false;

	public Petal(double sketchA, double sketchB, int startAngle, int angle, Bloom bloom, double growFactor) {
		this.sketchA = sketchA;
		this.sketchB = sketchB;
		this.startAngle = startAngle;
		this.angle = angle;
		this.bloom = bloom;
		this.growFactor = growFactor;
		this.radius = 1;
	}

  public void drawNow(){
    float v1x = (float) rotateX(0, this.radius, degrad(this.startAngle));
    float v1y = (float) rotateY(0, this.radius, degrad(this.startAngle));
    float v2x = (float) rotateX(v1x, v1y, degrad(this.angle));
    float v2y = (float) rotateY(v1x, v1y, degrad(this.angle));
    float v3x = (float) (v1x * this.sketchA);
    float v3y = (float) (v1y * this.sketchA);
    float v4x = (float) (v1x * this.sketchB);
    float v4y = (float) (v1y * this.sketchB);
    bezier(v1x, v1y, v2x, v2y, v3x, v3y, v4x, v4y);
  }

	public void draw() {
		if (this.radius <= this.bloom.getRadius()) {
			this.radius += this.growFactor; // / 10;
			this.drawNow();
		} else {
			this.isFinished = true;
		}
	}

  public boolean getIsFinished() {
    return this.isFinished;
  }
}