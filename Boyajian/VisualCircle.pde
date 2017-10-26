class Circle {
  PGraphics canvas;
  float xpos;
  float ypos;
  float xdes;
  float ydes;
  float alpha = 200;
  float radius = 0;
  float targetAlpha = 255;
  float targetRadius = 80;
  int limit = 2000;
  color startColor;
  color endColor;
  color col = color(255, 255, 255);

  /******
    state:
    0 for resting,
    1 for emerging,
    2 for moving/changing color,
    3 for expand,
    4 for submerging,
  ******/
  int state = 0;
  TimeLine timer;
  boolean colorful = false;
  boolean continuous = true;

  Circle(PGraphics _c) {
    init(_c);
  }
  Circle(PGraphics _c, float _x, float _y, int _ll) {
    init(_c);
    xpos = _x;
    ypos = _y;
    timer.limit = _ll;
  }
  void init(PGraphics _c) {
    canvas = _c;
    timer = new TimeLine(limit);
    xpos = 800;
    ypos = 500;
  }

  void draw() {
    update();
    render();
  }
  void update() {
    if (state != 0) {
      if (state == 1) {
        float ratio = timer.elasticOut();
        radius = targetRadius * ratio;

        if (!timer.state) {
          if (continuous) {
            moveBang();
          }
        }
      } else if (state == 2) {
        float ratio = timer.getPowOut(3);
        xpos = xpos + (xdes - xpos) * ratio;
        ypos = ypos + (ydes - ypos) * ratio;

        if (!timer.state) {
          if (continuous) {
            submergeBang();
          }
        }
      } else if (state == 3) {
        float ratio = timer.getPowOut(3);
        radius = targetRadius * ratio;
        if (!timer.state) {
          restBang();
        }
      } else if (state == 4) {
        float ratio = 1 - timer.getPowOut(3);
        radius = targetRadius * ratio;
        if (!timer.state) {
          restBang();
        }
      }
    }
  }
  void render() {
    if (state != 0) {
      canvas.pushMatrix();
      canvas.noStroke();
      canvas.fill(col, alpha);
      canvas.translate(xpos, ypos);
      canvas.ellipse(0, 0, radius, radius);
      canvas.popMatrix();
    }
  }

  void alphaUpdate() {
    if (abs(targetAlpha - alpha) < 0.05) {
      alpha = targetAlpha;
    } else {
      alpha = alpha + (targetAlpha - alpha) * 0.1;
    }
  }
  void restBang() {
    state = 0;
  }
  void emergeBang() {
    state = 1;
    targetAlpha = 255;
    timer.startTimer();
  }
  void moveBang() {
    state = 2;
    timer.startTimer();
    xdes = xpos + random(-100, 100);
    ydes = ypos + random(-100, 100);
  }
  void expandBang() {
    state = 3;
    targetRadius = 5 * radius;
    targetAlpha = 0;
  }
  void submergeBang() {
    state = 4;
    timer.startTimer();
  }

}

class Ball {
  PGraphics canvas;
  Strip strip;
  float xpos;
  float ypos;
  float xdes;
  float ydes;
  float alpha = 200;
  float radius = 0;
  float targetAlpha = 200;
  float targetRadius = 80;
  boolean colorful = false;
  color startColor;
  color endColor;
  color col = color(255, 255, 255);

  TimeLine radiusTimer;
  int radiusTimeLimit = 2000;



  Ball(Strip _s, PGraphics _c) {
    init(_s, _c);
  }
  Ball(Strip _s, PGraphics _c, float _x, float _y, int _ll) {
    init(_s, _c, _x, _y);
    radiusTimer.limit = _ll;
  }
  void init(Strip _s, PGraphics _c) {
    init(_s, _c, 800, 500);
  }
  void init(Strip _s, PGraphics _c, float _x, float _y) {
    strip = _s;
    canvas = _c;
    radiusTimer = new TimeLine(radiusTimeLimit);
    xpos = _x;
    ypos = _y;
    xdes = _x;
    ydes = _y;
  }

  void draw() {
    update();
    render();
  }
  void update() {
    posUpdate();
    alphaUpdate();
    radiusUpdate();
  }
  void render() {
    canvas.pushMatrix();
    canvas.noStroke();
    canvas.fill(strip.col, alpha);
    canvas.translate(xpos, ypos);
    // canvas.ellipse(0, 0, radius, radius);
    canvas.ellipse(0, 0, radius * strip.heightScale, radius * strip.heightScale);
    canvas.popMatrix();
  }

  void alphaUpdate() {
    if (abs(targetAlpha - alpha) < 0.05) {
      alpha = targetAlpha;
    } else {
      alpha = alpha + (targetAlpha - alpha) * 0.1;
    }
  }
  void radiusUpdate() {
    // if (!radiusTimer.state) {
    //   radius = targetRadius;
    // } else {
    //   float ratio = radiusTimer.power();
    //   radius = targetRadius * ratio;
    // }
    if (abs(targetRadius - radius) < 0.05) {
      radius = targetRadius;
    } else {
      radius = radius + (targetRadius - radius) * 0.1;
    }
  }
  void posUpdate() {
    if (abs(xpos - xdes) > 0.5) {
      xpos = xpos + (xdes - xpos) * 0.1;
    } else {
      xpos = xdes;
    }

    if (abs(ypos - ydes) > 0.5) {
      ypos = ypos + (ydes - ypos) * 0.1;
    } else {
      ypos = ydes;
    }
  }

  void radiusBang(float amt) {
    radiusTimer.startTimer();
    targetRadius = radius * amt;
  }
  void alphaBang(int value) {
    targetAlpha = value;
  }
  void moveBang(float _x, float _y) {
    xdes = _x;
    ydes = _y;
  }
}



// horizontal:
//   x -> 700 ~ 1000
//   y -> 350 ~ 650
// vertical:
//   x ->  400 ~  600
//   y -> -1000 ~ -700
