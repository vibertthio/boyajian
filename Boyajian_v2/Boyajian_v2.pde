import com.jogamp.opengl.GL2;
import geomerative.*;
PMatrix mat_scene; // to store initial PMatrix

float ry;
PImage[] bgs=new PImage[5] ;
PImage logo;


PShape square;
PShape globe;
PGraphics tex;
PGraphics s3d;
PGraphics scence;

PShader texlightGLSL;
PShader blendGLSL;
PShader contrastGLSL;
int workTime;

void settings() {
  size(1200, 400, P3D);
  PJOGL.profile = 1;
}

void setup() {
  RG.init(this);
  mat_scene = getMatrix();
  logoSetting() ;
  square = createShape(RECT, 0, 0, width, height);
  tex= createGraphics(1500, 1000, P2D);
  s3d= createGraphics(width, height, P3D);
  scence= createGraphics(width, height, P2D);

  shaderSetting();

  // Vibert
  blendIndex = 7;
  blendGLSL.set( "lowLayer", bgs [2]);

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

  //---------------*過一個加強對比效果
  contrastGLSL.set("vel", 0.1, 0.5);
  shader(contrastGLSL);

  //---------------
  imageMode(CENTER);
  tint(255, 255);
  image(scence, width/2, height/2, width, height);

  resetShader();
  showFrameRate();
  if (keyPressed==true &&key == 's') {
    saveFrame(frameCount+".png");
  }
}