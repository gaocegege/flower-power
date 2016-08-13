public static class Utils {
  static final int petalCount = 9;
  static final double petalStretch = 2;
  static final double growFactor = 1.5;
  static final int bloomRadius = 8;
  static final double circle = Math.PI * 2;

  static double rotateX(double x, double y, double theta) {
    return Math.cos(theta) * x - Math.sin(theta) * y;
  }

  static double rotateY(double x, double y, double theta) {
    return Math.sin(theta) * x + Math.cos(theta) * y;
  }

  static double degrad(double angle) {
    return circle / 360 * angle;
  }

  static double raddeg(double angle) {
    return angle / circle * 360;
  }

  static int randInt(int min, int max) {
    Random rand = new Random();

    // nextInt is normally exclusive of the top value,
    // so add 1 to make it inclusive
    int randomNum = rand.nextInt((max - min) + 1) + min;

    return randomNum;
  }
}

Bloom createBloom(int positionX, int positionY, int radius, color colour, int petalCount) {
  Bloom b = new Bloom(positionX, positionY, radius, colour, petalCount);  
    
  int angle = 360 / b.getPetalCount();
  int startAngle = Utils.randInt(0, 90);
  for (int i = 0; i < b.getPetalCount(); i++) {
    b.pushPetal(new Petal(positionX, positionY, Utils.petalStretch, Utils.petalStretch, startAngle + i * angle, angle, b, Utils.growFactor));
  }
  return b;
}