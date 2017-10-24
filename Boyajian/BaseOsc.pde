float chlow;
float chmiddle;
float chhigh;

float low;
float middle;
float high;

float vol;
float ctl51=1.0;

float ctl61=0;
float ctl62=0;
float ctl63=0;

float anim_sp;
float anim_dir=1.0;
float anim_scale;

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
      if (layer[6]>135) {
        rotateGridTriggerIndex =int(random(2))+6;
        animationRotateGridTrigger() ;
      }

      if (layer[6]<115) {
        growGridTriggerIndex=int(random(2))+6;
        animationGrowGridTrigger() ;
      }

      //-----------------------------------------layer3
      if (layer[3]>200) {
        stripTriggerIndex=3;
        animationStripTrigger() ;
      }
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

      if (volTemp<1) vol=volTemp;
      else vol=0.99;


      //------------------
      if (ctl62>0) {
        animations.rotateGrid.adjustSpeed(map(ctl62, 0, 255, 0.1, 8)*anim_dir);
      } else {
        anim_sp = map(vol, 0, 1, 0.1, 8);
        animations.rotateGrid.adjustSpeed(anim_sp*anim_dir);
        //println("speed: "+anim_sp*anim_dir);
      }
      //------------------
      if (ctl61>0) {
        //animations.growGrid.adjustLengthScale(map(ctl61, 0, 255, 0.2, 0.8));
      } else {
        anim_scale = map(vol, 0, 1, 0.2, 0.8     );
        //animations.growGrid.adjustLengthScale(anim_scale);
        //println("scale: " + anim_scale);
      }
      //------------------
    }

    //println("vol:"+vol+"   low:"+low+",   middle:"+middle+",   high:"+high );

    chColumnThreshold=int(map(low, 0.4, 1, 0, 10));
    chColumnSpeed =int(map(high, 0.4, 1, 40, 2));
    ColumnNum =int(map(middle, 0.4, 1, 2, 580));
  }
}