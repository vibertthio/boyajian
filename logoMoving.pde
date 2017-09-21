Slash[] slash;
int nb=40;

PGraphics logoMoveing;
PGraphics logoMirror;
PImage[] pattern=new PImage[3];
int roro=0;
int pp=0;

color[] colors = {color(253, 148, 38), color(252, 86, 44),
  color(56, 195, 206), color(124, 156, 124), color(18, 99, 104)};

void logoSetting() {
  logoMoveing= createGraphics(1500, 1000, P2D);
  logoMirror= createGraphics(1000, 1000, P2D);

  pattern[0]=loadImage("img/pp_0.png");
  pattern[1]=loadImage("img/pp_1.png");
  pattern[2]=loadImage("img/pp_2.png");

  slash=new Slash[nb];
  for (int i=0; i<nb; i++) {
    int cc=int(random(10));
    if (cc==0)slash[i]=new Slash(colors[0]);
    else if (cc==1) slash[i]=new Slash(colors[1]);
    else slash[i]=new Slash(colors[ int(random(2, 4))]);
  }
}

void logoDrawing() {

  logoMirror.beginDraw();
  logoMirror.background(125);
  logoMirror.imageMode(CENTER);
  logosMirrorDraw();
  logoMirror.endDraw();

  logoMoveing.beginDraw();
  logoMoveing.background(125);
  logoMoveing.imageMode(CENTER);
  //logoMoveing.blendMode(ADD);
  logos_1();
  // logos_3();
  // logos_2();
  logoMoveing.endDraw();
}

void logosMirrorDraw() {
  for (int i=0; i<nb; i++) {
    slash[i].draw(logoMirror);
  }
}

void logos_1() {
  logoMoveing.pushMatrix();
  logoMoveing.translate(0+166, logoMirror.height/2);
  logoMoveing.scale(1, 1);
  logoMoveing.image(logoMirror, 0, 0, logoMirror.width, logoMirror.height);
  logoMoveing.popMatrix();

  logoMoveing.pushMatrix();
  logoMoveing.translate(logoMirror.width+166, logoMirror.height/2);
  logoMoveing.scale(-1, 1);
  logoMoveing.image(logoMirror, 0, 0, logoMirror.width, logoMirror.height);
  logoMoveing.popMatrix();
}

void logos_3() {

  if (frameCount%100==0) {
    roro=int(random(5))*90;
  }

  if (frameCount%50==0) {
   pp=int(random(3));
  }


  logoMoveing.pushMatrix();
  logoMoveing.translate(0+166, logoMirror.height/2);
  logoMoveing.scale(1, 1);
  logoMoveing.rotate(radians(roro));
  logoMoveing.image(pattern[pp], 0, 0, logoMirror.width, logoMirror.height);
  logoMoveing.popMatrix();

  logoMoveing.pushMatrix();
  logoMoveing.translate(logoMirror.width+166, logoMirror.height/2);
  logoMoveing.scale(-1, 1);
  logoMoveing.rotate(radians(roro));
  logoMoveing.image(pattern[pp], 0, 0, logoMirror.width, logoMirror.height);
  logoMoveing.popMatrix();
}




void logos_2() {
  for (int i=0; i<15; i++) {
    for (int j=0; j<10; j++) {
      logoMoveing.pushMatrix();
      logoMoveing.scale(1.01);
      if (j%2==0) {
        logoMoveing.translate(i*100, j*100+(20*abs(sin(frameCount*0.01))));
        logoMoveing.scale(1, 1);
        logoMoveing.image(logo, 0, 0, 80, 80);
      } else {
        logoMoveing.translate((i*100)+50, j*100-(20*abs(sin(frameCount*0.01))));
        logoMoveing.scale(1, -1);
        logoMoveing.image(logo, 0, 0, 80, 80);
      }
      logoMoveing. popMatrix();
    }
  }
}
