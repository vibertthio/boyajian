class Slashes {
  Slash[] slash;
  int numberOfSlashes = 40;

  Slashes() {
    init();
  }

  Slashes(int _n) {
    numberOfSlashes = _n;
    init();
  }

  void init() {
    slash = new Slash[numberOfSlashes];
    for (int i = 0; i < numberOfSlashes; i++) {
      int cc = int(random(10));
      if (cc == 0) {
        slash[i] = new Slash(colors[0]);
      } else if (cc == 1) {
        slash[i] = new Slash(colors[1]);
      } else {
        slash[i] = new Slash(colors[int(random(2, 4))]);
      }
    }
  }

  void draw() {
    for (int i=0; i<numberOfSlashes; i++) {
      slash[i].draw(logoMirror);
    }
  }
}

class Slash {
  float x1;
  float x2;
  float y1;
  float y2;
  float tarX1;
  float tarX2;
  float tarY1;
  float tarY2;
  float easing = random(0.05, 0.1);
  int timer;
  int tMax;
  int taille = 20;
  int delta = 240;
  boolean vertical;
  color c;

  Slash(color _c) {
    c = _c;
    initSlash();
  }

  void initSlash() {
    timer = 0;
    tMax = int(random(60, 150));
    vertical = (random(1) > 0.5);

    x1 = x2 = int(random(1, int(logoMoving.width / 20) - 1) * 20);
    y1 = y2 = int(random(1, int(logoMoving.height / 20) - 1) * 20);

    if (x1 < logoMoving.width / 2) {
      tarX2 = x1 + delta;
    } else {
      tarX2 = x1 - delta;
    }

    if (y1 < logoMoving.height / 2) tarY2=y1+delta;
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
        x1=ease(x1, tarX1, easing);
        y1=ease(y1, tarY1, easing);

        if (abs(x1-tarX1)<=1) {
          initSlash();
        }
      }
    }

     who.noStroke();
     who.fill(c, layer[2]);
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
