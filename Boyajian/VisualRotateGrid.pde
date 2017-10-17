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
    for (int i = 0, m = n * n; i < m; i++) {
      recs[i].draw();
    }
  }

  void allAngleShiftBang() {
    for (int i = 0, m = n * n; i < m; i++) {
      recs[i].angleShiftBang();
    }
  }
  void allAngleShiftBang(int amt) {
    for (int i = 0, m = n * n; i < m; i++) {
      recs[i].angleShiftBang(amt);
    }
  }
  void allStretchBang() {
    if (w > h) {
      allWidthBang();
    } else {
      allHeightBang();
    }
  }
  void allWidthBang() {
    for (int i = 0, m = n * n; i < m; i++) {
      recs[i].widthBang();
    }
  }
  void allWidthBang(float amt) {
    for (int i = 0, m = n * n; i < m; i++) {
      recs[i].widthBang(amt);
    }
  }
  void allHeightBang() {
    for (int i = 0, m = n * n; i < m; i++) {
      recs[i].heightBang();
    }
  }
  void allHeightBang(float amt) {
    for (int i = 0, m = n * n; i < m; i++) {
      recs[i].heightBang(amt);
    }
  }
  void allColorBang() {
    for (int i = 0, m = n * n; i < m; i++) {
      recs[i].colorBang();
    }
  }
}

class RotateRectangle {
  PGraphics canvas;
  RotateGrid grid;

  // display
  float xpos;
  float ypos;
  float w;
  float h;
  float angle;
  float alpha;
  color col;

  // logic
  float xorg;
  float yorg;
  float worg;
  float horg;
  float targetAngle;
  float targetAlpha;
  float colorRatio = 0;
  color originalColor;
  color targetColor;
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
    xorg = _x;
    ypos = _y;
    yorg = _y;
    w = 40;
    h = 40;
    col = _g.col;
    targetColor = _g.col;
    originalColor = _g.col;
  }

  void draw() {
    update();
    render();
  }
  void update() {
    angleUpdate();
    alphaUpdate();
    sizeUpdate();
    colorUpdate();
  }
  void render() {
    canvas.pushMatrix();
    canvas.translate(300, 300);
    canvas.noStroke();
    canvas.fill(col, alpha);
    canvas.rectMode(CENTER);
    canvas.translate(xpos, ypos);
    canvas.rotate(vr ? angle : (angle + (PI * .5)));
    canvas.rect(0, 0, w, h);
    // canvas.rect(0, 0, h, w);
    canvas.popMatrix();
  }

  void angleUpdate() {
    targetAngle = grid.angle;
    if (abs(targetAngle - angle) < 0.05) {
      angle = targetAngle;
    } else {
      angle = angle + (targetAngle - angle) * 0.1;
    }
  }
  void alphaUpdate() {
    targetAlpha = map(layer[6], 135, 255, 0, 255);
    if (abs(targetAlpha - alpha) < 0.05) {
      alpha = targetAlpha;
    } else {
      alpha = alpha + (targetAlpha - alpha) * 0.1;
    }
  }
  void sizeUpdate() {
    worg = grid.w;
    horg = grid.h;

    if (abs(worg - w) < 1) {
      worg = w;
    } else {
      w = w + (worg - w) * 0.1;
    }

    if (abs(horg - h) < 1) {
      horg = h;
    } else {
      h = h + (horg - h) * 0.1;
    }
  }
  void colorUpdate() {
    if (colorRatio < 0.05) {
      colorRatio = 0;
      col = originalColor;
    } else {
      colorRatio *= 0.9;
      col = lerpColor(
        originalColor,
        targetColor,
        colorRatio
      );
    }
  }

  void angleShiftBang() {
    angle = targetAngle - PI;
  }
  void angleShiftBang(int amt) {
    angle = targetAngle - amt * PI;
  }
  void widthBang() {
    w *= random(1.5, 3.5);
  }
  void widthBang(float amt) {
    w *= amt;
  }
  void heightBang() {
    h *= random(1.5, 3.5);
  }
  void heightBang(float amt) {
    h *= amt;
  }
  void colorBang() {
    targetColor = colors[floor(random(colors.length))];
    colorRatio = 1;
  }
  void colorBang(int index) {
    int id = index % colors.length;
    targetColor = colors[id];
    colorRatio = 1;
  }
}
