import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import com.jogamp.opengl.GL2; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Boyajian_v2 extends PApplet {



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

public void settings() {
  size(1200, 400, P3D);
  PJOGL.profile = 1;
}

public void setup() {
  logoSetting() ;
  square = createShape(RECT, 0, 0, width, height);
  tex= createGraphics(1500, 1000, P2D);
  s3d= createGraphics(width, height, P3D);
  scence= createGraphics(width, height, P2D);

  shaderSetting();

  background(255);
}

public void draw() {
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

  xx=map(sin(PApplet.parseFloat(frameCount%300)/300*6.28f), -1, 1, -1, 1);
  yy=map(sin(PApplet.parseFloat(frameCount%600)/600*6.28f), -1, 1, 0, 1);
  shadowGLSL.set("xx", xx);
  shadowGLSL.set("yy", yy);

  s3dDrawing() ;

  //---------------*blendGLSL\u5373\u6642\u53c3\u6578
  blendGLSL.set( "blendAlpha", 0.7f );
  blendGLSL.set( "blendMode", indexSelectBlend [blendIndex] );

  //---------------*\u5716\u9a30\u7e6a\u88fd
  logoDrawing() ;

  //---------------*\u5e95\u5716\u7e6a\u88fd
  tex.beginDraw();
  tex.background(255);
  tex.shader(blendGLSL);
  tex.rectMode(CENTER);
  tex.rect(width/2, height/2, tex.width, tex.height);  //blendGLSL \u7522\u751f\u7684\u6771\u897f\u7e6a\u88fd\u5728\u9019\u88e1
  tex.endDraw();

  //---------------*shadowGLSL\u5373\u6642\u53c3\u6578
  shadowGLSL.set("bg", tex);
  shadowGLSL.set("bgResolution", PApplet.parseFloat( tex.width )*0.9f, PApplet.parseFloat( tex .height ) *0.9f);
  shadowGLSL.set("bgoffset", 0.0f, 0.43f+sin(frameCount*0.005f)*0.12f );

  scence.beginDraw();
  scence.background(0);
  scence.shader(shadowGLSL);
  scence.imageMode(CENTER);
  scence.image(s3d, width/2, height/2, width, height);//\u9762\u5177\u756b\u5728\u7684buffer
  scence.endDraw();

  //---------------*\u904e\u4e00\u500b\u52a0\u5f37\u5c0d\u6bd4\u6548\u679c
  contrastGLSL.set("vel", 0.15f, 0.75f);
  shader(contrastGLSL);

  //---------------
  imageMode(CENTER);
  tint(255, 255);
  image(scence, width/2, height/2, width, height);

  resetShader();
  showFrameRate();
}



public void mousePressed() {
  for (int i=0; i<nb; i++) {
    slash[i].initSlash();
  }
}


public void keyPressed() {
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
/*
 * Easing.pde - brings Robert Penner's easing functions into Processing
 * (c) 2015 cocopon.
 *
 * See the following to learn more about these famous functions:
 * http://www.robertpenner.com/easing/
 *
 * License:
 * http://www.robertpenner.com/easing_terms_of_use.html
 */

/*
 * Usage:
 *
 * 1. Put this file in the same folder as your sketch.
 *   + your_sketch/
 *   |-- your_sketch.pde
 *   |-- Easing.pde
 *   |-- ...
 *
 * 2. Enjoy!
 *   // Easier way to use an easing function
 *   // (t: 0.0 ~ 1.0)
 *   float value = easeOutBack(t);
 *   ...
 *
 *   // You can also instanciate an easing function
 *   Easing easing = new EasingOutBack();
 *   float value = easing.get(t);
 *   ...
 *
 *   // Or using an anonymous class to instanciate a custom easing function
 *   Easing easing = new Easing() {
 *     public float get(float t) {
 *       return sqrt(t);
 *     }
 *   };
 *   float value = easing.get(t);
 *   ...
 */

public interface Easing {
  public float get(float t);
}

public class EasingLinear implements Easing {
  public float get(float t) {
    return t;
  }
}

public class EasingInBack implements Easing {
  public float get(float t, float s) {
    return t * t * ((s + 1) * t - s);
  }

  public float get(float t) {
    return get(t, 1.70158f);
  }
}

public class EasingInBounce implements Easing {
  public float get(float t) {
    t = 1.0f - t;

    if (t < 1 / 2.75f) {
      return 1.0f - (7.5625f * t * t);
    }
    if (t < 2 / 2.75f) {
      t -= 1.5f / 2.75f;
      return 1.0f - (7.5625f * t * t + 0.75f);
    }
    if (t < 2.5f / 2.75f) {
      t -= 2.25f / 2.75f;
      return 1.0f - (7.5625f * t * t + 0.9375f);
    }

    t -= 2.625f / 2.75f;
    return 1.0f - (7.5625f * t * t + 0.984375f);
  }
}

public class EasingInCirc implements Easing {
  public float get(float t) {
    return -(sqrt(1 - t * t) - 1);
  }
}

public class EasingInCubic implements Easing {
  public float get(float t) {
    return t * t * t;
  }
}

public class EasingInElastic implements Easing {
  public float get(float t, float s) {
    float p = 0.3f;
    float a = 1.0f;

    if (t == 0) {
      return 0;
    }
    if (t == 1.0f) {
      return 1.0f;
    }

    if (a < 1.0f) {
      a = 1.0f;
      s = p / 4;
    } else {
      s = p / (2 * 3.1419f) * asin(1.0f / a);
    }

    --t;
    return -(a * pow(2, 10 * t) * sin((t - s) * (2 * 3.1419f) / p));
  }

  public float get(float t) {
    return get(t, 1.70158f);
  }
}

public class EasingInExpo implements Easing {
  public float get(float t) {
    return (t == 0)
      ? 0 
      : pow(2, 10 * (t - 1));
  }
}

public class EasingInQuad implements Easing {
  public float get(float t) {
    return t * t;
  }
}

public class EasingInQuart implements Easing {
  public float get(float t) {
    return t * t * t * t;
  }
}

public class EasingInQuint implements Easing {
  public float get(float t) {
    return t * t * t * t * t;
  }
}

public class EasingInSine implements Easing {
  public float get(float t) {
    return -cos(t * (PI / 2)) + 1.0f;
  }
}

public class EasingOutBack implements Easing {
  public float get(float t, float s) {
    --t;
    return t * t * ((s + 1.0f) * t + s) + 1.0f;
  }

  public float get(float t) {
    return get(t, 1.70158f);
  }
}

public class EasingOutBounce implements Easing {
  public float get(float t) {
    if (t < 1 / 2.75f) {
      return 7.5625f * t * t;
    }
    if (t < 2 / 2.75f) {
      t -= 1.5f / 2.75f;
      return 7.5625f * t * t + 0.75f;
    }
    if (t < 2.5f / 2.75f) {
      t -= 2.25f / 2.75f;
      return 7.5625f * t * t + 0.9375f;
    }

    t -= 2.625f / 2.75f;
    return 7.5625f * t * t + 0.984375f;
  }
}

public class EasingOutCirc implements Easing {
  public float get(float t) {
    --t;
    return sqrt(1 - t * t);
  }
}

public class EasingOutCubic implements Easing {
  public float get(float t) {
    --t;
    return t * t * t + 1;
  }
}

public class EasingOutElastic implements Easing {
  public float get(float t, float s) {
    float p = 0.3f;
    float a = 1.0f;

    if (t == 0) {
      return 0;
    }
    if (t == 1.0f) {
      return 1.0f;
    }

    if (a < 1.0f) {
      a = 1.0f;
      s = p / 4;
    } else {
      s = p / (2 * 3.1419f) * asin(1.0f / a);
    }
    return a * pow(2, -10 * t) * sin((t - s) * (2 * 3.1419f) / p) + 1.0f;
  }

  public float get(float t) {
    return get(t, 1.70158f);
  }
}

public class EasingOutExpo implements Easing {
  public float get(float t) {
    return (t == 1.0f)
      ? 1.0f
      : (-pow(2, -10 * t) + 1);
  }
}

public class EasingOutQuad implements Easing {
  public float get(float t) {
    return -t * (t - 2);
  }
}

public class EasingOutQuart implements Easing {
  public float get(float t) {
    --t;
    return 1.0f - t * t * t * t;
  }
}

public class EasingOutQuint implements Easing {
  public float get(float t) {
    --t;
    return t * t * t * t * t + 1;
  }
}

public class EasingOutSine implements Easing {
  public float get(float t) {
    return sin(t * (PI / 2));
  }
}

public class EasingInOutBack implements Easing {
  public float get(float t, float s) {
    float k = 1.525f;

    t *= 2;
    s *= k;

    if (t < 1) {
      return 0.5f * (t * t * ((s + 1) * t - s));
    }
    t -= 2;
    return 0.5f * (t * t * ((s + 1) * t + s) + 2);
  }

  public float get(float t) {
    return get(t, 1.70158f);
  }
}

public class EasingInOutBounce implements Easing {
  Easing inBounce_ = new EasingInBounce();
  Easing outBounce_ = new EasingOutBounce();

  public float get(float t) {
    return (t < 0.5f)
      ? (inBounce_.get(t * 2) * 0.5f)
      : (outBounce_.get(t * 2 - 1.0f) * 0.5f + 0.5f);
  }
}

public class EasingInOutCirc implements Easing {
  public float get(float t) {
    t *= 2;

    if (t < 1) {
      return -0.5f * (sqrt(1 - t * t) - 1);
    }

    t -= 2;
    return 0.5f * (sqrt(1 - t * t) + 1);
  }
}

public class EasingInOutCubic implements Easing {
  public float get(float t) {
    t *= 2;

    if (t < 1) {
      return 0.5f * t * t * t;
    }

    t -= 2;
    return 0.5f * (t * t * t + 2);
  }
}

public class EasingInOutElastic implements Easing {
  public float get(float t, float s) {
    float p =  0.3f * 1.5f;
    float a = 1.0f;

    if (t == 0) {
      return 0;
    }
    if (t == 1.0f) {
      return 1.0f;
    }

    if (a < 1.0f) {
      a = 1.0f;
      s = p / 4;
    } else {
      s = p / (2 * 3.1419f) * asin(1.0f / a);
    }

    if (t < 1) {
      --t;
      return -0.5f * (a * pow(2, 10 * t) * sin((t - s) * (2 * 3.1419f) / p));
    }
    --t;
    return a * pow(2, -10 * t) * sin((t - s) * (2 * 3.1419f) / p) * 0.5f + 1.0f;
  }

  public float get(float t) {
    return get(t, 1.70158f);
  }
}

public class EasingInOutExpo implements Easing {
  public float get(float t) {
    if (t == 0) {
      return 0;
    }
    if (t == 1.0f) {
      return 1.0f;
    }

    t *= 2;
    if (t < 1) {
      return 0.5f * pow(2, 10 * (t - 1));
    }

    --t;
    return 0.5f * (-pow(2, -10 * t) + 2);
  }
}

public class EasingInOutQuad implements Easing {
  public float get(float t) {
    t *= 2;

    if (t < 1) {
      return 0.5f * t * t;
    }

    --t;
    return -0.5f * (t * (t - 2) - 1);
  }
}

public class EasingInOutQuart implements Easing {
  public float get(float t) {
    t *= 2;

    if (t < 1) {
      return 0.5f * t * t * t * t;
    }

    t -= 2;
    return -0.5f * (t * t * t * t - 2);
  }
}

public class EasingInOutQuint implements Easing {
  public float get(float t) {
    t *= 2;

    if (t < 1) {
      return 0.5f * t * t * t * t * t;
    }

    t -= 2;
    return 0.5f * (t * t * t * t * t + 2);
  }
}

public class EasingInOutSine implements Easing {
  public float get(float t) {
    return -0.5f * (cos(PI * t) - 1);
  }
}

Easing easeInBack__    = new EasingInBack();
Easing easeInBounce__  = new EasingInBounce();
Easing easeInCirc__    = new EasingInCirc();
Easing easeInCubic__   = new EasingInCubic();
Easing easeInElastic__ = new EasingInElastic();
Easing easeInExpo__    = new EasingInExpo();
Easing easeInQuad__    = new EasingInQuad();
Easing easeInQuart__   = new EasingInQuart();
Easing easeInQuint__   = new EasingInQuint();
Easing easeInSine__    = new EasingInSine();

Easing easeOutBack__    = new EasingOutBack();
Easing easeOutBounce__  = new EasingOutBounce();
Easing easeOutCirc__    = new EasingOutCirc();
Easing easeOutCubic__   = new EasingOutCubic();
Easing easeOutElastic__ = new EasingOutElastic();
Easing easeOutExpo__    = new EasingOutExpo();
Easing easeOutQuad__    = new EasingOutQuad();
Easing easeOutQuart__   = new EasingOutQuart();
Easing easeOutQuint__   = new EasingOutQuint();
Easing easeOutSine__    = new EasingOutSine();

Easing easeInOutBack__    = new EasingInOutBack();
Easing easeInOutBounce__  = new EasingInOutBounce();
Easing easeInOutCirc__    = new EasingInOutCirc();
Easing easeInOutCubic__   = new EasingInOutCubic();
Easing easeInOutElastic__ = new EasingInOutElastic();
Easing easeInOutExpo__    = new EasingInOutExpo();
Easing easeInOutQuad__    = new EasingInOutQuad();
Easing easeInOutQuart__   = new EasingInOutQuart();
Easing easeInOutQuint__   = new EasingInOutQuint();
Easing easeInOutSine__    = new EasingInOutSine();

public float easeInBack(float t, float s) {
  return ((EasingInBack)easeInBack__).get(t, s);
}

public float easeInBack(float t) {
  return easeInBack__.get(t);
}

public float easeInBounce(float t) {
  return easeInBounce__.get(t);
}

public float easeInCirc(float t) {
  return easeInCirc__.get(t);
}

public float easeInCubic(float t) {
  return easeInCubic__.get(t);
}

public float easeInElastic(float t, float s) {
  return ((EasingInElastic)easeInElastic__).get(t, s);
}

public float easeInElastic(float t) {
  return easeInElastic__.get(t);
}

public float easeInExpo(float t) {
  return easeInExpo__.get(t);
}

public float easeInQuad(float t) {
  return easeInQuad__.get(t);
}

public float easeInQuart(float t) {
  return easeInQuart__.get(t);
}

public float easeInQuint(float t) {
  return easeInQuint__.get(t);
}

public float easeInSine(float t) {
  return easeInSine__.get(t);
}

public float easeOutBack(float t, float s) {
  return ((EasingOutBack)easeOutBack__).get(t, s);
}

public float easeOutBack(float t) {
  return easeOutBack__.get(t);
}

public float easeOutBounce(float t) {
  return easeOutBounce__.get(t);
}

public float easeOutCirc(float t) {
  return easeOutCirc__.get(t);
}

public float easeOutCubic(float t) {
  return easeOutCubic__.get(t);
}

public float easeOutElastic(float t, float s) {
  return ((EasingOutElastic)easeOutElastic__).get(t, s);
}

public float easeOutElastic(float t) {
  return easeOutElastic__.get(t);
}

public float easeOutExpo(float t) {
  return easeOutExpo__.get(t);
}

public float easeOutQuad(float t) {
  return easeOutQuad__.get(t);
}

public float easeOutQuart(float t) {
  return easeOutQuart__.get(t);
}

public float easeOutQuint(float t) {
  return easeOutQuint__.get(t);
}

public float easeOutSine(float t) {
  return easeOutSine__.get(t);
}

public float easeInOutBack(float t, float s) {
  return ((EasingInOutBack)easeInOutBack__).get(t, s);
}

public float easeInOutBack(float t) {
  return easeInOutBack__.get(t);
}

public float easeInOutBounce(float t) {
  return easeInOutBounce__.get(t);
}

public float easeInOutCirc(float t) {
  return easeInOutCirc__.get(t);
}

public float easeInOutCubic(float t) {
  return easeInOutCubic__.get(t);
}

public float easeInOutElastic(float t, float s) {
  return ((EasingInOutElastic)easeInOutElastic__).get(t, s);
}

public float easeInOutElastic(float t) {
  return easeInOutElastic__.get(t);
}

public float easeInOutExpo(float t) {
  return easeInOutExpo__.get(t);
}

public float easeInOutQuad(float t) {
  return easeInOutQuad__.get(t);
}

public float easeInOutQuart(float t) {
  return easeInOutQuart__.get(t);
}

public float easeInOutQuint(float t) {
  return easeInOutQuint__.get(t);
}

public float easeInOutSine(float t) {
  return easeInOutSine__.get(t);
}

public boolean returnState(pdLine l, boolean in) {
  l.update();
  boolean temp=true;
  if (in==true) {
    if (l.done==true) {
      l.done=false;
      temp= true;
    }
  } else if (in==false ) {//fadeout\u6642\u95dc\u9589\u7b97\u5716
    if (l.done==true) {
      temp= false;
    }
  }
  return temp;
}


public void showFrameRate() {
  blendMode(BLEND);
  textSize(26);

  String F="F:"+PApplet.parseInt((PApplet.parseInt(frameRate/4))*4);
  String B=indexSelectBlend [blendIndex]  + ":" + blendNames[ indexSelectBlend [blendIndex]  ];
  String I="bgs:" +imgIndex;
  //text(F, 50, 50);
  //text(B, 50, 100 );
  //text(I, 50, 150 );

  fill(0);
  for (int x = -2; x < 3; x++) {
    for (int i = 1; i <= F.length(); i++) {
      text(F.substring(i-1, i), 50+x+i*18, 50);
    }
    for (int i = 1; i <= F.length(); i++) {
      text(F.substring(i-1, i), 50+i*18, 50+x);
    }
  }
  fill(255);
  for (int i = 1; i <= F.length(); i++) {
    text(F.substring(i-1, i), 50+i*18, 50);
  }


  fill(0);
  for (int x = -2; x < 3; x++) {
    for (int i = 1; i <= B.length(); i++) {
      text(B.substring(i-1, i), 50+x+i*18, 100);
    }
    for (int i = 1; i <= B.length(); i++) {
      text(B.substring(i-1, i), 50+i*18, 100+x);
    }
  }
  fill(255);
  for (int i = 1; i <= B.length(); i++) {
    text(B.substring(i-1, i), 50+i*18, 100);
  }


  fill(0);
  for (int x = -2; x < 3; x++) {
    for (int i = 1; i <= I.length(); i++) {
      text(I.substring(i-1, i), 50+x+i*18, 150);
    }
    for (int i = 1; i <= I.length(); i++) {
      text(I.substring(i-1, i), 50+i*18, 150+x);
    }
  }
  fill(255);
  for (int i = 1; i <= I.length(); i++) {
    text(I.substring(i-1, i), 50+i*18, 150);
  }
}

public void s3dDrawing() {

  s3d.beginDraw();
  s3d.background(0, 0, 0, 0);
  GL2 gl = ((PJOGL)beginPGL()).gl.getGL2();
  gl.glEnable(GL2.GL_BLEND);
  gl.glBlendFunc(GL2.GL_SRC_ALPHA, GL2.GL_ONE_MINUS_SRC_ALPHA);

  gl.glHint( GL2.GL_POLYGON_SMOOTH_HINT, GL2.GL_NICEST );
  gl.glEnable(GL2.GL_ALPHA_TEST);
  gl.glAlphaFunc(GL2.GL_GREATER, 0.1f);
  endPGL();

  if (showMaskEye==true) {
    maskEyedrawing();
  }

  if (showMaskListen==true) {
    maskListendrawing();
  }

  if (showMaskSmell==true) {
    maskSmelldrawing();
  }

  if (showMaskTouch==true) {
    maskTouchdrawing();
  }
  s3d.endDraw();
}
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

public void shaderSetting() {

  texlightGLSL = loadShader("glsl/texlightfrag.glsl", "glsl/texlightvert.glsl");
  contrastGLSL = loadShader("glsl/contrast.glsl");

  shadowGLSL = loadShader("glsl/dropshadow.glsl");  
  shadowGLSL.set( "texResolution", PApplet.parseFloat( width ), PApplet.parseFloat(height ) );
  shadowGLSL.set( "bgResolution", PApplet.parseFloat( tex.width ), PApplet.parseFloat( tex .height ) );

  logo=loadImage("img/logo.png");
  bgs[0]=loadImage("img/bg_0.png");
  bgs[1]=loadImage("img/bg_1.png");
  bgs[2]=loadImage("img/bg_2.png");
  bgs[3]=loadImage("img/bg_3.png");
  bgs[4]=loadImage("img/bg_4.png");


  blendGLSL= loadShader("glsl/blendMode.glsl");
  blendGLSL.set( "lowLayer", bgs [imgIndex]);
  blendGLSL.set( "topLayer", logoMoveing ); 
  blendGLSL.set( "sketchSize", PApplet.parseFloat(width), PApplet.parseFloat(height) );
  blendGLSL.set( "topLayerResolution", PApplet.parseFloat( tex.width ), PApplet.parseFloat( tex.height ) );
  blendGLSL.set( "lowLayerResolution", PApplet.parseFloat( tex.width ), PApplet.parseFloat( tex.height ) );

  blendGLSL.set( "blendMode", BL_OVERLAY  );

  square.setTexture(tex);
  square.setStroke(false);
}


class Slash {
  float x1, x2, y1, y2, tarX1, tarX2, tarY1, tarY2, easing = random(0.05f, 0.1f);
  int timer, tMax, taille=20, delta=240;
  boolean vertical;
  int c;

  Slash(int _c) {
    c=_c;
    initSlash();
  }

  public void initSlash() {
    timer=0;
    tMax= (int) random(60, 150);
    vertical=random(1)>.5f;

    x1=x2=(int)random(1, PApplet.parseInt(logoMoveing.width/20)-1)*20;
    y1=y2=(int)random(1, PApplet.parseInt(logoMoveing.height/20)-1)*20;

    if (x1<logoMoveing.width/2) tarX2=x1+delta;
    else tarX2=x1-delta;

    if (y1<logoMoveing.height/2) tarY2=y1+delta;
    else tarY2=y1-delta;
  }

  public void draw(PGraphics  who) {

    x2=ease(x2, tarX2, easing);
    y2=ease(y2, tarY2, easing);
    if (abs(x2-tarX2)<=1) {
      timer++;

      if (timer>tMax) {
        tarX1=tarX2;
        tarY1=tarY2;
        x1=ease(x1, tarX1, easing);//
        y1=ease(y1, tarY1, easing);

        if (abs(x1-tarX1)<=1) {
          initSlash();
        }
      }
    }

     who.noStroke();
     who.fill(c, 200);
    if (vertical) {
      who.quad(x1, y1-taille, x1, y1+taille, x2, y2+taille, x2, y2-taille);
    } else { 
      who.quad(x1-taille, y1, x1+taille, y1, x2+taille, y2, x2-taille, y2);
    }
  }

  public float ease(float value, float target, float easingVal) {
    float d = target - value;
    if (abs(d)>1) value+= d*easingVal;
    return value;
  }
}
class pdMetro {

  int limit;
  boolean tgl;
  int time;//\u672c\u5730\u6642\u9593
  int duration;//\u672c\u5730\u6642\u9593
  boolean bang;

  int test;

  pdMetro(int limit) {
    tgl=false;
    bang=false;

    this.limit=limit;
    time=0;
    test=PApplet.parseInt(random(0, 15));
  }

  public void reset() {
    time=millis();
    bang=true;
    test=PApplet.parseInt(random(0, 15));
    //print("metro reset ");
  }

  public void update() {
    if (tgl==true) {
      duration=workTime-time;
      // println(duration);
      if ((duration)>=limit) {
        reset();
      }
    }
  }
}

//----------------------------------------------------------

class pdLine {
  boolean bang;
  boolean done;
  float duration;
  int time;
  int dd;
  int delay;
  float o;

  pdLine(int delay, float duration) {
    this.delay=delay;
    this.duration=duration;
    time=0;
    done=false;
  }

  public void reset() {
    time=millis();
    dd=time+delay;
    bang=true;
  }

  public void update() {

    if (bang==true) {
      if (workTime>dd) {
        if (workTime-dd<=duration+delay) {
          o=(PApplet.parseFloat(workTime-dd)/(duration+delay));
        } else {
          done=true;
          bang=false;
          o=1;
        }
      } else {
        o=0;
      }
    }
  }
}

class pdLine2 {
  boolean bang;
  float duration;
  int time;
  int dd;
  int delay;
  float o;
  float newOne;
  float oldOne;


  pdLine2(int delay, float duration) {
    this.delay=delay;
    this.duration=duration;
    time=0;
  }

  public void reset(float _newOne) {
    newOne=_newOne;
    time=millis();
    dd=time+delay;
    bang=true;
  }

  public void update() {
    if (bang==true) {
      if (workTime>dd) {
        if (workTime-dd<=duration+delay) {
          o=(PApplet.parseFloat(workTime-dd)/(duration+delay))*(newOne-oldOne)+oldOne;
        } else {
          bang=false;
          o=newOne;
          oldOne=newOne;
        }
      } else {
        o=oldOne;
      }
    }
  }
}

public float posAvg(float Width, float num, float index ) {
  return index*(Width/(num+1));
}
Slash[] slash;
int nb=40;

PGraphics logoMoveing;
PGraphics logoMirror;
PImage[] pattern=new PImage[3];
int roro=0;
int pp=0;

int[] colors = {color(253, 148, 38), color(252, 86, 44),
  color(56, 195, 206), color(124, 156, 124), color(18, 99, 104)};

public void logoSetting() {
  logoMoveing= createGraphics(1500, 1000, P2D);
  logoMirror= createGraphics(1000, 1000, P2D);

  pattern[0]=loadImage("img/pp_0.png");
  pattern[1]=loadImage("img/pp_1.png");
  pattern[2]=loadImage("img/pp_2.png");

  slash=new Slash[nb];
  for (int i=0; i<nb; i++) {
    int cc=PApplet.parseInt(random(10));
    if (cc==0)slash[i]=new Slash(colors[0]);
    else if (cc==1) slash[i]=new Slash(colors[1]);
    else slash[i]=new Slash(colors[ PApplet.parseInt(random(2, 4))]);
  }
}

public void logoDrawing() {

  logoMirror.beginDraw();
  logoMirror.background(125);
  logoMirror.imageMode(CENTER);
  logosMirrorDraw();
  logoMirror.endDraw();

  logoMoveing.beginDraw();
  logoMoveing.background(125);
  logoMoveing.imageMode(CENTER);
  //logoMoveing.blendMode(ADD);
  logos_1();
  // logos_3();
  // logos_2();
  logoMoveing.endDraw();
}

public void logosMirrorDraw() {
  for (int i=0; i<nb; i++) {
    slash[i].draw(logoMirror);
  }
}

public void logos_1() {
  logoMoveing.pushMatrix();
  logoMoveing.translate(0+166, logoMirror.height/2);
  logoMoveing.scale(1, 1);
  logoMoveing.image(logoMirror, 0, 0, logoMirror.width, logoMirror.height);
  logoMoveing.popMatrix();

  logoMoveing.pushMatrix();
  logoMoveing.translate(logoMirror.width+166, logoMirror.height/2);
  logoMoveing.scale(-1, 1);
  logoMoveing.image(logoMirror, 0, 0, logoMirror.width, logoMirror.height);
  logoMoveing.popMatrix();
}

public void logos_3() {

  if (frameCount%100==0) {
    roro=PApplet.parseInt(random(5))*90;
  }

  if (frameCount%50==0) {
   pp=PApplet.parseInt(random(3));
  }


  logoMoveing.pushMatrix();
  logoMoveing.translate(0+166, logoMirror.height/2);
  logoMoveing.scale(1, 1);
  logoMoveing.rotate(radians(roro));
  logoMoveing.image(pattern[pp], 0, 0, logoMirror.width, logoMirror.height);
  logoMoveing.popMatrix();

  logoMoveing.pushMatrix();
  logoMoveing.translate(logoMirror.width+166, logoMirror.height/2);
  logoMoveing.scale(-1, 1);
  logoMoveing.rotate(radians(roro));
  logoMoveing.image(pattern[pp], 0, 0, logoMirror.width, logoMirror.height);
  logoMoveing.popMatrix();
}




public void logos_2() {
  for (int i=0; i<15; i++) {
    for (int j=0; j<10; j++) {
      logoMoveing.pushMatrix();
      logoMoveing.scale(1.01f);
      if (j%2==0) {
        logoMoveing.translate(i*100, j*100+(20*abs(sin(frameCount*0.01f))));
        logoMoveing.scale(1, 1);
        logoMoveing.image(logo, 0, 0, 80, 80);
      } else {
        logoMoveing.translate((i*100)+50, j*100-(20*abs(sin(frameCount*0.01f))));
        logoMoveing.scale(1, -1);
        logoMoveing.image(logo, 0, 0, 80, 80);
      }
      logoMoveing. popMatrix();
    }
  }
}
boolean showMaskEye =false;
pdLine  MaskEyeLine;
boolean MaskEyeIn;

PShape maskA_1_1;
PShape maskA_1_2;
PShape maskA_2;
PShape maskA_3_1;
PShape maskA_3_2;
PShape maskA_4;

PShape RmaskA_1_1;
PShape RmaskA_1_2;
PShape RmaskA_2;
PShape RmaskA_3_1;
PShape RmaskA_3_2;
PShape RmaskA_4;

public void maskEyeSetting() {
  if (showMaskEye==false) {

    MaskEyeLine=new pdLine(0, 1000);
    MaskEyeIn=true;
    maskA_1_1 = loadShape("maskEye/maskA_1_1.obj");
    maskA_1_2 = loadShape("maskEye/maskA_1_2.obj");
    maskA_2 = loadShape("maskEye/maskA_2.obj");
    maskA_3_1 = loadShape("maskEye/maskA_3_1.obj");
    maskA_3_2 = loadShape("maskEye/maskA_3_2.obj");
    maskA_4 = loadShape("maskEye/maskA_4.obj");

    RmaskA_1_1 = loadShape("maskEye/maskA_1_1.obj");
    RmaskA_1_2 = loadShape("maskEye/maskA_1_2.obj");
    RmaskA_2 = loadShape("maskEye/maskA_2.obj");
    RmaskA_3_1 = loadShape("maskEye/maskA_3_1.obj");
    RmaskA_3_2 = loadShape("maskEye/maskA_3_2.obj");
    RmaskA_4 = loadShape("maskEye/maskA_4.obj");
    showMaskEye=true;
  } else if (showMaskEye==true) {
    MaskEyeIn=false;
  }
  MaskEyeLine.reset();
}


public void maskEyedrawing() {

  showMaskEye=returnState(MaskEyeLine, MaskEyeIn);
  s3d.pushMatrix();
  //----fade
  if (MaskEyeIn==true)s3d.translate(0, map(easeOutBack(MaskEyeLine.o), 0, 1, 500, 0));
  else  s3d.translate(0, map(easeInBack(MaskEyeLine.o), 0, 1, 0, -500));
  //----fadeEnd

  s3d.translate(width/2, height/2+25+map(sin(PApplet.parseFloat(frameCount%300)/300*6.28f), -1, 1, 0, -50), -50);
  s3d.rotateZ(PI);
  s3d.rotateY(radians(map(sin(PApplet.parseFloat(frameCount%600)/600*6.28f), -1, 1, -30, 30)));
  s3d.scale(0.85f);
  //---------------\u773c\u775b_ \u5de6
  s3d.pushMatrix();
  s3d.rotateZ(map(pow(sin(PApplet.parseFloat(frameCount%10)/10*6.28f), 8.0f), 0, 1, 0, PI*-0.01f));
  if (mousePressed==true) {
    randomVertex(maskA_1_1);
  } else {
    returnVertex(RmaskA_1_1, maskA_1_1);
  }

  s3d.shape(maskA_1_1);
  s3d.popMatrix();


  //---------------\u773c\u775b_\u53f3
  s3d.pushMatrix();
  s3d.rotateZ(map(pow(sin(PApplet.parseFloat(frameCount%10)/10*6.28f), 8.0f), 0, 1, 0, PI*0.01f));
  if (mousePressed==true) {
    randomVertex(maskA_1_2);
  } else {
    returnVertex(RmaskA_1_2, maskA_1_2);
  }
  s3d.shape(maskA_1_2);
  s3d.popMatrix();
  //---------------\u81c9
  s3d.pushMatrix();
  if (mousePressed==true) {
    randomVertex(maskA_2);
  } else {
    returnVertex(RmaskA_2, maskA_2);
  }
  s3d.shape(maskA_2);
  s3d.popMatrix();
  //---------------\u5de6
  s3d.pushMatrix();
  s3d.translate(map(pow(sin(a2/180*6.28f), 8.0f), 0, 1, 0, -40), 0);
  if (mousePressed==true) {
    randomVertex(maskA_3_1);
  } else {
    returnVertex(RmaskA_3_1, maskA_3_1);
  }
  s3d.shape(maskA_3_1);
  s3d.popMatrix();
  //---------------\u53f3
  s3d.pushMatrix();
  s3d.translate(map(pow(sin(a2/180*6.28f), 8.0f), 0, 1, 0, 40), 0);
  if (mousePressed==true) {
    randomVertex(maskA_3_2);
  } else {
    returnVertex(RmaskA_3_2, maskA_3_2);
  }
  s3d.shape(maskA_3_2);
  s3d.popMatrix();
  //---------------\u80cc\u677f
  s3d.pushMatrix();
  s3d.rotate((easeInBack(a1/360))*6.28f);
  if (mousePressed==true) {
    randomVertex(maskA_4);
  } else {
    returnVertex(RmaskA_4, maskA_4);
  }
  s3d.shape(maskA_4);
  s3d.popMatrix();
  //---------------
  s3d.popMatrix();
}

public void randomVertex(PShape who) {
  for (int j=0; j<who.getChildCount(); j++) {
    for (int i = 0; i < who.getChild(j).getVertexCount(); i++) {
      PVector v = who.getChild(j).getVertex(i);
      v.x += random(-6, 6);
      v.y += random(-6, 6);
      v.z += random(-6, 6);
      who.getChild(j).setVertex(i, v);
    }
  }
}

public void returnVertex(PShape origon, PShape who) {
  for (int j=0; j<origon.getChildCount(); j++) {
    for (int i = 0; i < origon.getChild(j).getVertexCount(); i++) {
      PVector v = origon.getChild(j).getVertex(i);
      PVector v1 = who.getChild(j).getVertex(i);

      v1.x =(v.x-v1.x)*0.05f +v1.x;
      v1.y =(v.y-v1.y)*0.05f +v1.y;
      v1.z =(v.z-v1.z)*0.05f +v1.z;
      who.getChild(j).setVertex(i, v1);
    }
  }
}
boolean showMaskListen =false;
pdLine  MaskListenLine;
boolean MaskListenIn;

PShape listen_1;
PShape listen_2;
PShape listen_3;


public void maskListenSetting() {
  if (showMaskListen==false) {
    MaskListenLine=new pdLine(0, 1000);
    MaskListenIn=true;
    listen_1 = loadShape("maskListen/listen_1.obj");
    listen_2=  loadShape("maskListen/listen_2.obj");
    listen_3 = loadShape("maskListen/listen_3.obj");
    showMaskListen =true;
  } else if (showMaskListen==true) {
    MaskListenIn=false;
  }
  MaskListenLine.reset();
}


public void maskListendrawing() {
  showMaskListen=returnState(MaskListenLine, MaskListenIn);
  s3d.pushMatrix();
  //----fade
  if (MaskListenIn==true)s3d.translate(0, map(easeOutBack(MaskListenLine.o), 0, 1, 500, 0));
  else  s3d.translate(0, map(easeInBack(MaskListenLine.o), 0, 1, 0, -500));
  //----fadeEnd

  s3d.translate(width/2, height/2+50+map(sin(PApplet.parseFloat(frameCount%300)/300*6.28f), -1, 1, 0, -50), -50);
  s3d.rotateZ(PI);
  s3d.rotateY(radians(map(sin(PApplet.parseFloat(frameCount%600)/600*6.28f), -1, 1, -30, 30)));
  //--------------\u6296\u52d5
  s3d.rotateZ(map(pow(sin(PApplet.parseFloat(frameCount%10)/10*6.28f), 8.0f), 0, 1, 0, PI*-0.01f));
  s3d.scale(0.55f);
  //---------------
  s3d.pushMatrix();

  s3d.shape(listen_1);
  s3d.popMatrix();
  //---------------
  s3d.pushMatrix();

  s3d.shape(listen_2);
  s3d.popMatrix();
  //---------------
  s3d.pushMatrix();

  s3d.shape(listen_3);
  s3d.popMatrix();
  //---------------
  s3d.popMatrix();
}
boolean showMaskSmell =false;
pdLine  MaskSmellLine;
boolean MaskSmellIn;

PShape Smell_1;
PShape Smell_2;
PShape Smell_3;


public void maskSmellSetting() {
  if (showMaskSmell==false) {
    MaskSmellLine=new pdLine(0, 1000);
    MaskSmellIn=true;
    Smell_1 = loadShape("maskSmell/smell_1.obj");
    Smell_2=  loadShape("maskSmell/smell_2.obj");
    Smell_3 = loadShape("maskSmell/smell_3.obj");
    showMaskSmell =true;
  } else if (showMaskSmell==true) {
    MaskSmellIn=false;
  }
  MaskSmellLine.reset();
}


public void maskSmelldrawing() {
  showMaskSmell=returnState(MaskSmellLine, MaskSmellIn);
  s3d.pushMatrix();
  //----fade
  if (MaskSmellIn==true)s3d.translate(0, map(easeOutBack(MaskSmellLine.o), 0, 1, 500, 0));
  else  s3d.translate(0, map(easeInBack(MaskSmellLine.o), 0, 1, 0, -500));
  //----fadeEnd

  s3d.translate(width/2, height/2+map(sin(PApplet.parseFloat(frameCount%300)/300*6.28f), -1, 1, 0, -50), -50);
  s3d.rotateZ(PI);
  s3d.rotateY(radians(map(sin(PApplet.parseFloat(frameCount%600)/600*6.28f), -1, 1, -30, 30)));
  //--------------\u6296\u52d5
  s3d.rotateZ(map(pow(sin(PApplet.parseFloat(frameCount%10)/10*6.28f), 8.0f), 0, 1, 0, PI*-0.01f));
  s3d.scale(0.8f);
  //---------------
  s3d.pushMatrix();

  s3d.shape(Smell_1);
  s3d.popMatrix();
  //---------------
  s3d.pushMatrix();

  s3d.shape(Smell_2);
  s3d.popMatrix();
  //---------------
  s3d.pushMatrix();

  s3d.shape(Smell_3);
  s3d.popMatrix();
  //---------------
  s3d.popMatrix();
}
boolean showMaskTouch =false;
pdLine  MaskTouchLine;
boolean MaskTouchIn;

PShape Touch_1;
PShape Touch_2;
PShape Touch_3;
PShape Touch_4;


public void maskTouchSetting() {
  if (showMaskTouch==false) {
    MaskTouchLine=new pdLine(0, 1000);
    MaskTouchIn=true;
    Touch_1 = loadShape("maskTouch/touch_1.obj");
    Touch_2=  loadShape("maskTouch/touch_2.obj");
    Touch_3 = loadShape("maskTouch/touch_3.obj");
    Touch_4 = loadShape("maskTouch/touch_4.obj");
    showMaskTouch =true;
  } else if (showMaskTouch==true) {
    MaskTouchIn=false;
  }
  MaskTouchLine.reset();
}


public void maskTouchdrawing() {
  showMaskTouch=returnState(MaskTouchLine, MaskTouchIn);
  s3d.pushMatrix();
  //----fade
  if (MaskTouchIn==true)s3d.translate(0, map(easeOutBack(MaskTouchLine.o), 0, 1, 500, 0));
  else  s3d.translate(0, map(easeInBack(MaskTouchLine.o), 0, 1, 0, -500));
  //----fadeEnd

  s3d.translate(width/2, height/2+100+map(sin(PApplet.parseFloat(frameCount%300)/300*6.28f), -1, 1, 0, -50), -50);
  s3d.rotateZ(PI);
  s3d.rotateY(radians(map(sin(PApplet.parseFloat(frameCount%600)/600*6.28f), -1, 1, -30, 30)));
  //--------------\u6296\u52d5
  s3d.rotateZ(map(pow(sin(PApplet.parseFloat(frameCount%10)/10*6.28f), 8.0f), 0, 1, 0, PI*-0.01f));
  s3d.scale(0.8f);
  //---------------
  s3d.pushMatrix();
  s3d.shape(Touch_1);
  s3d.popMatrix();
  //---------------
  s3d.pushMatrix();
  s3d.shape(Touch_2);
  s3d.popMatrix();
  //---------------
  s3d.pushMatrix();
  s3d.shape(Touch_3);
  s3d.popMatrix();
   //---------------
  s3d.pushMatrix();
  s3d.shape(Touch_4);
  s3d.popMatrix();
  //---------------
  s3d.popMatrix();
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Boyajian_v2" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
