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

class Mountain {

}
