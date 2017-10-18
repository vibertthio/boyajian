class CrossStrips {
  CrossStrip[] strips;
  int nOfStrips = 30;

  CrossStrips(PGraphics _c) {
    strips = new CrossStrip[nOfStrips];
    for (int i = 0; i < nOfStrips; i++) {
      strips[i] = new CrossStrip(_c);
    }
  }
  void draw() {
    for (int i = 0; i < nOfStrips; i++) {
      strips[i].draw();
    }
  }
}

class CrossStrip {
  PGraphics canvas;
  float heightOfStrip = 15;
  float widthOfStrip = 15;
  float xstr;
  float ystr;
  float xpos;
  float ypos;
  float xdes;
  float ydes;
  color startColor;
  color endColor;
  color col;

  /******
    state:
    0 for growing
    1 for changing color
    2 for shrinking
  ******/
  int state;
  boolean hr;
  TimeLine timer;

  CrossStrip(PGraphics _c) {
    canvas = _c;
    timer = new TimeLine(2000);
    xdes = 1000;
    ydes = 400;
    reset();
  }

  void draw() {
    update();
    render();
  }
  void update() {
    if (hr) {
      updateHorizontal();
    } else {
      updateVertical();
    }
  }
  void render() {
    canvas.pushMatrix();
    canvas.noStroke();
    canvas.fill(col,layer[3]);
    // canvas.rotate(PI / 2);
    // canvas.translate(xpos, -ypos);
    canvas.rectMode(CENTER);
    canvas.translate(xpos, ypos);
    canvas.rect(0, 0, widthOfStrip, heightOfStrip);
    // canvas.rect(xpos, ypos, widthOfStrip, heightOfStrip);
    canvas.popMatrix();
  }
  void updateHorizontal() {
    if (state == 0) {
      float ratio = timer.getPowOut(3);
      widthOfStrip = (xdes - xpos) * ratio;

      if (!timer.state) {
        state = 1;
        timer.startTimer();
      }
    } else if (state == 1) {
      col = lerpColor(startColor, endColor, timer.getPowOut(3));

      if (!timer.state) {
        state = 2;
        timer.startTimer();
        col = endColor;
      }
    } else {
      float ratio = 1 - timer.getPowOut(3);
      widthOfStrip = (xdes - xstr) * ratio;
      xpos = xdes - widthOfStrip;

      if (!timer.state) {
        reset();
      }
    }
  }
  void updateVertical() {
    if (state == 0) {
      float ratio = timer.getPowOut(3);
      heightOfStrip = (ydes - ypos) * ratio;

      if (!timer.state) {
        state = 1;
        timer.startTimer();
      }
    } else if (state == 1) {
      col = lerpColor(startColor, endColor, timer.getPowOut(3));

      if (!timer.state) {
        state = 2;
        timer.startTimer();
        col = endColor;
      }
    } else {
      float ratio = 1 - timer.getPowOut(3);
      heightOfStrip = (ydes - ystr) * ratio;
      ypos = ydes - heightOfStrip;

      if (!timer.state) {
        reset();
      }
    }
  }
  void reset() {
    state = 0;
    // hr = true;
    hr = (random(1) > 0.5);
    startColor = colors[floor(random(5))];
    heightOfStrip = 15;
    widthOfStrip = 15;

    do {
      endColor = colors[floor(random(5))];
    } while(startColor == endColor);

    xpos = floor(random(20, 50)) * 20;
    ypos = floor(random(15, 50)) * 20;
    if (hr) {
      xdes = floor(random(20, 50)) * 20;
    } else {
      ydes = floor(random(15, 50)) * 20;
    }
    // ypos = map(mouseY, 0, height, 0, 1000);
    xstr = xpos;
    ystr = ypos;
    col = startColor;
    timer.limit = floor(random(600, 2000));
    timer.startTimer();
  }
}
