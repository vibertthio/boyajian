class GrowGrid {
  PGraphics canvas;
  int time;
  float low = 55;
  float high = 65;
  float length;

  int n = 15;
  int unit = 60;
  color col;

  GrowGrid(PGraphics _c, color _col) {
    canvas = _c;
    time = 0;
    col = _col;
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
    canvas.pushMatrix();
    canvas.translate(300, 300);
    canvas.noStroke();
    canvas.fill(col, 100);
    canvas.rectMode(CENTER);
    canvas.translate(x, y);
    canvas.rotate(PI * .25);
    canvas.rect(0, 0, length, length);
    canvas.popMatrix();
  }

}
