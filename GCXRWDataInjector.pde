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
          fs.addBloom(createBloom(i + offsetX, j + offsetY, bloomRadius, c, petalCount));
        }
      }
    }
  }
}
