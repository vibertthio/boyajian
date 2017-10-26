
// horizontal:
//   x -> 700 ~ 1000
//   y -> 350 ~ 650
// vertical:
//   x ->  400 ~  600
//   y -> -1000 ~ -700

int horizontalXLowerBound = 700;
int horizontalXUpperBound = 1000;
int horizontalYLowerBound = 350;
int horizontalYUpperBound = 650;
int verticalXLowerBound = 400;
int verticalXUpperBound = 600;
int verticalYLowerBound = -1000;
int verticalYUpperBound = -700;

class StripsSystem {
  Strips crStrips;
  Strips hrStrips;
  Strips vtStrips;
  int nOfCrStrips = 30;
  int nOfHrStrips = 15;
  int nOfVtStrips = 15;

  StripsSystem(PGraphics _c) {
    init(_c);
  }
  void init(PGraphics _c) {
    crStrips = new Strips(_c, nOfCrStrips);
    hrStrips = new Strips(_c, nOfHrStrips, true, true);
    vtStrips = new Strips(_c, nOfVtStrips, false, true);

    hrStrips.setColors();
    vtStrips.setColors();
    hrStrips.stop();
    vtStrips.stop();
  }

  void draw() {
    update();
    render();
  }
  void update() {}
  void render() {
    crStrips.draw();
    hrStrips.draw();
    vtStrips.draw();
  }

  void hrStart() {
    hrStrips.setDrift(false);
    hrStrips.start();
    hrStrips.setTime(floor(random(200, 300)));
  }
  void hrStart(float pos) {
    hrStrips.setDrift(false);
    hrStrips.start(pos);
    hrStrips.setTime(floor(random(200, 300)));
  }
  void hrStart(float pos, float length) {
    hrStrips.setDrift(false);
    hrStrips.start(pos);
    hrStrips.setDes(length);
    hrStrips.setTime(floor(random(200, 300)));
  }
  void hrStartStep(float length) {
    hrStrips.setDrift(false);
    for (int i = 0; i < nOfHrStrips; i++) {
      float pos = map(i, 0, nOfHrStrips, 0, 1.2);
      int time = floor(map(pos, 0, 1, 200, 500));
      hrStrips.strips[i].start(pos);
      hrStrips.strips[i].setYPos(pos);
      hrStrips.strips[i].setTime(time);
    }
    hrStrips.setDes(length);
  }
  void vtStart() {
    vtStrips.setDrift(false);
    vtStrips.start();
    vtStrips.setTime(floor(random(200, 300)));
  }
  void vtStart(float pos) {
    vtStrips.setDrift(false);
    vtStrips.start(pos);
    vtStrips.setTime(floor(random(200, 300)));
  }
  void vtStart(float pos, float length) {
    vtStrips.setDrift(false);
    vtStrips.start(pos);
    vtStrips.setDes(length);
    vtStrips.setTime(floor(random(200, 300)));
  }
  void vtStartStep(float length) {
    vtStrips.setDrift(false);
    for (int i = 0; i < nOfVtStrips; i++) {
      float pos = map(i, 0, nOfVtStrips, 0, 1.2);
      int time = floor(map(pos, 0, 1, 200, 500));
      vtStrips.strips[i].start(pos + 0.3);
      vtStrips.strips[i].setYPos(pos);
      vtStrips.strips[i].setTime(time);
    }
    vtStrips.setDes(length);
  }
}

class Strips {
  PGraphics canvas;
  Strip[] strips;
  int nOfStrips = 15;
  int maxNumberOfStrips = 100;
  int minNumberOfStrips = 10;
  boolean map = false;
  int mapCount = 0;

  // Initialization
  Strips(PGraphics _c) {
    initCross(_c);
  }
  Strips(PGraphics _c, int _n) {
    nOfStrips = _n;
    initCross(_c);
  }
  Strips(PGraphics _c, int _n, boolean _hr, boolean _b) {
    nOfStrips = _n;
    init(_c, _hr, _b);
  }
  void init(PGraphics _c, boolean _hr, boolean _b) {
    canvas = _c;
    strips = new Strip[nOfStrips];
    for (int i = 0; i < nOfStrips; i++) {
      strips[i] = new Strip(_c, _hr, _b);
    }
  }
  void initCross(PGraphics _c) {
    canvas = _c;
    strips = new Strip[nOfStrips];
    for (int i = 0; i < nOfStrips; i++) {
      strips[i] = new Strip(_c);
      strips[i].cross = true;
    }
  }

