//VisuallogoMoving.pde

PGraphics logoMoving;
PGraphics logoMirror;

PGraphics logoMoving2;
PGraphics logoMirror2;

int roro = 0;
int pp = 0;
boolean logo3Changing = false;
boolean logo3Rotating = false;
boolean bgChanging = false;
boolean bgBlending = false;

// Vibert's
Animations animations;

float logoScale=1;
float logoScaleStep=1;

float logoMovingStep=0;
float logoMovingSpeed=0.5;
float ctl82;

color[] colors = {
  color(253, 148, 38), 
  color(252, 86, 44), 
  color(56, 195, 206), 
  color(124, 156, 124), 
  color(18, 99, 104), 
};

void defultSetting() {
  textSize(64);

  logoMoving = createGraphics(1920, 1280, P2D);
  logoMirror = createGraphics(1000, 1000, P2D);

  logoMoving2 = createGraphics(1920, 1280, P2D);
  logoMirror2 = createGraphics(1000, 1000, P2D);

  tex= createGraphics(1920, 1280, P2D);
  tex2= createGraphics(1920, 1280, P2D);

  square = createShape(RECT, 0, 0, width, height);

  s3d= createGraphics(width, height, P3D);
  crop2= createGraphics(width, height, P3D);

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

  myBus.sendNoteOff(0, 105, 0);
  myBus.sendNoteOff(0, 106, 0);
  myBus.sendNoteOff(0, 110, 0);
  myBus.sendNoteOff(0, 112, 0);
  myBus.sendNoteOff(0, 113, 0);

  // Vibert's
  animations = new Animations(logoMirror, logoMirror2);
}

void logoDrawing() {
  if (frameCount%100==0) if (bgChanging) {
    imgIndex=int(random(5));
    blendGLSL.set( "lowLayer", bgs [imgIndex]);
    donothing.set( "lowLayer", bgs [imgIndex]);
  }
  if (frameCount%100==0) if (bgBlending) blendIndex = int(random(10));


  //---------------
  logoMirror.beginDraw();
  logoMirror.background(125);
  logoMirror.imageMode(CENTER);
  animations.draw();
  logoMirror.endDraw();

  logoMoving.beginDraw();
  logoMoving.background(125);
  logoMoving.imageMode(CENTER);
  logos(logoMoving, logoMirror);//鏡射
  logoMoving.endDraw();


  //---------------
  logoMirror2.beginDraw();
  logoMirror2.background(255, 0);
  logoMirror2.imageMode(CENTER);
  animations.innerDraw();
  logoMirror2.endDraw();

  logoMoving2.beginDraw();
  logoMoving2.background(255, 0);
  logoMoving2.imageMode(CENTER);
  logos(logoMoving2, logoMirror2);//鏡射
  logoMoving2.endDraw();
}



void logos(PGraphics who, PGraphics trarget) {
  who.pushMatrix();
  who.translate(0+228, trarget.height/2);
  who.scale(1, 1);
  who.image(trarget, 0, 0, trarget.width*1.4, trarget.height*1.6);
  who.popMatrix();

  who.pushMatrix();
  who.translate(trarget.width+628, trarget.height/2);
  who.scale(-1, 1);
  who.image(trarget, 0, 0, trarget.width*1.4, trarget.height*1.6);
  who.popMatrix();
}

class  LogoDraw {
  PGraphics canvas;
  PGraphics who;
  float alpha;
  LogoDraw() {   
  }

  void draw(PGraphics _c,PGraphics _mirror,float _alpha) {
    alpha=_alpha;
    canvas = _c;
    who=_mirror;

    if (frameCount%50==0) {
      if (logo3Changing) {
        pp=int(random(15));
      }
    }
    float soundVol=map(middle, 0, 1, 0.3, 2.0);
    if (ctl82>0.1) {
      logoMovingStep=(logoMovingStep+(logoMovingSpeed*ctl82))%360;
    } else {
      logoMovingStep=(logoMovingStep+(logoMovingSpeed*soundVol))%360;
    }
    canvas.pushMatrix();
    canvas.translate(0+250, who.height/2);
    canvas.scale(logoScale, logoScale);
    canvas.rotate(radians(logoMovingStep));
    canvas.tint(255, alpha);
    canvas.image(pattern[pp], 0, 0, who.width, who.height);
    canvas.popMatrix();

    canvas.pushMatrix();
    canvas.translate(who.width+250, who.height/2);
    canvas.scale(-logoScale, -logoScale);
    canvas.rotate(radians(logoMovingStep));
    canvas.tint(255, alpha);
    canvas.image(pattern[pp], 0, 0, who.width, who.height);
    canvas.popMatrix();
  }
}