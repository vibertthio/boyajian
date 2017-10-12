//VisuallogoMoving.pde

Slash[] slash;
int nb = 40;

PGraphics logoMoving;
PGraphics logoMirror;

int roro = 0;
int pp = 0;
boolean logo3Changing = false;
boolean logo3Rotating = false;

boolean bgChanging = false;
boolean bgBlending = false;

// Vibert's
Animations animations;

PImage bgbg;
pdLine2 logoRo;

color[] colors = {
  color(253, 148, 38), 
  color(252, 86, 44), 
  color(56, 195, 206), 
  color(124, 156, 124), 
  color(18, 99, 104), 
};

void defultSetting() {
  textSize(64);
  logoRo=new pdLine2(0, 0);
  logoMoving = createGraphics(1500, 1000, P2D);
  logoMirror = createGraphics(1000, 1000, P2D);

  square = createShape(RECT, 0, 0, width, height);
  tex= createGraphics(1500, 1000, P2D);
  s3d= createGraphics(width, height, P3D);

  ptnGroup= createGraphics(width, height, P2D);
  columnImg= createGraphics(width, height, P2D);
  scence= createGraphics(width, height, P2D);
  finalRender= createGraphics(width, height, P2D);

  myBus.sendNoteOff(0, 24, 0);
  myBus.sendNoteOff(0, 25, 0);
  myBus.sendNoteOff(0, 26, 0);
  myBus.sendNoteOff(0, 27, 0);
  myBus.sendNoteOff(0, 28, 0);
  myBus.sendNoteOff(0, 29, 0);
  myBus.sendNoteOff(0, 30, 0);
  myBus.sendNoteOff(0, 31, 0);

  myBus.sendNoteOff(0, 36, 0);
  myBus.sendNoteOff(0, 37, 0);
  myBus.sendNoteOff(0, 38, 0);
  myBus.sendNoteOff(0, 39, 0);
  myBus.sendNoteOff(0, 40, 0);
  myBus.sendNoteOff(0, 41, 0);
  myBus.sendNoteOff(0, 42, 0);
  myBus.sendNoteOff(0, 43, 0);



  bgbg= loadImage("img/bg.png");

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
  if (frameCount%100==0) if (bgChanging) {
    imgIndex=int(random(5));
    blendGLSL.set( "lowLayer", bgs [imgIndex]);
  }
  if (frameCount%100==0) if (bgBlending) blendIndex = int(random(10));

  logoRo.update();
  logoMirror.beginDraw();
  logoMirror.background(125);
  logoMirror.imageMode(CENTER);

  if (layer[2]>10) {
    logosMirrorDraw();//打開slash 開關
  }
  logos_vibert();
  logoMirror.endDraw();

  logoMoving.beginDraw();
  logoMoving.background(125);
  logoMoving.imageMode(CENTER);
  logoMoving.blendMode(BLEND);


  logos_1();//鏡射



  //logos_3();//旋轉靜態圖

  // logos_2();//repeat logo
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
  logoMoving.translate(0+151, logoMirror.height/2);
  logoMoving.scale(1, 1);
  logoMoving.image(logoMirror, 0, 0, logoMirror.width*1.2, logoMirror.height*1.6);
  logoMoving.popMatrix();

  logoMoving.pushMatrix();
  logoMoving.translate(logoMirror.width+351, logoMirror.height/2);
  logoMoving.scale(-1, 1);
  logoMoving.image(logoMirror, 0, 0, logoMirror.width*1.2, logoMirror.height*1.6);
  logoMoving.popMatrix();
}

void logos_3() {

  if (frameCount%100==0) {
    if (logo3Rotating) {
      roro=int(random(-3, 3))*180;
      logoRo.reset(random(roro));
    }
  }

  if (frameCount%50==0) {
    if (logo3Changing) {
      pp=int(random(15));
    }
  }

  logoMoving.pushMatrix();
  logoMoving.translate(0+250, logoMirror.height/2);
  logoMoving.scale(1, 1);
  logoMoving.rotate(radians(logoRo.o));
  logoMoving.image(pattern[pp], 0, 0, logoMirror.width, logoMirror.height);
  logoMoving.popMatrix();

  logoMoving.pushMatrix();
  logoMoving.translate(logoMirror.width+250, logoMirror.height/2);
  logoMoving.scale(-1, 1);
  logoMoving.rotate(radians(logoRo.o));
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