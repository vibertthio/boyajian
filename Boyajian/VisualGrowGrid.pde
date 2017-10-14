//VisualGrowGrid.pde
class GrowGrid {
  PGraphics canvas;
  int time;
  float low = 50;
  float high = 120;
  float length;

  int n = 8;
  int unit = 100;
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
    canvas.fill(col, map(layer[6],115,0,0,255));
    canvas.rectMode(CENTER);
    canvas.translate(x, y);
    canvas.rotate(PI * .25);
    canvas.rect(0, 0, length, length);
    canvas.popMatrix();
  }
}
