class pdMetro {

  int limit;
  boolean tgl;
  int time;//本地時間
  int duration;//本地時間
  boolean bang;

  int test;

  pdMetro(int limit) {
    tgl=false;
    bang=false;

    this.limit=limit;
    time=0;
    test=int(random(0, 15));
  }

  void reset() {
    time=millis();
    bang=true;
    test=int(random(0, 15));
    //print("metro reset ");
  }

  void update() {
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
  float oo;

  pdLine(int _delay, float _duration) {
    this.delay=_delay;
    this.duration=_duration;
    time=0;
    done=false;
  }

  void reset() {
    time=millis();
    dd=time+delay;
    bang=true;
  }

  void update() {

    if (bang==true) {
      if (workTime>dd) {
        if (workTime-dd<=duration) {
          o=(float(workTime-dd)/(duration));
        } else {
          done=true;
          bang=false;
          o=1;
        }
      } else {
        o=0;
      }
      oo=1.0-o;
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

  void reset(float _newOne) {
    newOne=_newOne;
    time=millis();
    dd=time+delay;
    bang=true;
  }

  void update() {
    if (bang==true) {
      if (workTime>dd) {
        if (workTime-dd<=duration) {
          o=(float(workTime-dd)/(duration))*(newOne-oldOne)+oldOne;
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

float posAvg(float Width, float num, float index ) {
  return index*(Width/(num+1));
}