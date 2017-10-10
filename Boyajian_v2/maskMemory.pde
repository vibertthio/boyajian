RShape textMemory;
boolean showMaskMemory =false;
boolean MaskMemoryIn;

pdLine  MaskMemoryLine;
pdLine  MaskMemoryLineIn;
pdLine  MaskMemoryLineOut;

PShape Memory_1;
PShape Memory_2;
PShape Memory_3;
PShape Memory_4;
PShape Memory_5;

float Memory_x, Memory_y;

void maskMemorySetting() {

  textMemory= RG.getText("海馬迴蠍使", "wt.ttf", 72, RFont.CENTER);
  MaskMemoryLineIn=new pdLine(500, 1000);
  MaskMemoryLineOut=new pdLine(3500, 1000);

  if (showMaskMemory==false) {
    show[4]=1;
    countLife();
    MaskMemoryLine=new pdLine(0, 1000);
    MaskMemoryIn=true;
    Memory_1 = loadShape("maskMemory/memory_1.obj");
    Memory_2=  loadShape("maskMemory/memory_2.obj");
    Memory_3 = loadShape("maskMemory/memory_3.obj");
    Memory_4 = loadShape("maskMemory/memory_4.obj");
    Memory_5 = loadShape("maskMemory/memory_5.obj");
    showMaskMemory =true;
  } else if (showMaskMemory==true) {
    MaskMemoryIn=false;
    show[4]=0;
    countLife();
  }
  MaskMemoryLine.reset();
  MaskMemoryLineIn.reset();
  MaskMemoryLineIn.done=false;
  MaskMemoryLineOut.reset();
}


void maskMemorydrawing() {
  MaskMemoryLineIn.update();
  MaskMemoryLineOut.update();
  showMaskMemory=returnState(MaskMemoryLine, MaskMemoryIn);
  s3d.pushMatrix();
  {
    Memory_x=width/2+countX[4].o;
    Memory_y=height/2+100;
  //----fade
  if (MaskMemoryIn==true)s3d.translate(0, map(easeOutBack(MaskMemoryLine.o), 0, 1, 500, 0));
  else  s3d.translate(0, map(easeInBack(MaskMemoryLine.o), 0, 1, 0, -500));
  //----fadeEnd

  {//文字開始
    s3d.pushMatrix();
    s3d.translate(width/2, height/2-17, -50);
    s3d.scale(3.0);
    s3d.fill(maskNmae, 155);

    {//文字動畫
      if (MaskMemoryLineIn.bang==true ) {
        textMemory.children[0].transform(36, easeInBack(MaskMemoryLineIn.oo)*300, 20, 20) ;
        textMemory.children[1].transform(71, -easeInBack(MaskMemoryLineIn.oo)*300, 20, 20) ;
        textMemory.children[2].transform(105, easeInBack(MaskMemoryLineIn.oo)*300, 20, 20) ;
        textMemory.children[3].transform(138, -easeInBack(MaskMemoryLineIn.oo)*300, 20, 20) ;
        textMemory.children[4].transform(171, -easeInBack(MaskMemoryLineOut.o)*300, 20, 20) ;
      } else if (MaskMemoryLineIn.done==true  ) {
        textMemory.children[0].transform(36, easeInBack(MaskMemoryLineOut.o)*300, 20, 20) ;
        textMemory.children[1].transform(71, -easeInBack(MaskMemoryLineOut.o)*300, 20, 20) ;
        textMemory.children[2].transform(105, easeInBack(MaskMemoryLineOut.o)*300, 20, 20) ;
        textMemory.children[3].transform(138, -easeInBack(MaskMemoryLineOut.o)*300, 20, 20) ;
        textMemory.children[4].transform(171, -easeInBack(MaskMemoryLineOut.o)*300, 20, 20) ;
        defultCam();
      }

      if (MaskMemoryLineOut.bang==false) {
        MaskMemoryLineIn.done=false;
      }
    }//文字動畫結束

    s3d.strokeWeight(1);
    s3d.noStroke();
    if (MaskMemoryLineOut.o>0.001 || MaskMemoryLineIn.o>0.001 )
      if ( MaskMemoryIn==true )textMemory.draw(s3d);
    s3d.popMatrix();
  }//文字結束
  //-----model

  s3d.translate(Memory_x, Memory_y+map(sin(float(frameCount%300)/300*6.28), -1, 1, 0, -50), -50);
  s3d.rotateZ(PI);
  s3d.rotateY(radians(map(sin(float(frameCount%600)/600*6.28), -1, 1, -30, 30)));
  //--------------抖動
  s3d.rotateZ(map(pow(sin(float(frameCount%10)/10*6.28), 8.0), 0, 1, 0, PI*-0.01));
  s3d.scale(0.61);
  //---------------
  s3d.pushMatrix();
  s3d.shape(Memory_1);
  s3d.popMatrix();
  //---------------
  s3d.pushMatrix();
  s3d.shape(Memory_2);
  s3d.popMatrix();
  //---------------
  s3d.pushMatrix();
  s3d.rotateX(radians(anim(10,2,0,2)));
  s3d.shape(Memory_3);
  s3d.popMatrix();
   //---------------
  s3d.pushMatrix();
  s3d.rotateZ(radians(anim(180,10,-40,2)));
  s3d.shape(Memory_4);
  s3d.popMatrix();
  //---------------
  s3d.pushMatrix();
  s3d.rotateZ(radians(anim(180,10,-40,2)*-1));
  s3d.shape(Memory_5);
  s3d.popMatrix();
  //---------------
  }
  s3d.popMatrix();
}

void Memory(boolean theFlag) {
  if (theFlag==true) {
    showMaskMemory=false;
    thread("maskMemorySetting");
    randomCam();
  } else {
    showMaskMemory=true;
    thread("maskMemorySetting");
  }
}