class Animations {
  PGraphics canvas;
  Strip[] strips;
  int nOfStrips = 40;

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

class Strip {
  PGraphics canvas;
  float widthOfStrip = 10;
  float xpos = int(random(1, int(logoMoving.width / 20) - 1) * 20);
  float ypos = int(random(1, int(logoMoving.height / 20) - 1) * 20);


  Strip(PGraphics _c) {
    canvas = _c;
  }

  void draw() {
    canvas.noStroke();
    canvas.fill(255);
    xpos = map(mouseX, 0, width, 0, 1000);
    ypos = map(mouseY, 0, height, 0, 1000);
    canvas.ellipse(xpos, ypos, 50, 50);
  }
}

class Mountain {

}
