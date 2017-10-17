float chlow;
float chmiddle;
float chhigh;

float low;
float middle;
float high;




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
      //println("beat");
    }


    //println("low:"+low+",   middle:"+middle+",   high:"+high );

    chColumnThreshold=int(map(low, 0.4, 1, 0, 10));
    chColumnSpeed =int(map(high, 0.4, 1, 40, 2));
    ColumnNum =int(map(middle, 0.4, 1, 2, 580));
  }
}
