class RotateGrid {
  Rectangle[] recs;
  boolean playing;
  int n = 30;
  float low = 10;
  float high = low * 8;
  int unit = floor(high - low);
  float time = 240;

  float w;
  float h;
  float angle;

  color col;

  RotateGrid(color _c) {
    col = _c;
    recs = new Rectangle[n * n];
    for (int i = 0; i < n; i++) {
      for (int j = 0; j < n; j++) {
        boolean v = ((j % 2) == 0);
        if (v) {
          recs[i * n + j] = new Rectangle(this, i * unit, j * unit * 0.5, true);
        } else {
          recs[i * n + j] = new Rectangle(this, i * unit + 0.5 * unit, j * unit * 0.5, false);
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

    // w =  (high - low) * (sin(a * 2 + PI * 0.5) + 1) * 0.5 + low;
    // h =  high + low - w;

    time++;
  }

  void render() {
    for (int i = 0; i < n * n; i++) {
      recs[i].draw();
    }
  }
}

class Rectangle {
  RotateGrid grid;
  float xpos;
  float ypos;
  float high;
  float low;
  float w;
  float h;
  float angle;


  boolean vr = true;

  Rectangle(RotateGrid _g, float _x, float _y) {
    init(_g, _x, _y);
  }

  Rectangle(RotateGrid _g, float _x, float _y, boolean _v) {
    init(_g, _x, _y);
    vr = _v;
  }

  void init(RotateGrid _g, float _x, float _y) {
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
    pushMatrix();
    noStroke();
    fill(grid.col, 100);
    rectMode(CENTER);
    translate(xpos, ypos);
    rotate(vr ? angle : (angle + (PI * .5)));
    rect(0, 0, w, h);
    popMatrix();
  }
}