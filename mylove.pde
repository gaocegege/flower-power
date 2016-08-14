String xrwImg = "./data/xrw.jpg";
PImage photo;

List<Bloom> blooms;

FlowerSystem fs;
GCXRWDataInjector dataInjector;

int c = color(24, 42, 45);

void setup() {
  size(1000, 800);
  background(255, 255, 255, 2);

  // Create FlowerSystem and inject data to it.
  fs = new FlowerSystem();
  dataInjector = new GCXRWDataInjector(null, loadImage(xrwImg), fs);
  dataInjector.injectData();
}

void draw() {
  fs.move();
  fs.draw();
}
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
/**
 *  FlowerSystem, store all the blooms and draw them.
 *
 *	@author gaocegege
 *	@since  13.08.2016
 */
public class FlowerSystem{

  private List<Bloom> blooms;
  
  private List<Bloom> worker;

  public FlowerSystem() {
    blooms = new ArrayList<Bloom>();
    worker = new ArrayList<Bloom>();
  }

  public void addBloom(Bloom b) {
    this.blooms.add(b);
  }

  public void move() {
    for (int i = 0; i < this.worker.size(); ++i) {
      this.worker.get(i).move();
    }
  }

  public void draw() {
    if (blooms.size() != 0) {
      worker.add(blooms.get(0));
      blooms.remove(0);
    }
    for (int i = 0; i < this.worker.size(); ++i) {
      if (this.worker.get(i).isDrawable() == true) {
        this.worker.get(i).draw();
      } else {
        this.worker.remove(i);
      }
    }
  }
}
/**
 *  Data Injecttor
 *
 *	@author gaocegege
 *	@since  13.08.2016
 */
public class GCXRWDataInjector {
  private FlowerSystem fs;

  private PImage gaocegege;

  private PImage xrw;

  public GCXRWDataInjector(PImage gaocegege, PImage xrw, FlowerSystem fs) {
    this.xrw = xrw;
    this.gaocegege = gaocegege;
    this.fs = fs;
  }

  /**
   *  Inject blooms to FlowerSystem
   *
   *	@author gaocegege
   *	@since  13.08.2016
   */
  public void injectData() {
    int offsetX = 0;
    if (gaocegege != null) {
      parseImage(gaocegege);
      offsetX = gaocegege.width;
    }

    if (xrw != null) {
      parseImageWithOffset(xrw, offsetX, 0);
    }
  }

  /**
   *  Parse the photo and add blooms to FlowerSystem.
   *
   *	@author gaocegege
   *	@since  13.08.2016
   */
  private void parseImage(PImage photo) {
    parseImageWithOffset(photo, 0, 0);
  }

  /**
   *  Parse the photo with offset and add blooms to FlowerSystem.
   *
   *	@author gaocegege
   *	@since  13.08.2016
   */
  private void parseImageWithOffset(PImage photo, int offsetX, int offsetY) {
    photo.filter(THRESHOLD);
    photo.loadPixels();
    for (int i = 0; i < photo.width; i = i + 6) {
      for (int j = 0; j < photo.height; j = j + 6) {
        if (photo.pixels[j * photo.height + i] == color(0, 0, 0)) {
          fs.addBloom(createBloom(i + offsetX, j + offsetY, Utils.randInt(Utils.BLOOMRADIUSMIN, Utils.BLOOMRADIUSMAX), 
          randomColor(), Utils.randInt(Utils.PETALCOUNTMIN, Utils.PETALCOUNTMAX)));
        }
      }
    }
  }
}
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
public static class Utils {
  static final int PETALCOUNTMIN = 8;
  static final int PETALCOUNTMAX = 10;

  static final double PETALSCRACHMIN = 0.1;
  static final double PETALSCRACHMAX = 3;

  static final double GROWFACTORMIN = 0.1;
  static final double GROWFACTORMAX = 1;

  static final int BLOOMRADIUSMIN = 8;
  static final int BLOOMRADIUSMAX = 10;

  static final double CIRCLE = Math.PI * 2;

  static final int RMIN = 128;
  static final int RMAX = 255;
  static final int GMIN = 0;
  static final int GMAX = 128;
  static final int BMIN = 0;
  static final int BMAX = 128;
  static final float OPACITY = 100;

  static double rotateX(double x, double y, double theta) {
    return Math.cos(theta) * x - Math.sin(theta) * y;
  }

  static double rotateY(double x, double y, double theta) {
    return Math.sin(theta) * x + Math.cos(theta) * y;
  }

  static double degrad(double angle) {
    return CIRCLE / 360 * angle;
  }

  static double raddeg(double angle) {
    return angle / CIRCLE * 360;
  }

  static int randInt(int min, int max) {
    Random rand = new Random();

    // nextInt is normally exclusive of the top value,
    // so add 1 to make it inclusive
    int randomNum = rand.nextInt((max - min) + 1) + min;

    return randomNum;
  }

  static double randDouble(double min, double max) {
    Random rand = new Random();

    double randomNum = rand.nextDouble() * (max - min) + min;

    return randomNum;
  }
}

int randomColor() {
    int r = Utils.randInt(Utils.RMIN, Utils.RMAX);
    int g = Utils.randInt(Utils.GMIN, Utils.GMAX);
    int b = Utils.randInt(Utils.BMIN, Utils.BMAX);

    int limit = 5;
    if (Math.abs(r - g) <= limit && Math.abs(g - b) <= limit && Math.abs(b - r) <= limit) {
      return randomColor();
    } else {
      return color(r, g, b, Utils.OPACITY);
    }    
  }

Bloom createBloom(int positionX, int positionY, int radius, color colour, int petalCount) {
  Bloom b = new Bloom(positionX, positionY, radius, colour, petalCount);  
    
  int angle = 360 / b.getPetalCount();
  int startAngle = Utils.randInt(0, 90);
  for (int i = 0; i < b.getPetalCount(); i++) {
    b.pushPetal(new Petal(positionX, positionY, 
    Utils.randDouble(Utils.PETALSCRACHMIN, Utils.PETALSCRACHMAX), 
    Utils.randDouble(Utils.PETALSCRACHMIN, Utils.PETALSCRACHMAX),
    startAngle + i * angle, angle, b, 
    Utils.randDouble(Utils.GROWFACTORMIN, Utils.GROWFACTORMAX)));
  }
  return b;
}

