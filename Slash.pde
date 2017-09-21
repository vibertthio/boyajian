

class Slash {
  float x1, x2, y1, y2, tarX1, tarX2, tarY1, tarY2, easing = random(0.05, 0.1);
  int timer, tMax, taille=20, delta=240;
  boolean vertical;
  color c;

  Slash(color _c) {
    c=_c;
    initSlash();
  }

  void initSlash() {
    timer=0;
    tMax= (int) random(60, 150);
    vertical=random(1)>.5;

    x1=x2=(int)random(1, int(logoMoveing.width/20)-1)*20;
    y1=y2=(int)random(1, int(logoMoveing.height/20)-1)*20;

    if (x1<logoMoveing.width/2) tarX2=x1+delta;
    else tarX2=x1-delta;

    if (y1<logoMoveing.height/2) tarY2=y1+delta;
    else tarY2=y1-delta;
  }

  void draw(PGraphics  who) {

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

  float ease(float value, float target, float easingVal) {
    float d = target - value;
    if (abs(d)>1) value+= d*easingVal;
    return value;
  }
}