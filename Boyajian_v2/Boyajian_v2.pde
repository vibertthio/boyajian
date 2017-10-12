// Aluan
/////dsfsdfsdfs

//Boyajian_v2.pde
import com.jogamp.opengl.GL2;
import geomerative.*;

//---------------
import themidibus.*;
MidiBus myBus;

//---------------
import controlP5.*;
ControlP5 cp5;
CheckBox checkbox;

//---------------
import oscP5.*;
import netP5.*;
OscP5  receiveCeiling;

float ry;
PImage[] bgs=new PImage[5] ;
PImage[] ptns=new PImage[17] ;
PImage[] pattern = new PImage[15];
PImage logo;
float ratio;

PShape square;

PGraphics tex;
PGraphics s3d;
PGraphics scence;
PGraphics finalRender;
PGraphics ptnGroup;
PGraphics columnImg;

int indexPtns=0;
int workTime;
int[] show= new int[20];

float ptnScale=1;
float ptnRo=0;
float[] layer=new  float[9];

boolean showPtnTgl=false ;
boolean showbgTgl=false ;
boolean oscCtl=true;

color maskNmae=color(255);

pdMetro autoCamMetro ;
pdLine2[] countX=new pdLine2[20];

void settings() {
  size(1200, 400, P3D);
  PJOGL.profile = 1;
}

void setup() {
  layer[1]=255;
  RG.init(this);

  randomSeed(1000);
  MidiBus.list();
  myBus = new MidiBus(this, 0, 1);
  receiveCeiling = new OscP5(this, 12000);
  defultSetting() ;
  s3dSetting() ;
  shaderSetting();
  uiSetting();

  ratio=float(width)/1000;

  autoCamMetro=new pdMetro(1000);
  autoCamMetro.reset();
  autoCamMetro.tgl=false;
  for (int i=0; i<20; i++) {
    countX[i]=new pdLine2(0, 1000);
  }
}

void draw() {
  if (frameCount==50) {
    defultCam();
  }
  blendMode(NORMAL);
  for (int i=0; i<20; i++) {
    countX[i].update();
  }

  autoCamMetro.update();
  if (autoCamMetro.bang==true) {
    autoCamMetro.bang=false;
    randomCam();
  }

  background(0);
  workTime=millis();
  ////autoChBg();
  s3dDrawing() ;
  //---------------*blendGLSL即時參數
  blendGLSL.set( "blendAlpha", 0.7f );
  blendGLSL.set( "blendMode", indexSelectBlend [blendIndex] );
  //---------------*圖騰繪製
  logoDrawing() ;
  //---------------*底圖繪製
  tex.beginDraw();
  tex.background(255);
  tex.shader(blendGLSL);
  tex.rectMode(CENTER);
  tex.rect(width/2, height/2, tex.width*1.2f, tex.height*1.6f);  //blendGLSL 產生的東西繪製在這裡
  tex.endDraw();

  scence.beginDraw();
  scence.background(0);
  scence.imageMode(CENTER);
  //---------------*過一個加強對比效果
  contrastGLSL.set("vel", contrastA, contrastB);
  scence.shader(contrastGLSL);
  //---------------*過一個加強對比效果
  scence.image(s3d, width/2, height/2, width, height);//面具畫在的buffer
  scence.endDraw();

  //---------------*過一個視覺特效
  effectGLSL.set("time", millis()/1000.0);
  shader(effectGLSL);
  //---------------*過一個視覺特效



  ptnGroup.beginDraw();
  ptnGroup.background(0);
  ptnGroup.imageMode(CENTER);
  finalGLSL.set( "blendAlpha", layer[5]/255 );
  finalGLSL.set( "allAlpha", layer[1]/255 );
  if (frameCount%10==0) {
    indexPtns =int(random(14));
    int index =int(random(5));

    finalGLSL.set( "blendMode", indexSelectBlend [index]);
  }
  if (frameCount%30==0) {
    ptnScale=random(0.5, 1.5);
    int k=int(random(4));
    if (k==0) ptnRo=90;
    else ptnRo=0;
  }
  ptnGroup.translate(width/2, height/2);
  ptnGroup.rotate(radians(ptnRo));
  ptnGroup.tint(255);
  ptnGroup.image(ptns[indexPtns], 0, 0, width*ptnScale, height*ptnScale);//圖騰畫在的buffer
  ptnGroup.endDraw();

  finalRender.beginDraw();
  finalRender.background(255);
  finalRender.shader(finalGLSL);
  finalRender.rectMode(CENTER);
  finalRender.rect(width/2, height/2, tex.width*1.2f, tex.height*1.6f);  //finalGLSL 產生的東西繪製在這裡
  finalRender.endDraw();
  imageMode(CENTER);
  tint(255, 255);
  image(finalRender, width/2, height/2, width, height);

  resetShader();


  if (layer[4]>10) {//分割圖騰
    visualColumnDrawing();
    imageMode(CENTER);
    blendMode(ADD);
    tint(255, layer[4]);
    image(columnImg, width/2, height/2, width, height);
  }

  pushStyle();
  blendMode(BLEND);
  fill(0, 0, 0, 255-layer[1]);
  noStroke();
  rect(0, 0, width, height);
  popStyle();

  showFrameRate();
  //stroke(255);

  if (keyPressed==true &&key == 's') {
    //saveFrame(frameCount+".png");
  }
}
