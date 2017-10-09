static final int BL_DARKEN        =  0;
static final int BL_MULTIPLY      =  1;

static final int BL_COLORBURN     =  2;
static final int BL_LINEARBURN    =  3;
static final int BL_DARKERCOLOR   =  4;

static final int BL_LIGHTEN       =  5;
static final int BL_SCREEN        =  6;
static final int BL_COLORDODGE    =  7;
static final int BL_LINEARDODGE   =  8;
static final int BL_LIGHTERCOLOR  =  9;

static final int BL_OVERLAY       = 10;
static final int BL_SOFTLIGHT     = 11;
static final int BL_HARDLIGHT     = 12;
static final int BL_VIVIDLIGHT    = 13;
static final int BL_LINEARLIGHT   = 14;
static final int BL_PINLIGHT      = 15;
static final int BL_HARDMIX       = 16;

static final int BL_DIFFERENCE    = 17;
static final int BL_EXCLUSION     = 18;
static final int BL_SUBSTRACT     = 19;
static final int BL_DIVIDE        = 20;

static final int BL_HUE           = 21;
static final int BL_COLOR         = 22;
static final int BL_SATURATION    = 23;
static final int BL_LUMINOSITY    = 24;
String[] blendNames = {
  "Darken", 
  "Multiply", 
  "Color burn", 
  "Linear burn", 
  "Darker color", 
  "Lighten", 
  "Screen", 
  "Color dodge", 
  "Linear dodge", 
  "Lighter color", 
  "Overlay", 
  "Soft light", 
  "Hard light", 
  "Vivid light", 
  "Linear light", 
  "Pin light", 
  "Hard mix", 
  "Difference", 
  "Exclusion", 
  "Substract", 
  "Divide", 
  "Hue", 
  "Color", 
  "Saturation", 
  "Luminosity"
};
int [] indexSelectBlend={ 0, 1, 4, 7, 10, 12, 15, 17, 19, 22};
int [] indexSelectEffect={ 0, 1, 2, 3, 4};

//vibert
int blendIndex=7;
int imgIndex=2;

PShader contrastGLSL;
PShader effectGLSL;

PShader blendGLSL;
PShader finalGLSL;

void shaderSetting() {
  logo=loadImage("img/logo.png");
  for (int i=0; i<5; i++) bgs[i]=loadImage("img/bgtex_"+i+".jpg");
  for (int i=0; i<14; i++) ptns[i]=loadImage("img/ptns_"+i+".png");
  for (int i=0; i<6; i++) pattern[i]=loadImage("img/p_"+i+".png");

  contrastGLSL = loadShader("glsl/contrast.glsl");
  contrastGLSL.set("vel", 0.1, 0.5);
  
  effectGLSL = loadShader("glsl/no.glsl");

  blendGLSL= loadShader("glsl/blendMode.glsl");
  blendGLSL.set( "lowLayer", bgs [imgIndex]);
  blendGLSL.set( "topLayer", logoMoving );
  blendGLSL.set( "sketchSize", float(width), float(height) );
  blendGLSL.set( "topLayerResolution", float( tex.width ), float( tex.height ) );
  blendGLSL.set( "lowLayerResolution", float( tex.width ), float( tex.height ) );


  finalGLSL= loadShader("glsl/blendMode.glsl");
  finalGLSL.set( "lowLayer", scence);
  finalGLSL.set( "topLayer", ptnGroup);
  finalGLSL.set( "sketchSize", float(width), float(height) );
  finalGLSL.set( "topLayerResolution", float( scence.width ), float( scence.height ) );
  finalGLSL.set( "lowLayerResolution", float( scence.width ), float( scence.height ) );


  square.setTexture(tex);
  square.setStroke(false);
}