class Cylinder {

  PShape model;
  PGraphics canvas;
  PImage imgLine1;
  PImage imgLine2;
  int[] id =new int[20];
  float[]ww =new float[20];
  float[]hh =new float[20];
  float[]pos =new float[20];
  float[]ro =new float[20];
  float[]ss =new float[20];
  float[]up =new float[20];
  float[] invert=new float[20];

  Cylinder() {
    model=loadShape("3d/cylinder2.obj");
    imgLine1=loadImage("3d/ruler.png");
    imgLine2=loadImage("3d/line.png");
    for (int i=0; i<20; i++) {
      ww[i]=random(1, 4);
      hh[i]=random(1, 2);
      pos[i]=random(-300, 300);
      id[i]=int(random(5));
      ro[i]=random(0, 360);
      ss[i]=random(0.3, 2);
      up[i]=random(1, 5);
      int k=int(random(2));
      if (k==0)invert[i]=1;
      else if (k==1)invert[i]=-1;
    }
  }

  void render(PGraphics _c) {
    canvas=_c;
    canvas.blendMode(ADD);
    canvas.pushMatrix();
    canvas.translate(width/2, height/2, 0);

    canvas.scale(showCylinder/255);
    canvas.rotateX(radians(anim(800, 0, 360, 2)));
    canvas.rotateZ(radians(anim(1600, 0, 90, 2)));

    for (int i=0; i<20; i++) {

      if (id[i]==0)setTexture(model, imgLine1);
      else setTexture(model, imgLine2);

      ro[i]=(ro[i]+ss[i])%360;

      if (pos[i]>400) {
        pos[i]=-400;
      } else {

        if (ctl32>0)pos[i]=pos[i]+(up[i]*map(ctl32, 0, 255, 1, 6));
        else pos[i]=pos[i]+(up[i]*map(vol, 0, 1, 1, 3));
      }
      canvas.pushMatrix();
      canvas.translate(0, pos[i]*invert[i], 0);
      canvas.rotateY(radians(ro[i]));
      canvas.scale(ww[i], hh[i], ww[i]);

      model.disableStyle();
      canvas.tint(colors[id[i]], 200);
      canvas.shape(model);
      model.enableStyle();
      canvas.popMatrix();
    }
    canvas.blendMode(BLEND);
    canvas.popMatrix();
  }
  void addRo(float who, float speed) {
    who=(who+speed)%360;
  }
}