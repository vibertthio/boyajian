class GridGrow {
  int time;
  float low = 45;
  float high = 60;
  float length;

  int n = 10;
  int unit = 50;
  color col;

  GridGrow(color _c) {
    time = 0;
    col = _c;
  }

  void draw() {
    update();
    render();
  }


  void update() {
    time++;
    float rate = sin(0.005 * PI * time) * sin(0.005 * PI * time);
    length = low + (high - low) * rate;
  }

  void render() {
    for (int i = 0; i < n; i++) {
      for (int j = 0; j < n; j++) {
        boolean v = ((j % 2) == 0);
          renderRect(i * unit, j * unit);
      }
    }
  }

  void renderRect(float x, float y) {
    pushMatrix();
    noStroke();
    fill(grid.col, 100);
    rectMode(CENTER);
    translate(x, y);
    rotate(PI * .25);
    rect(0, 0, length, length);
    popMatrix();
  }

}
