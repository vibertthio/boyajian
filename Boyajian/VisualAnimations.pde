//VisualAnimations.pde
class Animations {
  PGraphics canvas;
  PGraphics innerCanvas;
  StripsSystem stripsSystem;
  GrowGrid growGrid;
  RotateGrid rotateGrid;
  Slashes slashes;
  LogoDraw logodraws;

  Animations(PGraphics _c, PGraphics _ic) {
    canvas = _c;
    innerCanvas = _ic;
    growGrid = new GrowGrid(_c, color(255, 255, 255));
    rotateGrid = new RotateGrid(_c, color(255, 255, 255));
    logodraws = new LogoDraw();
    slashes = new Slashes(50, _ic);
    stripsSystem = new StripsSystem(_ic);
  }

  void draw() {
    if (layer[8] > 2)  { logodraws.draw(canvas, logoMirror, layer[8]); }
    if (layer[6] < 115) { growGrid.draw(); }
    if (layer[6] > 135) { rotateGrid.draw(); }
  }

  void innerDraw() {

    if (layer[3] > 2 || layer[2] > 2) {
      //if(layer[3] >layer[2]) logodraws.draw(innerCanvas, logoMirror2,layer[3]);
      //else logodraws.draw(innerCanvas, logoMirror2,layer[2]);
    }

    if (layer[3] > 2) { stripsSystem.draw(); }
    if (layer[2] > 2) { slashes.draw(); }
  }
}
