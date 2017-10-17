//VisualGrowGrid.pde
class GrowGrid {
  PGraphics canvas;
  GrowRectangle[] recs;
  int time;
  float low = 50;
  float high = 120;
  float length;

  int n = 8;
  int unit = 100;
  color col;

  float highValue = 0;
  float lowValue = 0;
  int lowBufferCount = 0;
  int lowBufferLimit = 30;

  GrowGrid(PGraphics _c, color _col) {
    canvas = _c;
    time = 0;
    col = _col;
    highValue = chhigh;
    lowValue = chlow;
    recs = new GrowRectangle[n * n];
    for (int i = 0; i < n; i++) {
      for (int j = 0; j < n; j++) {
        recs[i * n + j] = new GrowRectangle(this, _c, i * unit, j * unit);
      }
    }
  }

  void draw() {
    update();
    render();
  }
  void update() {
    time++;
    lowBufferCount++;
    float rate = sin(0.005 * PI * time) * sin(0.005 * PI * time);
    length = low + (high - low) * rate;

    if (highValue != chhigh) {
      highValue = chhigh;
      println("high trigger!");
      randomVibrateBang();

    }
    if (lowValue != chlow) {
      lowValue = chlow;
      if (lowBufferCount >= lowBufferLimit) {
        lowBufferCount = 0;
        println("low trigger!");
        allSizeBang();
      }
    }
    if (random(1) < 0.1) {
      randomBlinkBang();
    }
  }
  void render() {
    for (int i = 0; i < n; i++) {
      for (int j = 0; j < n; j++) {
        recs[i * n + j].draw();
      }
    }
  }

  void allSizeBang() {
    for (int i = 0; i < n; i++) {
      for (int j = 0; j < n; j++) {
        recs[i * n + j].sizeBang();
      }
    }
  }
  void allAngleShiftBang() {
    for (int i = 0; i < n; i++) {
      for (int j = 0; j < n; j++) {
        recs[i * n + j].angleShiftBang();
      }
    }
  }
  void allRotateBang() {
    for (int i = 0; i < n; i++) {
      for (int j = 0; j < n; j++) {
        recs[i * n + j].rotateBang();
      }
    }
  }
  void allRotateBang(int amt) {
    for (int i = 0; i < n; i++) {
      for (int j = 0; j < n; j++) {
        recs[i * n + j].rotateBang(amt);
      }
    }
  }
  void allBlinkBang() {
    for (int i = 0; i < n; i++) {
      for (int j = 0; j < n; j++) {
        recs[i * n + j].blinkBang();
      }
    }
  }
  void allCordTrigger() {
    for (int i = 0; i < n; i++) {
      for (int j = 0; j < n; j++) {
        recs[i * n + j].cordTrigger();
      }
    }
  }
  void rowSizeBang(int r) {
    for (int i = 0; i < n; i++) {
      recs[i * n + r].sizeBang();
    }
  }
  void rowAngleShiftBang() {
    for (int i = 0; i < n; i++) {
      for (int j = 0; j < n; j++) {
        recs[i * n + j].angleShiftBang();
      }
    }
  }
  void rowRotateBang(int r) {
    for (int i = 0; i < n; i++) {
      recs[i * n + r].rotateBang();
    }
  }
  void rowRotateBang(int r, int amt) {
    for (int i = 0; i < n; i++) {
      recs[i * n + r].rotateBang(amt);
    }
  }
  void rowBlinkBang(int r) {
    for (int i = 0; i < n; i++) {
      recs[i * n + r].blinkBang();
    }
  }
  void colAngleShiftBang(int c) {
    for (int j = 0; j < n; j++) {
      recs[c * n + j].angleShiftBang();
    }
  }

  void randomBlinkBang() {
    int x = floor(random(n));
    int y = floor(random(n));
    recs[x * n + y].blinkBang();
  }
  void randomSizeBang() {
    int x = floor(random(n));
    int y = floor(random(n));
    recs[x * n + y].sizeBang();
  }
  void randomVibrateBang() {
    int x = floor(random(n));
    int y = floor(random(n));
    recs[x * n + y].vibrateBang();
  }

}

class GrowRectangle {
  GrowGrid grid;
  PGraphics canvas;
  float xpos;
  float ypos;
  float length;
  float targetAngle = PI * .25;
  float angle = PI * .25;

  color col;

  GrowRectangle(GrowGrid _g, PGraphics _c, float _x, float _y) {
    grid = _g;
    canvas = _c;
    xpos = _x;
    ypos = _y;
    col = _g.col;
  }

  void draw() {
    update();
    render();
  }
  void update() {
    vibrateUpdate();
    blinkUpdate();
    lengthUpdate();
    angleUpdate();
    cordUpdate();
  }
  void render() {
    canvas.pushMatrix();
    canvas.translate(300, 300);
    canvas.noStroke();
    canvas.fill(col, map(layer[6],115,0,0,255));
    canvas.rectMode(CENTER);
    canvas.translate(xpos, ypos);
    if (vibrateCount > 0) {
      canvas.translate(random(-5, 5), random(-5, 5));
    }
    canvas.rotate(angle);
    canvas.rect(0, 0, length, length);
    cordRender();
    canvas.popMatrix();
  }

  void lengthUpdate() {
    if (abs(length - grid.length) < 1) {
      length = grid.length;
    } else {
      length = length + (grid.length - length) * 0.1;
    }
  }
  void angleUpdate() {
    if (abs(targetAngle - angle) < 0.05) {
      angle = targetAngle;
    } else {
      angle = angle + (targetAngle - angle) * 0.1;
    }
  }

  void sizeBang() {
    length = grid.length * random(1.5, 1.7);
  }
  void angleShiftBang() {
    angle = targetAngle * 2;
  }
  void rotateBang() {
    if (targetAngle < PI) {
      targetAngle += PI;
    } else {
      targetAngle -= PI;
    }
  }
  void rotateBang(int amt) {
    if (targetAngle < PI) {
      targetAngle += amt * PI;
    } else {
      targetAngle -= amt * PI;
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
      length = grid.length * random(0.5, 1.5);
      blinkCount--;
      if (blinkCount <= 0) {
        blinking = false;
        col = grid.col;
      }
    }
  }

  boolean cording = false;
  float cordLength = 0;
  void cordTrigger() {
    cording = !cording;
  }
  void cordUpdate() {
    if (cording) {
      cordLength = grid.high - grid.length;
    }
  }
  void cordRender() {
    if (cording) {
      canvas.strokeWeight(4);
      canvas.stroke(col, map(layer[6],115,0,0,255));
      canvas.line(0, 0, cordLength, 0);
      canvas.rotate(PI * 0.5);
      canvas.line(0, 0, cordLength, 0);
      canvas.noStroke();
      canvas.fill(col, map(layer[6],115,0,0,255));
      canvas.rect(cordLength, 0, cordLength * 0.5, cordLength * 0.5);
    }
  }
}