  // Basic
  void draw() {
    update();
    render();
  }
  void update() {
    mapUpdate();
  }
  void render() {
    for (int i = 0; i < nOfStrips; i++) {
      strips[i].draw();
    }
  }

  // Update
  void mapUpdate() {
    if (map) {
      if (!strips[mapCount].timer.state && (mapCount < nOfStrips - 1)) {
        mapCount++;
        strips[mapCount].start();
        strips[mapCount].timer.limit = floor(random(200, 400));
        mapRandomEvent();
      } else if (mapCount == nOfStrips - 1) {
        println("## end of map");
        endMap();
      }
    }
  }

  // Utilities
  void start() {
    for (int i = 0; i < nOfStrips; i++) {
      strips[i].start();
    }
  }
  void start(float pos) {
    for (int i = 0; i < nOfStrips; i++) {
      strips[i].start(pos);
    }
  }
  void startMap() {
    stop();
    map = true;
    mapCount = 0;
    for (int i = 0; i < nOfStrips; i++) {
      strips[i].continuous = false;
      strips[i].drift = false;
    }
    strips[mapCount].start();
    strips[mapCount].timer.limit = floor(random(200, 400));
  }
  void endMap() {
    stop();
    map = false;
    mapCount = 0;
    for (int i = 0; i < nOfStrips; i++) {
      strips[i].continuous = true;
      strips[i].drift = true;
    }
    start();
  }
  void stop() {
    for (int i = 0; i < nOfStrips; i++) {
      strips[i].stop();
    }
  }
  void setTime(int ll) {
    for (int i = 0; i < nOfStrips; i++) {
      strips[i].setTime(ll);
    }
  }
  void setColors() {
    for (int i = 0; i < nOfStrips; i++) {
      strips[i].setColors();
    }
  }
  void setColors(color c) {
    for (int i = 0; i < nOfStrips; i++) {
      strips[i].setColors(c);
    }
  }
  void setDrift() {
    for (int i = 0; i < nOfStrips; i++) {
      strips[i].drift = !strips[i].drift;
    }
  }
  void setDrift(boolean d) {
    for (int i = 0; i < nOfStrips; i++) {
      strips[i].drift = d;
    }
  }
  void setDes(float length) {
    for (int i = 0; i < nOfStrips; i++) {
      strips[i].setDes(length);
    }
  }
  void modifyNumberOfStrips(int amt) {
    int number = nOfStrips + amt;
    if (number > maxNumberOfStrips) {
      number = minNumberOfStrips;
    }
    nOfStrips = number;
    initCross(canvas);
  }
  void addNumberOfStrips(int amt) {
    nOfStrips = max(minNumberOfStrips, min(maxNumberOfStrips, nOfStrips + amt));
    initCross(canvas);
  }
  void setNumberOfStrips(int n) {
    nOfStrips = max(minNumberOfStrips, min(maxNumberOfStrips, n));
    initCross(canvas);
  }
  void mapRandomEvent() {
    // Strips
    float chanceOfAngleShift = map(mapCount, 0, nOfStrips, 0, 0.4);
    if (random(1) < chanceOfAngleShift) {
      angleShiftBang();
    }
    float chanceOfScaleBang = map(mapCount, 0, nOfStrips, 0.3, 0.9);
    if (random(1) < chanceOfScaleBang) {
      heightScaleBang();
    }
    float chanceOfYShift = map(mapCount, 0, nOfStrips, 0.3, 0.5);
    if (random(1) < chanceOfYShift) {
      yShiftBang();
    }
    if (random(1) < 0.2) {
      yShiftBang(5);
    }
    if (random(1) < 0.2) {
      yShiftBang(-5);
    }

    // Individual
    if (random(1) < 0.1) {
      strips[mapCount].blinkBang();
    }
    if (random(1) < 0.1) {
      strips[mapCount].angleShiftBang();
    }
  }

