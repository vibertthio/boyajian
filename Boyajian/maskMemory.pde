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

PImage MemoryImg;

float Memory_x, Memory_y;

void maskMemorySetting() {

  textMemory= RG.getText("海馬迴蠍使", "wt.ttf", 72, RFont.CENTER);


  if (showMaskMemory==false) {
    show[4]=1;
    countLife();
    MemoryImg=loadImage("maskMemory/tex_memory_02.png");
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

  MaskMemoryLineIn=new pdLine(500, 1000);
  MaskMemoryLineOut=new pdLine(3500, 1000);
  MaskMemoryLine=new pdLine(0, 1000);
  MaskMemoryLine.reset();
  MaskMemoryLineIn.reset();
  MaskMemoryLineIn.done=false;
  MaskMemoryLineOut.reset();
}


void maskMemorydrawing() {

  showMaskMemory=returnState(MaskMemoryLine, MaskMemoryIn);
  s3d.pushMatrix();
  {
    Memory_x=width/2+countX[4].o;

    if (MaskMemoryIn==true) Memory_y=height/2+60+map(easeOutBack(MaskMemoryLine.o), 0, 1, 500, 0);
    else   Memory_y=height/2+60+map(easeInBack(MaskMemoryLine.o), 0, 1, 0, -500);

    s3d.translate(Memory_x, Memory_y+anim(300, 0, -50, 2), -50);

    // s3d.pushMatrix();
    // s3d.translate(40, 0, 0);
    // s3d.fill(maskNmae, 155);
    // MaskMemoryLineIn.update();
    // MaskMemoryLineOut.update();
    // if (MaskMemoryLineIn.bang==true ) {
    //   textMemory.children[0].transform(36, easeInBack(MaskMemoryLineIn.oo)*300, 30, 30) ;
    //   textMemory.children[1].transform(71, -easeInBack(MaskMemoryLineIn.oo)*300, 30, 30) ;
    //   textMemory.children[2].transform(105, easeInBack(MaskMemoryLineIn.oo)*300, 30, 30) ;
    //   textMemory.children[3].transform(138, -easeInBack(MaskMemoryLineIn.oo)*300, 30, 30) ;
    //   textMemory.children[4].transform(171, easeInBack(MaskMemoryLineOut.o)*300, 30, 30) ;
    // } else if (MaskMemoryLineIn.done==true  ) {
    //   textMemory.children[0].transform(36, easeInBack(MaskMemoryLineOut.o)*300, 30, 30) ;
    //   textMemory.children[1].transform(71, -easeInBack(MaskMemoryLineOut.o)*300, 30, 30) ;
    //   textMemory.children[2].transform(105, easeInBack(MaskMemoryLineOut.o)*300, 30, 30) ;
    //   textMemory.children[3].transform(138, -easeInBack(MaskMemoryLineOut.o)*300, 30, 30) ;
    //   textMemory.children[4].transform(171, easeInBack(MaskMemoryLineOut.o)*300, 30, 30) ;
    //   defultCam();
    // }
    //
    // if (MaskMemoryLineOut.bang==false) MaskMemoryLineIn.done=false;
    // if (MaskMemoryLineOut.o<0.99 && MaskMemoryLineIn.o>0.001 && MaskMemoryIn==true)textMemory.draw(s3d);
    // s3d.popMatrix();

    s3d.rotateZ(PI);
    s3d.rotateY(radians(map(sin(float(frameCount%600)/600*6.28), -1, 1, -30, 30)));
    //--------------抖動
    s3d.rotateZ(map(pow(sin(float(frameCount%10)/10*6.28), 8.0), 0, 1, 0, PI*-0.01));
    s3d.scale(0.61);
    //---------------
    s3d.pushMatrix();
    if (vol>0.8) s3d.scale(random(1, 1.2),random(1, 1.3),1);
    else s3d.scale(1);

    s3d.shape(Memory_1);
    s3d.popMatrix();
    //---------------
    s3d.pushMatrix();
    s3d.shape(Memory_2);
    s3d.popMatrix();
    //---------------
    s3d.pushMatrix();
    s3d.rotateX(radians(anim(10, 2, 0, 2)));
    s3d.shape(Memory_3);
    s3d.popMatrix();
    //---------------
    float flyAngle=2*abs(((step%90)/90)-0.5);
    float flyAngleMap=map(flyAngle,0,1,10,-20);
    s3d.pushMatrix();
    s3d.rotateZ(radians(flyAngleMap));
    s3d.shape(Memory_4);
    s3d.popMatrix();
    //---------------
    s3d.pushMatrix();
    s3d.rotateZ(radians(flyAngleMap*-1));
    s3d.shape(Memory_5);
    s3d.popMatrix();
    //---------------
  }
  s3d.popMatrix();
  if (wireFrameCtl==true) {
    noWireFrame(Memory_1, random(1.80, 2.40), color(0, 165, 250, 120));
    noWireFrame(Memory_2, random(1.80, 2.40), color(0, 165, 250, 120));
    noWireFrame(Memory_3, random(1.80, 2.40), color(0, 165, 250, 120));
    noWireFrame(Memory_4, random(1.80, 2.40), color(0, 165, 250, 120));
    noWireFrame(Memory_5, random(1.80, 2.40), color(0, 165, 250, 120));
  } else {
    setTexture(Memory_1, MemoryImg);
    setTexture(Memory_2, MemoryImg);
    setTexture(Memory_3, MemoryImg);
    setTexture(Memory_4, MemoryImg);
    setTexture(Memory_5, MemoryImg);
  }
}

void Memory(boolean theFlag) {
  if (theFlag==true) {
    showMaskMemory=false;
    thread("maskMemorySetting");
    //randomCam();
  } else {
    showMaskMemory=true;
    thread("maskMemorySetting");
  }
}
