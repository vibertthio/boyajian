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


  void allSizeBang() {
    for (int i = 0; i < n; i++) {
      for (int j = 0; j < n; j++) {
        recs[i * n + j].sizeBang();
      }
    }
  }
  void rowSizeBang(int r) {
    for (int i = 0; i < n; i++) {
      recs[i * n + r].sizeBang();
    }
  }
  void colAngleBang(int c) {
    for (int j = 0; j < n; j++) {
      recs[c * n + j].angleBang();
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
    canvas.popMatrix();
  }

  void sizeBang() {
    length = grid.length * random(1.5, 1.7);
  }

  void angleBang() {
    // length *= random(1.5, 2.5);
    angle = targetAngle * 2;
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
      blinkCount--;
      if (blinkCount <= 0) {
        blinking = false;
      }
    }
  }

}
