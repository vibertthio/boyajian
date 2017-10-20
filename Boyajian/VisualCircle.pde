class Circle {
  PGraphics canvas;
  float xpos;
  float ypos;
  float xdes;
  float ydes;
  float alpha = 200;
  float radius = 0;
  float targetAlpha;
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
    3 for submerging,
  ******/
  int state = 0;
  TimeLine timer;
  boolean colorful = false;


  Circle(PGraphics _c) {
    init(_c);
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
          state = 2;
          timer.startTimer();
          xdes = xpos + random(-100, 100);
          ydes = ypos + random(-100, 100);
        }
      } else if (state == 2) {
        float ratio = timer.getPowOut(3);
        xpos = xpos + (xdes - xpos) * ratio;
        ypos = ypos + (ydes - ypos) * ratio;

        if (!timer.state) {
          state = 3;
          timer.startTimer();
        }
      } else if (state == 3) {
        float ratio = 1 - timer.getPowOut(3);
        radius = targetRadius * ratio;
        if (!timer.state) {
          state = 0;
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

  void emergeBang() {
    state = 1;
    timer.startTimer();
  }
  void submergeBang() {}

}

// horizontal:
//   x -> 700 ~ 1000
//   y -> 350 ~ 650
// vertical:
//   x ->  400 ~  600
//   y -> -1000 ~ -700
