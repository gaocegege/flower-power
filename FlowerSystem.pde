public class FlowerSystem{
	private List<Bloom> blooms;

	public FlowerSystem() {
		blooms = new ArrayList<Bloom>();
	}

	public void addBloom(Bloom b) {
		this.blooms.add(b);
	}

  public void move() {
    for (int i = 0; i < this.blooms.size(); ++i) {
      this.blooms.get(i).move();
    }
  }

	public void draw() {
    for (int i = 0; i < this.blooms.size(); ++i) {
      if (this.blooms.get(i).isDrawable() == true) {
        println(i, this.blooms.size());
        this.blooms.get(i).draw();
      } else {
        println(i, "remove");
        this.blooms.remove(i);
      }
    }
	}
}