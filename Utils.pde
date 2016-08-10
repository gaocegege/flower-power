static final int petalCount = 10;
static final double petalStretch = 2;
static final double growFactor = 0.9;
static final int bloomRadius = 9;
static final double circle = Math.PI * 2;

double rotateX(double x, double y, double theta) {
  return Math.cos(theta) * x - Math.sin(theta) * y;
}

double rotateY(double x, double y, double theta) {
  return Math.sin(theta) * x + Math.cos(theta) * y;
}

double degrad(double angle) {
  return circle / 360 * angle;
}

double raddeg(double angle) {
  return angle / circle * 360;
}