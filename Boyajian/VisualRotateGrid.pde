//VisualRotateGrid.pde
class RotateGrid {
  PGraphics canvas;
  RotateRectangle[] recs;
  boolean playing;
  int n = 20;
  float low = 10;
  float high = low * 8;
  int unit = floor(high - low);
  float time = 240;

  float w;
  float h;
  float angle;
  color col;

  RotateGrid(PGraphics _c, color _col) {
    canvas = _c;
    col = _col;
    recs = new RotateRectangle[n * n];
    for (int i = 0; i < n; i++) {
      for (int j = 0; j < n; j++) {
        boolean v = ((j % 2) == 0);
        if (v) {
          recs[i * n + j] = new RotateRectangle(_c, this, i * unit, j * unit * 0.5, true);
        } else {
          recs[i * n + j] = new RotateRectangle(_c, this, i * unit + 0.5 * unit, j * unit * 0.5, false);
        }
      }
    }
  }

  void draw() {
    update();
    render();
  }
  void update() {
    angle = 2 * PI * (time / 960);
    w =  (high - low) * sin(angle) * sin(angle) + low;
    h =  (high - low) * cos(angle) * cos(angle) + low;
    time++;
  }
  void render() {
    for (int i = 0; i < n * n; i++) {
      recs[i].draw();
    }
  }
}

class RotateRectangle {
  PGraphics canvas;
  RotateGrid grid;
  float xpos;
  float ypos;
  float high;
  float low;
  float w;
  float h;
  float angle;
  boolean vr = true;

  RotateRectangle(PGraphics _c, RotateGrid _g, float _x, float _y) {
    init(_c, _g, _x, _y);
  }
  RotateRectangle(PGraphics _c, RotateGrid _g, float _x, float _y, boolean _v) {
    init(_c, _g, _x, _y);
    vr = _v;
  }
  void init(PGraphics _c, RotateGrid _g, float _x, float _y) {
    canvas = _c;
    grid = _g;
    xpos = _x;
    ypos = _y;
    w = 40;
    h = 40;
    high = _g.high;
    low = _g.low;
  }

  void draw() {
    update();
    render();
  }
  void update() {
    angle = grid.angle;
    w = grid.w;
    h = grid.h;
  }
  void render() {
    canvas.pushMatrix();
    canvas.translate(300, 300);
    canvas.noStroke();
    canvas.fill(grid.col,map(layer[6],135,255,0,255));
    canvas.rectMode(CENTER);
    canvas.translate(xpos, ypos);
    canvas.rotate(vr ? angle : (angle + (PI * .5)));
    canvas.rect(0, 0, w, h);
    canvas.popMatrix();
  }
}
