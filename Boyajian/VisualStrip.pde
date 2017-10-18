//VisualStrip.pde
class Strips {
  Strip[] crossStrips;
  int nOfCrossStrips = 10;

  Strips(PGraphics _c) {
    init(_c);
  }
  void init(PGraphics _c) {
    crossStrips = new Strip[nOfCrossStrips];
    for (int i = 0; i < nOfCrossStrips; i++) {
      crossStrips[i] = new Strip(_c);
      crossStrips[i].drift = true;
    }
  }
  void draw() {
    update();
    render();
  }
  void update() {}
  void render() {
    for (int i = 0; i < nOfCrossStrips; i++) {
      crossStrips[i].draw();
    }
  }

  // all bang
  void allCrossStripsAngleShiftBang() {
    for (int i = 0; i < nOfCrossStrips; i++) {
      crossStrips[i].angleShiftBang();
    }
  }
}

// horizontal:
//   x -> 700 ~ 1000
//   y -> 350 ~ 650
// vertical:
//   x ->  400 ~  600
//   y -> -700 ~ -1000

class Strip {
  PGraphics canvas;
  float heightOfStrip = 15;
  float widthOfStrip = 15;
  float xstr;
  float xpos;
  float ypos;
  float xdes;
  float angle = 0;
  float targetAngle = 0;
  float scale = 1;
  color startColor;
  color endColor;
  color col;

  /******
    state:
    0 for resting,
    1 for growing,
    2 for changing color,
    3 for shrinking,
  ******/
  int state;
  boolean hr;
  boolean bang = false;
  boolean cross = false;
  boolean drift = false;
  TimeLine timer;

  // Initialization
  Strip(PGraphics _c) {
    cross = true;
    init(_c);
  }
  Strip(PGraphics _c, int _spd) {
    init(_c, _spd);
  }
  Strip(PGraphics _c, boolean _hr) {
    cross = false;
    hr = _hr;
    init(_c);
  }
  Strip(PGraphics _c, boolean _hr, boolean _b) {
    cross = false;
    hr = _hr;
    bang = _b;
    init(_c);
  }
  Strip(PGraphics _c, boolean _hr, int _spd) {
    cross = false;
    hr = _hr;
    init(_c, _spd);
  }
  void init(PGraphics _c) {
    canvas = _c;
    timer = new TimeLine(2000);
    xdes = 1000;
    reset();
  }
  void init(PGraphics _c, int spd) {
    canvas = _c;
    timer = new TimeLine(spd);
    xdes = 1000;
    reset();
  }

  // Basic
  void draw() {
    update();
    render();
  }
  void update() {
    if (state != 0) {
      basicUpdate();
      angleUpdate();
    }
  }
  void render() {
    if (state != 0) {
      canvas.pushMatrix();
      canvas.noStroke();
      canvas.fill(col, layer[3]);
      if (!hr) { canvas.rotate(PI / 2); }
      canvas.translate(xpos, ypos);
      if (drift) { canvas.rectMode(CENTER); }
      else { canvas.rectMode(CORNER); }
      canvas.rotate(angle);
      canvas.rect(0, 0, widthOfStrip, heightOfStrip);
      canvas.popMatrix();
    }
  }
  void reset() {
    state = 1;
    if (cross) {
      hr = (random(1) > 0.5);
    }
    startColor = colors[floor(random(5))];
    widthOfStrip = 15;

    do {
      endColor = colors[floor(random(5))];
    } while(startColor == endColor);

    if (hr) {
      xpos = floor(random(70, 100)) * 10;
      ypos = floor(random(35, 65)) * 10;
      xdes = floor(random(50, 120)) * 10;
    } else {
      xpos = floor(random(40, 60)) * 10;
      ypos = floor(random(-100, -70)) * 10;
      xdes = floor(random(20, 80)) * 10;
    }

    // test
    // testControl();

    xstr = xpos;
    col = startColor;
    timer.limit = floor(random(600, 2000));
    timer.startTimer();
  }

  // Updates
  void basicUpdate() {
    if (state == 1) {
      float ratio = timer.getPowOut(3);
      widthOfStrip = (xdes - xpos) * ratio;

      if (!timer.state) {
        state = 2;
        timer.startTimer();
      }
    } else if (state == 2) {
      col = lerpColor(startColor, endColor, timer.getPowOut(3));

      if (!timer.state) {
        state = 3;
        timer.startTimer();
        col = endColor;
      }
    } else if (state == 3) {
      float ratio = 1 - timer.getPowOut(3);
      widthOfStrip = (xdes - xstr) * ratio;
      xpos = xdes - widthOfStrip;

      if (!timer.state) {
        reset();
        if (bang) {
          stop();
        }
      }
    }
  }
  void angleUpdate() {
    if (abs(targetAngle - angle) < 0.01) {
      angle = targetAngle;
    } else {
      angle = angle + (targetAngle - angle) * 0.1;
    }
  }

  // Utilities
  void start() {
    reset();
  }
  void start(float pos) {
    reset();
    if (hr) {
      xpos = map(pos, 0, 1, 70, 100) * 10;
      xpos += random(-20, 20);
      xdes = floor(random(50, 120)) * 10;
    } else {
      xpos = map(pos, 0, 1, 40, 60) * 10;
      xpos += random(-20, 20);
      xdes = floor(random(20, 80)) * 10;
    }
  }
  void stop() {
    state = 0;
  }
  void triggerCross() {
    cross = !cross;
  }
  void triggerDrift() {
    drift = !drift;
  }

  void angleShiftBang() {
    // angle = targetAngle - PI;
    targetAngle += PI;
  }
  void angleShiftBang(int amt) {
    // angle = targetAngle - amt * PI;
    targetAngle += amt * PI;
  }

  // testing
  void testControl() {
    xpos = map(mouseX, 0, width, 0, 1000);
    xdes = xpos + 50;
    println("xpos: " + xpos);
    ypos = -1 * map(mouseY, 0, height, 0, 1000);
    println("ypos: " + ypos);
  }
}
