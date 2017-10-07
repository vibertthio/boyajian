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

int blendIndex=0;
int imgIndex=0;

void shaderSetting() {

  texlightGLSL = loadShader("glsl/texlightfrag.glsl", "glsl/texlightvert.glsl");
  contrastGLSL = loadShader("glsl/contrast.glsl");

  logo=loadImage("img/logo.png");
  bgs[0]=loadImage("img/bg_0.png");
  bgs[1]=loadImage("img/bg_1.png");
  bgs[2]=loadImage("img/bg_2.png");
  bgs[3]=loadImage("img/bg_3.png");
  bgs[4]=loadImage("img/bg_4.png");


  blendGLSL= loadShader("glsl/blendMode.glsl");
  blendGLSL.set( "lowLayer", bgs [imgIndex]);
  blendGLSL.set( "topLayer", logoMoving );
  // blendGLSL.set( "topLayer", logoMirror );
  blendGLSL.set( "sketchSize", float(width), float(height) );
  blendGLSL.set( "topLayerResolution", float( tex.width ), float( tex.height ) );
  blendGLSL.set( "lowLayerResolution", float( tex.width ), float( tex.height ) );

  blendGLSL.set( "blendMode", BL_OVERLAY  );

  square.setTexture(tex);
  square.setStroke(false);
}
