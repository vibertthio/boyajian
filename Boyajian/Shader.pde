//Shader.pde
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

//vibert
int blendIndex=8;
int imgIndex=3;

PShader contrastGLSL;
PShader effectGLSL;

PShader blendGLSL;
PShader donothing;

PShader finalGLSL;

float contrastA=0.1;
float contrastB=0.5;

void shaderSetting() {

  for (int i=0; i<7; i++) bgs[i]=loadImage("img/bgtex_"+i+".jpg");
  for (int i=0; i<14; i++) ptns[i]=loadImage("img/ptns_"+i+".png");
  for (int i=0; i<15; i++) pattern[i]=loadImage("img/p_"+i+".png");

  contrastGLSL = loadShader("glsl/contrast.glsl");
  contrastGLSL.set("vel", contrastA, contrastB);

  effectGLSL = loadShader("glsl/no.glsl");

  donothing= loadShader("glsl/blendMode.glsl");
  donothing.set( "lowLayer", bgs [imgIndex]);
  donothing.set( "topLayer", logoMoving2 );
  donothing.set( "sketchSize", float(width), float(height) );
  donothing.set( "topLayerResolution", float( tex2.width ), float( tex2.height ) );
  donothing.set( "lowLayerResolution", float( tex2.width ), float( tex2.height ) );
  donothing.set( "allAlpha", 1.0f );
  donothing.set( "showAlpha", 1 );


  blendGLSL= loadShader("glsl/blendMode.glsl");
  blendGLSL.set( "lowLayer", bgs [imgIndex]);
  blendGLSL.set( "topLayer", logoMoving );
  blendGLSL.set( "sketchSize", float(width), float(height) );
  blendGLSL.set( "topLayerResolution", float( tex.width ), float( tex.height ) );
  blendGLSL.set( "lowLayerResolution", float( tex.width ), float( tex.height ) );
  blendGLSL.set( "allAlpha", 1.0f );
  blendGLSL.set( "showAlpha", 0 );


  finalGLSL= loadShader("glsl/blendMode.glsl");
  finalGLSL.set( "lowLayer", scence);
  finalGLSL.set( "topLayer", ptnGroup);
  finalGLSL.set( "sketchSize", float(width), float(height) );
  finalGLSL.set( "topLayerResolution", float( scence.width ), float( scence.height ) );
  finalGLSL.set( "lowLayerResolution", float( scence.width ), float( scence.height ) );
  finalGLSL.set( "allAlpha", 1.0f );
  finalGLSL.set( "showAlpha", 0 );


  square.setTexture(tex);
  square.setStroke(false);
}

void draw2Split() {
  imageMode(CENTER);
  blendMode(ADD);
  crop2.beginDraw();
  crop2.imageMode(CENTER);
  crop2.image(finalRender, width/2, height/2, width, height);
  crop2.fill(0);
  crop2.rect(0, 0, float(width)/4, height);
  crop2.rect(float(width)/4*3, 0, width, height);
  crop2.endDraw();

  pushMatrix();
  image(crop2, width/4, height/2, width, height);
  popMatrix();

  pushMatrix();
  translate(float(width)/4*3, height/2);
  scale(-1, 1);
  image(crop2, 0, 0, width, height);
  popMatrix();

  //stroke(255);
  //line(width/2, 0, width/2, height);
}

void draw4Split() {
  imageMode(CENTER);
  blendMode(ADD);
  crop2.beginDraw();
  crop2.imageMode(CENTER);
  crop2.image(finalRender, width/2, height/2, width, height);
  crop2.fill(0);
  float www=width/8;
  crop2.rect(0, 0, www*3, height);
  crop2.rect(www*5, 0, width, height);
  crop2.endDraw();
  image(crop2, www*1, height/2, width, height);

  pushMatrix();
  translate(www*3, height/2);
  scale(-1, 1);
  image(crop2, 0, 0, width, height);
  popMatrix();

  image(crop2, www*5, height/2, width, height);

  pushMatrix();
  translate(www*7, height/2);
  scale(-1, 1);
  image(crop2, 0, 0, width, height);
  popMatrix();
  stroke(255);
  float ww=width/4;
  //line(ww*1, 0, ww*1, height);
  //line(ww*2, 0, ww*2, height);
  //line(ww*3, 0, ww*3, height);
}
