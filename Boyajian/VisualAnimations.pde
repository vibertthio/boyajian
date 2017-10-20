//VisualAnimations.pde
class Animations {
  PGraphics canvas;
  PGraphics innerCanvas;
  StripsSystem stripsSystem;
  GrowGrid growGrid;
  RotateGrid rotateGrid;
  Slashes slashes;
  LogoDraw logodraws;

  Circle circle;

  Animations(PGraphics _c, PGraphics _ic) {
    canvas = _c;
    innerCanvas = _ic;
    growGrid = new GrowGrid(_c, color(255, 255, 255));
    rotateGrid = new RotateGrid(_c, color(255, 255, 255));
    logodraws = new LogoDraw();
    slashes = new Slashes(50, _ic);
    stripsSystem = new StripsSystem(_ic);

    circle = new Circle(_c);
  }

  void draw() {
    if (layer[8] > 10)  { logodraws.draw(canvas, logoMirror, layer[8]); }
    if (layer[6] < 115) { growGrid.draw(); }
    if (layer[6] > 135) { rotateGrid.draw(); }
    circle.draw();
  }

  void innerDraw() {

    if (layer[3] > 10 || layer[2] > 10) {
      //if(layer[3] >layer[2]) logodraws.draw(innerCanvas, logoMirror2,layer[3]);
      //else logodraws.draw(innerCanvas, logoMirror2,layer[2]);
    }

    if (layer[3] > 10) { stripsSystem.draw(); }
    if (layer[2] > 10) { slashes.draw(); }
  }
}
