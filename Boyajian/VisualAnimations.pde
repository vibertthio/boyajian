//VisualAnimations.pde
class Animations {
  PGraphics canvas;
  Strips strips;
  GrowGrid growGrid;
  RotateGrid rotateGrid;
  Slashes slashes;
  LogoDraw logodraws;

  Animations(PGraphics _c) {
    canvas = _c;
    strips = new Strips(_c);
    growGrid = new GrowGrid(_c, color(255, 255, 255));
    rotateGrid = new RotateGrid(_c, color(255, 255, 255));
    slashes = new Slashes(50);
    logodraws=new LogoDraw(_c);
  }

  void draw() {
    if (layer[8]>10) {
      logodraws.draw();
    }

    if (layer[3]>10) {
      strips.draw();
    }

    if (layer[6]<115) {
      growGrid.draw();
    }

    if (layer[6]>135) {
      rotateGrid.draw();
    }

    if (layer[2]>10) {
      slashes.draw();
    }
  }
}
