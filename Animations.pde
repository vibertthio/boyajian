class Animations {
  PGraphics canvas;
  Strip[] strips;
  int nOfStrips = 30;

  Animations(PGraphics _c) {
    canvas = _c;
    strips = new Strip[nOfStrips];
    for (int i = 0; i < nOfStrips; i++) {
      strips[i] = new Strip(_c);
    }
  }

  void draw() {
    for (int i = 0; i < nOfStrips; i++) {
      strips[i].draw();
    }
  }
}

class Circle {
  PGraphics canvas;
  float widthOfStrip = 10;
  float radius = 10;
  float xpos = int(random(1, int(logoMoving.width / 20) - 1) * 20);
  float ypos = int(random(1, int(logoMoving.height / 20) - 1) * 20);


  Circle(PGraphics _c) {
    canvas = _c;
  }

  void draw() {
    canvas.noStroke();
    canvas.fill(255);
    canvas.ellipse(xpos, ypos, radius, radius);
  }
}

// X : 400 - 1000
// Y : 500 - 1000

class Strip {
  PGraphics canvas;
  float lengthOfStrip;
  float widthOfStrip = 15;
  float xstr;
  float ystr;
  float xpos;
  float ypos;
  float xdes;
  float ydes;
  float alpha;
  color startColor;
  color endColor;
  color col;

  TimeLine timer;
  /******
    state:
    0 for growing
    1 for changing color
    2 for shrinking
  ******/
  int state;

  boolean vertical = (random(1) > 0.5);

  Strip(PGraphics _c) {
    canvas = _c;
    timer = new TimeLine(2000);
    xdes = 1000;
    ydes = 400;
    reset();
  }

  void draw() {
    if (state == 0) {
      float ratio = timer.getPowOut(3);
      lengthOfStrip = (xdes - xpos) * ratio;

      if (!timer.state) {
        state = 1;
        timer.startTimer();
      }
    } else if (state == 1) {
      col = lerpColor(startColor, endColor, timer.getPowOut(3));

      if (!timer.state) {
        state = 2;
        timer.startTimer();
      }
    } else {
      float ratio = 1 - timer.getPowOut(3);
      lengthOfStrip = (xdes - xstr) * ratio;
      xpos = xdes - lengthOfStrip;

      if (!timer.state) {
        reset();
      }
    }

    render();
  }

  void render() {
    canvas.noStroke();
    canvas.fill(endColor);
    canvas.rect(xpos, ypos, lengthOfStrip, widthOfStrip);
  }

  void reset() {
    state = 0;
    startColor = colors[floor(random(5))];

    do {
      endColor = colors[floor(random(5))];
    } while(startColor == endColor);

    xpos = floor(random(20, 50)) * 20;
    ypos = floor(random(25, 50)) * 20;
    xstr = xpos;
    ystr = ypos;
    alpha = 255;
    timer.limit = floor(random(600, 2000));
    timer.startTimer();
  }
}

class Mountain {

}
