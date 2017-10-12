//VisualAnimations.pde
class Animations {
  PGraphics canvas;
  Strips strips;
  GrowGrid growGrid;
  RotateGrid rotateGrid;
  Slashes slashes;

  Animations(PGraphics _c) {
    canvas = _c;
    strips = new Strips(_c);
    // growGrid = new GrowGrid(_c, colors[0]);
    growGrid = new GrowGrid(_c, color(255, 255, 255));
    // rotateGrid = new RotateGrid(_c, colors[1]);
    rotateGrid = new RotateGrid(_c, color(255, 255, 255));

    slashes = new Slashes(50);
  }

  void draw() {
    if(layer[3]>10){
     strips.draw();
    }

    growGrid.draw();
    rotateGrid.draw();

    if (layer[2]>10) {
      slashes.draw();
    }
  }
}

// X : 400 - 1000
// Y : 500 - 1000

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

class Mountain {
}
