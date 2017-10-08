import com.jogamp.opengl.GL2;
import geomerative.*;

//---------------
import controlP5.*;
ControlP5 cp5;
CheckBox checkbox;

PMatrix mat_scene; // to store initial PMatrix

float ry;
PImage[] bgs=new PImage[5] ;
PImage logo;
PImage[] ptns=new PImage[17] ;

PShape square;
PShape globe;
PGraphics tex;
PGraphics s3d;
PGraphics scence;
PGraphics finalRender;
PGraphics ptnGroup;
int indexPtns=0;

int workTime;

boolean showPtnTgl=false ;
boolean showbgTgl=false ;

void settings() {
  size(1200, 400, P3D);
  PJOGL.profile = 1;
}

void setup() {
  RG.init(this);
  mat_scene = getMatrix();
  logoSetting() ;
  s3dSetting() ;
  square = createShape(RECT, 0, 0, width, height);
  tex= createGraphics(1500, 1000, P2D);
  s3d= createGraphics(width, height, P3D);

  ptnGroup= createGraphics(width, height, P2D);
  scence= createGraphics(width, height, P2D);
  finalRender= createGraphics(width, height, P2D);


  shaderSetting();
  uiSetting();

  globe = createShape(SPHERE, 600);
  globe.setStroke(false);
  globe.setTexture(tex);
}

void draw() {

  background(0);
  workTime=millis();
  //autoChBg();
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
  scence.image(s3d, width/2, height/2, width, height);//面具畫在的buffer
  scence.endDraw();


  if (showPtnTgl==true) {
    ptnGroup.beginDraw();
    ptnGroup.background(0);
    ptnGroup.imageMode(CENTER);
    if (frameCount%10==0) {
      indexPtns =int(random(14));
      int index =int(random(5));
      finalGLSL.set( "blendAlpha", 1.0f );
      finalGLSL.set( "blendMode", indexSelectBlend [index]);
    }

    ptnGroup.image(ptns[indexPtns], width/2, height/2, width, height);//圖騰畫在的buffer
    ptnGroup.endDraw();

    finalRender.beginDraw(); 
    finalRender.background(255);
    finalRender.shader(finalGLSL);
    finalRender.rectMode(CENTER);
    finalRender.rect(width/2, height/2, tex.width*1.2f, tex.height*1.6f);  //finalGLSL 產生的東西繪製在這裡
    finalRender.endDraw();

    //---------------*過一個加強對比效果
    contrastGLSL.set("vel", 0.1, 0.5);
    shader(contrastGLSL);
    //---------------

    imageMode(CENTER);
    tint(255, 255);

    image(finalRender, width/2, height/2, width, height);
  } else {

    //---------------*過一個加強對比效果
    contrastGLSL.set("vel", 0.1, 0.5);
    shader(contrastGLSL);
    //---------------

    imageMode(CENTER);
    tint(255, 255);

    image(scence, width/2, height/2, width, height);
  }
  resetShader();
  showFrameRate();
  if (keyPressed==true &&key == 's') {
    //saveFrame(frameCount+".png");
  }
}


void showPtn(boolean theFlag) {
  if (theFlag==true) showPtnTgl=true;
  else showPtnTgl=false;
}