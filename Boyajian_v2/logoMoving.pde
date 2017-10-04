Slash[] slash;
int nb = 40;

PGraphics logoMoving;
PGraphics logoMirror;
PImage[] pattern = new PImage[3];
int roro = 0;
int pp = 0;

// Vibert's
Animations animations;

color[] colors = {
  color(253, 148, 38),
  color(252, 86, 44),
  color(56, 195, 206),
  color(124, 156, 124),
  color(18, 99, 104),
};

void logoSetting() {
  logoMoving = createGraphics(1500, 1000, P2D);
  logoMirror = createGraphics(1000, 1000, P2D);

  pattern[0] = loadImage("img/pp_0.png");
  pattern[1] = loadImage("img/pp_1.png");
  pattern[2] = loadImage("img/pp_2.png");

  slash = new Slash[nb];
  for (int i = 0; i < nb; i++) {
    int cc = int(random(10));
    if (cc == 0) {
      slash[i] = new Slash(colors[0]);
    } else if (cc == 1) {
      slash[i] = new Slash(colors[1]);
    } else {
      slash[i] = new Slash(colors[int(random(2, 4))]);
    }
  }

  // Vibert's
  animations = new Animations(logoMirror);
}

void logoDrawing() {

  logoMirror.beginDraw();
  logoMirror.background(125);
  logoMirror.imageMode(CENTER);
  logosMirrorDraw();
  logos_vibert();
  logoMirror.endDraw();

  logoMoving.beginDraw();
  logoMoving.background(125);
  logoMoving.imageMode(CENTER);
  //logoMoving.blendMode(ADD);
  logos_1();
  // logos_3();
  // logos_2();
  logoMoving.endDraw();
}

void logosMirrorDraw() {
  for (int i=0; i<nb; i++) {
    slash[i].draw(logoMirror);
  }
}

void logos_vibert() {
  animations.draw();
}

void logos_1() {
  logoMoving.pushMatrix();
  logoMoving.translate(0+166, logoMirror.height/2);
  logoMoving.scale(1, 1);
  logoMoving.image(logoMirror, 0, 0, logoMirror.width, logoMirror.height);
  logoMoving.popMatrix();

  logoMoving.pushMatrix();
  logoMoving.translate(logoMirror.width+166, logoMirror.height/2);
  logoMoving.scale(-1, 1);
  logoMoving.image(logoMirror, 0, 0, logoMirror.width, logoMirror.height);
  logoMoving.popMatrix();
}

void logos_3() {

  if (frameCount%100==0) {
    roro=int(random(5))*90;
  }

  if (frameCount%50==0) {
   pp=int(random(3));
  }


  logoMoving.pushMatrix();
  logoMoving.translate(0+166, logoMirror.height/2);
  logoMoving.scale(1, 1);
  logoMoving.rotate(radians(roro));
  logoMoving.image(pattern[pp], 0, 0, logoMirror.width, logoMirror.height);
  logoMoving.popMatrix();

  logoMoving.pushMatrix();
  logoMoving.translate(logoMirror.width+166, logoMirror.height/2);
  logoMoving.scale(-1, 1);
  logoMoving.rotate(radians(roro));
  logoMoving.image(pattern[pp], 0, 0, logoMirror.width, logoMirror.height);
  logoMoving.popMatrix();
}




void logos_2() {
  for (int i=0; i<15; i++) {
    for (int j=0; j<10; j++) {
      logoMoving.pushMatrix();
      logoMoving.scale(1.01);
      if (j%2==0) {
        logoMoving.translate(i*100, j*100+(20*abs(sin(frameCount*0.01))));
        logoMoving.scale(1, 1);
        logoMoving.image(logo, 0, 0, 80, 80);
      } else {
        logoMoving.translate((i*100)+50, j*100-(20*abs(sin(frameCount*0.01))));
        logoMoving.scale(1, -1);
        logoMoving.image(logo, 0, 0, 80, 80);
      }
      logoMoving. popMatrix();
    }
  }
}
