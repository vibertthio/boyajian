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
  float speed = 1;
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
    motionUpdate();

    // rows
    rowRotateSequenceUpdate();
    rowXShiftSequenceUpdate();
    rowBlinkSequenceUpdate();

    // cols
    colRotateSequenceUpdate();
    colBlinkSequenceUpdate();
  }
  void render() {
    for (int i = 0, m = n * n; i < m; i++) {
      recs[i].draw();
    }
  }
  void motionUpdate() {
    angle = 2 * PI * (time / 960);
    w =  (high - low) * sin(angle) * sin(angle) + low;
    h =  (high - low) * cos(angle) * cos(angle) + low;
    time += speed;
  }
  void adjustSpeed(float _s) {
    speed = _s;
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
  void allStretchBang(float amt) {
    if (w > h) {
      allWidthBang(amt);
    } else {
      allHeightBang(amt);
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
  void allXShiftBang() {
    for (int i = 0, m = n * n; i < m; i++) {
      recs[i].xShiftBang();
    }
  }
  void allYShiftBang() {
    for (int i = 0, m = n * n; i < m; i++) {
      recs[i].yShiftBang();
    }
  }
  void allVibrateBang() {
    for (int i = 0, m = n * n; i < m; i++) {
      recs[i].vibrateBang();
    }
  }
  void allBlinkBang() {
    for (int i = 0, m = n * n; i < m; i++) {
      recs[i].blinkBang();
    }
  }

  // visible rows: 2 - 10
  void rowAngleShiftBang(int r) {
    for (int i = 0; i < n; i++) {
      recs[i * n + r].angleShiftBang();
    }
  }
  void rowAngleShiftBang(int r, int amt) {
    for (int i = 0; i < n; i++) {
      recs[i * n + r].angleShiftBang(amt);
    }
  }
  void rowStretchBang(int r) {
    if (w > h) {
      allWidthBang(r);
    } else {
      allHeightBang(r);
    }
  }
  void rowStretchBang(int r, float amt) {
    if (w > h) {
      rowWidthBang(r, amt);
    } else {
      rowHeightBang(r, amt);
    }
  }
  void rowWidthBang(int r) {
    for (int i = 0; i < n; i++) {
      recs[i * n + r].widthBang();
    }
  }
  void rowWidthBang(int r, float amt) {
    for (int i = 0; i < n; i++) {
      recs[i * n + r].widthBang(amt);
    }
  }
  void rowHeightBang(int r) {
    for (int i = 0; i < n; i++) {
      recs[i * n + r].heightBang();
    }
  }
  void rowHeightBang(int r, float amt) {
    for (int i = 0; i < n; i++) {
      recs[i * n + r].heightBang(amt);
    }
  }
  void rowColorBang(int r) {
    for (int i = 0; i < n; i++) {
      recs[i * n + r].colorBang();
    }
  }
  void rowXShiftBang(int r) {
    for (int i = 0; i < n; i++) {
      recs[i * n + r].xShiftBang();
    }
  }
  void rowXShiftBang(int r, int amt) {
    for (int i = 0; i < n; i++) {
      recs[i * n + r].xShiftBang(amt);
    }
  }
  void rowYShiftBang(int r) {
    for (int i = 0; i < n; i++) {
      recs[i * n + r].yShiftBang();
    }
  }
  void rowYShiftBang(int r, int amt) {
    for (int i = 0; i < n; i++) {
      recs[i * n + r].yShiftBang(amt);
    }
  }
  void rowVibrateBang(int r) {
    for (int i = 0; i < n; i++) {
      recs[i * n + r].vibrateBang();
    }
  }
  void rowBlinkBang(int r) {
    for (int i = 0; i < n; i++) {
      recs[i * n + r].blinkBang();
    }
  }

  // visible columns: 6 - 8
  void colAngleShiftBang(int c) {
    for (int j = 0; j < n; j++) {
      recs[c * n + j].angleShiftBang();
    }
  }
  void colAngleShiftBang(int c, int amt) {
    for (int j = 0; j < n; j++) {
      recs[c * n + j].angleShiftBang(amt);
    }
  }
  void colStretchBang(int c) {
    if (w > h) {
      colWidthBang(c);
    } else {
      colHeightBang(c);
    }
  }
  void colStretchBang(int c, float amt) {
    if (w > h) {
      colWidthBang(c, amt);
    } else {
      colHeightBang(c, amt);
    }
  }
  void colWidthBang(int c) {
    for (int j = 0; j < n; j++) {
      recs[c * n + j].widthBang();
    }
  }
  void colWidthBang(int c, float amt) {
    for (int j = 0; j < n; j++) {
      recs[c * n + j].widthBang(amt);
    }
  }
  void colHeightBang(int c) {
    for (int j = 0; j < n; j++) {
      recs[c * n + j].heightBang();
    }
  }
  void colHeightBang(int c, float amt) {
    for (int j = 0; j < n; j++) {
      recs[c * n + j].heightBang(amt);
    }
  }
  void colColorBang(int c) {
    for (int j = 0; j < n; j++) {
      recs[c * n + j].colorBang();
    }
  }
  void colXShiftBang(int c) {
    for (int j = 0; j < n; j++) {
      recs[c * n + j].xShiftBang();
    }
  }
  void colYShiftBang(int c) {
    for (int j = 0; j < n; j++) {
      recs[c * n + j].yShiftBang();
    }
  }
  void colVibrateBang(int c) {
    for (int j = 0; j < n; j++) {
      recs[c * n + j].vibrateBang();
    }
  }
  void colBlinkBang(int c) {
    for (int j = 0; j < n; j++) {
      recs[c * n + j].blinkBang();
    }
  }

  int[][] rowSequenceSet = {
    {3, 5, 7, 9},
    {3, 5, 7, 9},
    {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10},
    {10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0},
    {5, 6, 4, 7, 3, 8, 2, 9, 1, 10},
    {10, 2, 9, 3, 8, 4, 7, 5, 6},
  };
  int[][] colSequenceSet = {
    {6, 7, 8, 9},
    {9, 8, 7, 6},
    {6, 9, 7, 8},
    {7, 8, 6, 9},
  };

  Sequence rowRotateSequence = new Sequence(rowSequenceSet, 2);
  Sequence rowXShiftSequence = new Sequence(rowSequenceSet, 2);
  Sequence rowBlinkSequence = new Sequence(rowSequenceSet, 8);

  Sequence colRotateSequence = new Sequence(colSequenceSet, 8);
  Sequence colBlinkSequence = new Sequence(colSequenceSet, 8);

  void rowRotateSequenceUpdate() {
    rowRotateSequence.update();
    if (rowRotateSequence.getBang()) {
      int index = rowRotateSequence.getSignal();
      rowAngleShiftBang(index, 3);
    }
  }
  void rowXShiftSequenceUpdate() {
    rowXShiftSequence.update();
    if (rowXShiftSequence.getBang()) {
      int index = rowXShiftSequence.getSignal();
      rowXShiftBang(index, 2);
    }
  }
  void rowBlinkSequenceUpdate() {
    rowBlinkSequence.update();
    if (rowBlinkSequence.getBang()) {
      int index = rowBlinkSequence.getSignal();
      rowBlinkBang(index);
    }
  }

  void colRotateSequenceUpdate() {
    colRotateSequence.update();
    if (colRotateSequence.getBang()) {
      int index = colRotateSequence.getSignal();
      colAngleShiftBang(index, 3);
    }
  }
  void colBlinkSequenceUpdate() {
    colBlinkSequence.update();
    if (colBlinkSequence.getBang()) {
      int index = colBlinkSequence.getSignal();
      colBlinkBang(index);
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
  float xi;
  float yi;
  float xorg;
  float yorg;
  float worg;
  float horg;
  float targetAngle;
  float targetAlpha;
  float colorRatio = 0;
  float sizeUpdateRatio = 0.2;
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
    xi = _x;
    yi = _y;
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
    posUpdate();
    angleUpdate();
    alphaUpdate();
    sizeUpdate();
    colorUpdate();
    vibrateUpdate();
    blinkUpdate();
  }
  void render() {
    canvas.pushMatrix();
    canvas.translate(300, 300);
    canvas.noStroke();
    canvas.fill(col, alpha);
    canvas.rectMode(CENTER);
    canvas.translate(xpos, ypos);
    if (vibrateCount > 0) {
      canvas.translate(random(-10, 10), random(-10, 10));
    }
    canvas.rotate(vr ? angle : (angle + (PI * .5)));
    canvas.rect(0, 0, w, h);
    // canvas.rect(0, 0, h, w);
    canvas.popMatrix();
  }

  void posUpdate() {
    if (sq(xpos - xorg) + sq(ypos - yorg) > 3) {
      xpos = xpos + (xorg - xpos) * 0.1;
      ypos = ypos + (yorg - ypos) * 0.1;
    } else {
      xpos = xorg;
      ypos = yorg;
    }
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
    targetAlpha = map(layer[6], 135, 255, 0, 230);
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
      w = w + (worg - w) * sizeUpdateRatio;
    }

    if (abs(horg - h) < 1) {
      horg = h;
    } else {
      h = h + (horg - h) * sizeUpdateRatio;
    }
  }
  void colorUpdate() {
    if (colorRatio < 0.05) {
      colorRatio = 0;
      col = originalColor;
    } else {
      colorRatio *= 0.95;
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

  boolean xShifted = false;
  boolean yShifted = false;
  void xShiftBang() {
    if (xShifted) {
      xorg += grid.unit;
    } else {
      xorg -= grid.unit;
    }
    xShifted = !xShifted;
    xShiftLimitCheck();
  }
  void xShiftBang(int amt) {
    xorg += (amt * grid.unit);
    xShiftLimitCheck();
  }
  void xShiftReset() {
    xorg = xi;
  }
  void xShiftLimitCheck() {
    if (abs(xorg - xi) > grid.unit * 8) {
      xShiftReset();
    }
  }
  void yShiftBang() {
    if (yShifted) {
      yorg += grid.unit;
    } else {
      yorg -= grid.unit;
    }
    yShifted = !yShifted;
    yShiftLimitCheck();
  }
  void yShiftBang(int amt) {
    yorg += (amt * grid.unit);
    yShiftLimitCheck();
  }
  void yShiftReset() {
    yorg = yi;
  }
  void yShiftLimitCheck() {
    if (abs(yorg - yi) > grid.unit * 8) {
      yShiftReset();
    }
  }

  int vibrateCount = 0;
  void vibrateBang() {
    vibrateCount = 15;
  }
  void vibrateUpdate() {
    if (vibrateCount > 0) {
      vibrateCount--;
    }
  }

  boolean blinking = false;
  int blinkCount = 0;
  void blinkBang() {
    blinking = true;
    blinkCount = floor(random(10, 60));
  }
  void blinkUpdate() {
    if (blinking) {
      col = colors[floor(random(colors.length))];
      w = worg * random(1, 2);
      blinkCount--;
      if (blinkCount <= 0) {
        h = horg * random(1, 2);
        blinking = false;
        col = originalColor;
      }
    }
  }
}
