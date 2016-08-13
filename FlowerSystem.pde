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
