import com.jogamp.opengl.GL2;

float ry;
PImage[] bgs=new PImage[5] ;
PImage logo;

PShape square;
PGraphics tex;
PGraphics s3d;
PGraphics scence;

PShader texlightGLSL;
PShader shadowGLSL;
PShader blendGLSL;
PShader contrastGLSL;
float xx, yy;

float a1;
float a2;
float a3;
float a4;
int workTime;

void settings() {
  size(1200, 400, P3D);
  PJOGL.profile = 1;
}

void setup() {
  logoSetting() ;
  square = createShape(RECT, 0, 0, width, height);
  tex= createGraphics(1500, 1000, P2D);
  s3d= createGraphics(width, height, P3D);
  scence= createGraphics(width, height, P2D);

  shaderSetting();

  background(255);

  // Vibert
  blendIndex = 7;
  blendGLSL.set( "lowLayer", bgs [2]);
}

void draw() {
  background(0);
  workTime=millis();

  if ( frameCount % 100 == 0  ) {
    blendIndex = ( blendIndex + 1 ) % 10;
  }
  if ( frameCount % 300 == 0  ) {
    imgIndex = ( imgIndex + 1 ) % 5;
    blendGLSL.set( "lowLayer", bgs [imgIndex]);
  }
  a1=(a1+1)%360;
  a2=(a1+1)%180;
  a3=(a1+1)%150;

  xx=map(sin(float(frameCount%300)/300*6.28), -1, 1, -1, 1);
  yy=map(sin(float(frameCount%600)/600*6.28), -1, 1, 0, 1);
  shadowGLSL.set("xx", xx);
  shadowGLSL.set("yy", yy);

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
  tex.rect(width/2, height/2, tex.width, tex.height);  //blendGLSL 產生的東西繪製在這裡
  tex.endDraw();

  //---------------*shadowGLSL即時參數
  shadowGLSL.set("bg", tex);
  shadowGLSL.set("bgResolution", float( tex.width )*0.9, float( tex .height ) *0.9);
  // shadowGLSL.set("bgoffset", 0.0, 0.43+sin(frameCount*0.05)*0.12 );
  shadowGLSL.set("bgoffset", 0.0, 0.43+sin(frameCount*0.005)*0.12 );

  scence.beginDraw();
  scence.background(0);
  scence.shader(shadowGLSL);
  scence.imageMode(CENTER);
  scence.image(s3d, width/2, height/2, width, height);//面具畫在的buffer
  scence.endDraw();

  //---------------*過一個加強對比效果
  contrastGLSL.set("vel", 0.15, 0.75);
  shader(contrastGLSL);

  //---------------
  imageMode(CENTER);
  tint(255, 255);
  image(scence, width/2, height/2, width, height);

  resetShader();
  showFrameRate();
}



void mousePressed() {
  for (int i=0; i<nb; i++) {
    slash[i].initSlash();
  }
}


void keyPressed() {
  if (key == '1') {
    thread("maskEyeSetting");
  }
  if (key == '2') {
    thread("maskListenSetting");
  }
  if (key == '3') {
    thread("maskSmellSetting");
  }
  if (key == '4') {
    thread("maskTouchSetting");
  }
}