  // Bang
  void angleShiftBang() {
    for (int i = 0; i < nOfStrips; i++) {
      strips[i].angleShiftBang();
    }
  }
  void angleShiftBang(int amt) {
    for (int i = 0; i < nOfStrips; i++) {
      strips[i].angleShiftBang(amt);
    }
  }
  void widthScaleBang() {
    for (int i = 0; i < nOfStrips; i++) {
      strips[i].widthScaleBang();
    }
  }
  void widthScaleBang(float amt) {
    for (int i = 0; i < nOfStrips; i++) {
      strips[i].widthScaleBang(amt);
    }
  }
  void heightScaleBang() {
    for (int i = 0; i < nOfStrips; i++) {
      strips[i].heightScaleBang();
    }
  }
  void heightScaleBang(float amt) {
    for (int i = 0; i < nOfStrips; i++) {
      strips[i].heightScaleBang(amt);
    }
  }
  void yShiftBang() {
    for (int i = 0; i < nOfStrips; i++) {
      strips[i].yShiftBang();
    }
  }
  void yShiftBang(int amt) {
    for (int i = 0; i < nOfStrips; i++) {
      strips[i].yShiftBang(amt);
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
  void beadingTrigger(boolean _s) {
    for (int i = 0; i < nOfStrips; i++) {
      strips[i].beading = _s;
      if (strips[i].beading) {
        strips[i].setBead();
      }
    }
  }
  void beadingTrigger() {
    for (int i = 0; i < nOfStrips; i++) {
      strips[i].beading = !strips[i].beading;
      if (strips[i].beading) {
        strips[i].setBead();
      }
    }
  }
}

class Strip {
  PGraphics canvas;
  float heightOfStrip = 8;
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
  boolean drift = true;
  // boolean colorful = false;
  boolean colorful = true;
  boolean continuous = true;
  TimeLine timer;

  // Circles
  boolean beading = false;
  Ball ball;

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
    init(_c, 2000);
  }
  void init(PGraphics _c, int spd) {
    canvas = _c;
    setColors(color(100));
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
      if (!hr) { canvas.rotate(PI / 2); }
      canvas.translate(xpos, ypos);
      if (drift) { canvas.rectMode(CENTER); }
      else { canvas.rectMode(CORNER); }
      if (beading) { ball.draw(); }
      canvas.rotate(angle);
      if (vibrateCount > 0) { canvas.translate(random(-10, 10), random(-10, 10)); }
      canvas.noStroke();
      canvas.fill(col, layer[3]);
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
      ypos = floor(random(25, 100)) * 10;
      // ypos = floor(random(35, 65)) * 10;
      xdes = floor(random(50, 120)) * 10;
    } else {
      // xpos = floor(random(40, 60)) * 10;
      xpos = floor(random(40, 80)) * 10;
      ypos = floor(random(-100, -70)) * 10;
      xdes = floor(random(20, 80)) * 10;
    }

    // test
    // testControl();

    col = startColor;
    xstr = xpos;
    ydes = ypos;
    int ll = floor(random(600, 2000));
    timer.limit = ll;
    timer.startTimer();

    // reset Circle
    if (beading) {
      setBead();
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
      // xpos += random(-5, 5);
      xdes = floor(random(50, 120)) * 10;
    } else {
      xpos = map(pos, 0, 1, 40, 60) * 10;
      // xpos += random(-5, 5);
      xdes = floor(random(20, 80)) * 10;
    }
  }
  void start(float _x, float _y) {
    reset();
    xpos = _x;
    ypos = _y;
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
  void setTime(int ll) {
    timer.limit = ll;
  }
  void setDes(float length) {
    xdes = xpos + length;
  }
  void setYPos(float ratio) {
    float y;
    if (hr) {
      y = map(ratio, 0, 1, horizontalYLowerBound, horizontalYUpperBound);
    } else {
      y = map(ratio, 0, 1, verticalYLowerBound, verticalYUpperBound);
    }
    ydes = y;
    ypos = y;
  }
  void setBead() {
    ball = new Ball(this, canvas, 0, 0, timer.limit);
    ball.targetRadius = 3 * heightOfStrip;
  }

  // Updates
  void basicUpdate() {
    if (state == 1) {
      float ratio = timer.getPowOut(3);
      widthOfStrip = (xdes - xpos) * ratio;

      if (!timer.state) {
        if (continuous) {
          state = 2;
          timer.startTimer();
          if (beading) {
            ball.moveBang((xdes - xpos) * 0.5, (ydes - ypos) * 0.5);
          }
        }
      }
    } else if (state == 2) {
      float ratio = timer.getPowOut(3);
      if (colorful) {
        col = lerpColor(startColor, endColor, ratio);
      }

      if (!timer.state) {
        if (continuous) {
          state = 3;
          timer.startTimer();
          if (beading) {
            ball.radiusBang(4);
            ball.alphaBang(0);
          }
          if (colorful) {
            col = endColor;
          }
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
    if (random(1) > 0.5) {
      targetAngle += 2 * PI;
    } else {
      targetAngle -= 2 * PI;
    }
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
