float chlow;
float chmiddle;
float chhigh;

float low;
float middle;
float high;

float vol;
float ctl51=1.0;

void oscEvent(OscMessage m) {

  if (oscCtl==true) {
    if (m.checkAddrPattern("/chfft")==true) {
      if (m.checkTypetag("fff")) {
        chlow=m.get(0).floatValue();
        chmiddle=m.get(1).floatValue();
        chhigh=m.get(2).floatValue();
        // println("chlow:" + chlow+",   chmiddle:"+chmiddle+",   chhigh:"+chhigh );
      }
    }

    if (m.checkAddrPattern("/low")==true) if (m.checkTypetag("f"))low=m.get(0).floatValue();
    if (m.checkAddrPattern("/middle")==true) if (m.checkTypetag("f"))middle=m.get(0).floatValue();
    if (m.checkAddrPattern("/high")==true) if (m.checkTypetag("f"))high=m.get(0).floatValue();

    if (m.checkAddrPattern("/beat")==true)if (m.checkTypetag("i")) {

      //-----------------------------------------layer6
      if (layer[6]>150) {
        // rotateGridTriggerIndex =int(random(2))+6;
        // animationRotateGridTrigger() ;
      }

      if (layer[6]<100) {
        // growGridTriggerIndex=int(random(2))+5;
        // animationGrowGridTrigger() ;
      }
      //-----------------------------------------layer6


      //-----------------------------------------camera
      if (layer[8]>250) {
        int k=int(random(3));
        if (k==0)defultCam() ;
        else if (k==1)closeCam();
        else if (k==2)superCloseCam();
      }

      //-----------------------------------------camera
    }


    if (m.checkAddrPattern("/vol")==true)if (m.checkTypetag("f")) {
      float volTemp=0;

      volTemp=m.get(0).floatValue()*ctl51;

      if(volTemp<1) vol=volTemp;
      else vol=0.99;

      float sp = map(volTemp, 0, 1, 1, 10);
      // animations.rotateGrid.adjustSpeed(sp);
      // println("speed: " + sp);

    }

    //println("vol:"+vol+"   low:"+low+",   middle:"+middle+",   high:"+high );

    chColumnThreshold=int(map(low, 0.4, 1, 0, 10));
    chColumnSpeed =int(map(high, 0.4, 1, 40, 2));
    ColumnNum =int(map(middle, 0.4, 1, 2, 580));
  }
}
