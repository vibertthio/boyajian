class StripsSystem {}

//VisualStrip.pde
class Strips {
  Strip[] strips;
  int nOfStrips = 10;

  Strips(PGraphics _c) {
    init(_c);
  }
  void init(PGraphics _c) {
    strips = new Strip[nOfStrips];
    for (int i = 0; i < nOfStrips; i++) {
      strips[i] = new Strip(_c);
      strips[i].drift = true;
    }
  }
  void draw() {
    update();
    render();
  }
  void update() {}
  void render() {
    for (int i = 0; i < nOfStrips; i++) {
      strips[i].draw();
    }
  }

  // Utilities
  void setColorful() {
    for (int i = 0; i < nOfStrips; i++) {
      strips[i].setColors();
    }
  }

  // Bang
  void angleShiftBang() {
    for (int i = 0; i < nOfStrips; i++) {
      strips[i].angleShiftBang();
    }
  }
  void widthScaleBang() {
    for (int i = 0; i < nOfStrips; i++) {
      strips[i].widthScaleBang();
    }
  }
  void heightScaleBang() {
    for (int i = 0; i < nOfStrips; i++) {
      strips[i].heightScaleBang();
    }
  }
  void yShiftBang() {
    for (int i = 0; i < nOfStrips; i++) {
      strips[i].yShiftBang();
    }
  }
  void vibrateBang() {
    for (int i = 0; i < nOfStrips; i++) {
      strips[i].vibrateBang();
    }
  }
  void blinkBang() {
    for (int i = 0; i < nOfStrips; i++) {
      strips[i].blinkBang();
      strips[i].start();
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
  float ydes;
  float angle = 0;
  float targetAngle = 0;
  float widthScale = 1;
  float heightScale = 1;
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
  boolean colorful = false;
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
    setColors(color(255, 255, 255));
    timer = new TimeLine(2000);
    xdes = 1000;
    reset();
  }
  void init(PGraphics _c, int spd) {
    canvas = _c;
    setColors(color(255, 255, 255));
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
      scaleUpdate();
      yposUpdate();
      vibrateUpdate();
      blinkUpdate();
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
      if (vibrateCount > 0) { canvas.translate(random(-10, 10), random(-10, 10)); }
      canvas.rect(0, 0, widthOfStrip * widthScale, heightOfStrip * heightScale);
      canvas.popMatrix();
    }
  }
  void reset() {
    state = 1;
    if (cross) {
      hr = (random(1) > 0.5);
    }
    widthOfStrip = 15;
    if (colorful) {
      setColors();
    }
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

    col = startColor;
    xstr = xpos;
    ydes = ypos;
    timer.limit = floor(random(600, 2000));
    timer.startTimer();
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
  void setColors() {
    colorful = true;
    startColor = colors[floor(random(5))];
    do {
      endColor = colors[floor(random(5))];
    } while(startColor == endColor);
  }
  void setColors(color c) {
    colorful = false;
    startColor = c;
    endColor = c;
    col = c;
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
      float ratio = timer.getPowOut(3);
      if (colorful) {
        col = lerpColor(startColor, endColor, ratio);
      }

      if (!timer.state) {
        state = 3;
        timer.startTimer();
        if (colorful) {
          col = endColor;
        }
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
  void scaleUpdate() {
    if (abs(widthScale - 1) < 0.01) {
      widthScale = 1;
    } else {
      widthScale += (1 - widthScale) * 0.2;
    }
    if (abs(heightScale - 1) < 0.01) {
      heightScale = 1;
    } else {
      heightScale += (1 - heightScale) * 0.2;
    }
  }
  void yposUpdate() {
    if (abs(ypos - ydes) < 0.1) {
      ypos = ydes;
    } else {
      ypos = ypos + (ydes - ypos) * 0.2;
    }
  }

  // Bang
  void angleShiftBang() {
    // angle = targetAngle - PI;
    targetAngle += PI;
  }
  void angleShiftBang(int amt) {
    // angle = targetAngle - amt * PI;
    targetAngle += amt * PI;
  }
  void widthScaleBang() {
    widthScaleBang(2);
  }
  void widthScaleBang(float amt) {
    widthScale = amt;
  }
  void heightScaleBang() {
    heightScaleBang(4);
  }
  void heightScaleBang(float amt) {
    heightScale = amt;
  }
  void yShiftBang() {
    yShiftBang(floor(random(-15, 15)));
  }
  void yShiftBang(int amt) {
    ydes += amt * heightOfStrip;
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

  int blinkCount = 0;
  void blinkBang() {
    blinkCount = floor(random(15, 25));
  }
  void blinkUpdate() {
    if (blinkCount > 0) {
      col = colors[floor(random(colors.length))];
      widthScale = random(1, 3);
      blinkCount--;
      if (blinkCount <= 0) {
        // heightScale = random(4, 8);
        col = startColor;
      }
    }
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
