class Form {

  float stepSize = 30;
  float maxDepth = 200;
  PGraphics canvas;
  float soundVol;
  int id;

  void Form() {
    id=int(random(3));
  }

  void render(PGraphics _c) {
    if(id==0)soundVol=map(low,0,1,0.1,1);
    else if(id==1)soundVol=map(middle,0,1,0.1,1);
    else if(id==2)soundVol=map(high,0,1,0.1,1);

    canvas=_c;
    canvas.noFill();
    canvas.stroke(255, showLine*0.8);
    canvas.blendMode(ADD);
    canvas.strokeWeight(1);
    for (float w = 0; w <= width; w += stepSize) {
      canvas.beginShape();
      for (float h = -stepSize; h <= height + stepSize; h += stepSize) {
        float d = maxDepth * map(noise(w * 0.01, h * 0.01, frameCount * 0.05), 0, 1, -1*soundVol, 1*soundVol);
        canvas.curveVertex(w, d+300, h*2-500);
      }
      canvas.endShape();
    }
  }
}