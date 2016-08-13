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