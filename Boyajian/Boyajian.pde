//Boyajian_v2.pde
//*按鈕1-9各種posteffect效果
//*按鈕q分割畫面一，按鈕q分割畫面二，按鈕z分割畫面4。
//*按鈕t旋轉鏡頭，按鈕r回復鏡頭，按鈕e拉遠鏡頭。
//*按鈕w切換wireframe
//*按鈕k切換變形
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
//---------------

PImage[] bgs=new PImage[7] ;
PImage[] ptns=new PImage[17] ;
PImage[] pattern = new PImage[15];

PShape square;
PGraphics tex;
PGraphics s3d;
PGraphics scence;
PGraphics finalRender;
PGraphics ptnGroup;
PGraphics columnImg;
PGraphics crop2;

int indexPtns=0;
int workTime;
int[] show= new int[20];
int splitNum=1;
float countWhite=0;
float countWhiteAdd=0;

//ptnGroup
float ptnScale=1;
float ptnRo=0;
//ptnGroup

float[] layer=new  float[15];

boolean showbgTgl=false ;
boolean oscCtl=true;
boolean record=false;
boolean splitScreen=false;



pdMetro autoCamMetro ;
pdMetro autoCamMetroUpDown ;
int autoCamMetroUpDownCount=0;
pdLine2[] countX=new pdLine2[20];
pdLine2 smooth;

void settings() {
  size(1200, 400, P3D);
  PJOGL.profile = 1;
}

void setup() {
  layer[1]=255;//整體alpha
  layer[2]=0;//slash
  layer[3]=0;//strip
  layer[4]=0;//blackColumn
  layer[5]=0;//幾何剪影
  layer[6]=220;//0-115 for growGrid,135~255 for rotateGrid
  layer[8]=0;//logoDraw
  RG.init(this);

  randomSeed(1000);
  MidiBus.list();
  myBus = new MidiBus(this, 0, 1);
  receiveCeiling = new OscP5(this, 12000);
  defultSetting() ;
  s3dSetting() ;
  shaderSetting();
  uiSetting();

  autoCamMetro=new pdMetro(1000);
  autoCamMetro.reset();
  autoCamMetro.tgl=false;

  autoCamMetroUpDown=new pdMetro(1500);
  autoCamMetroUpDown.reset();
  autoCamMetroUpDown.tgl=false;

  smooth=new pdLine2(0,100);

  for (int i=0; i<20; i++) {
    countX[i]=new pdLine2(0, 1000);
  }
  //hint(DISABLE_DEPTH_MASK);
}

void draw() {
  smooth.update();
  background(0);
  workTime=millis();
  blendMode(NORMAL);
  cameraMoving();

  for (int i=0; i<20; i++) {
    countX[i].update();
  }
  s3dDrawing() ;
  //---------------*blendGLSL即時參數
  blendGLSL.set( "blendAlpha", 0.7f );
  if (frameCount%30==0) {
    //blendGLSL.set( "allAlpha", 1.0f+random(-0.1,0.0) );
  }
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
  //effectGLSL.set("pos", 2.00,1.06,1.01);
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

  tint(255, 255);
  {//split screen final render
    if (splitNum==1) {
      blendMode(BLEND);
      imageMode(CENTER);
      image(finalRender, width/2, height/2, width, height);
    }
    if (splitNum==2) draw2Split() ;
    if (splitNum==4) draw4Split() ;
  }

  resetShader();

  if (layer[4]>10) {//分割圖騰
    visualColumnDrawing();
  }

  if (countWhiteAdd>0) {
    countWhite=(countWhite+countWhiteAdd)%400;
    float countWhiteAlpha=0;
    if (countWhite<255) {
      countWhiteAlpha=countWhite;

      fill(255, 255-countWhiteAlpha);
      rect(0, 0, width, height);
    }
  }


  pushStyle();//黑色fadeOut遮罩
  blendMode(BLEND);
  fill(0, 0, 0, 255-layer[1]);
  noStroke();
  rect(0, 0, width, height);
  popStyle();

  //stroke(255);
  //line(width/2,0,width/2,height);
  showFrameRate();//訊息
  //if(record==true)saveFrame("data/record/"+frameCount+".png");
}
