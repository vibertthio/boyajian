RShape textEye;
boolean showMaskEye =false;
boolean MaskEyeIn;

pdLine  MaskEyeLine;
pdLine  MaskEyeLineIn;
pdLine  MaskEyeLineOut;

PShape maskA_1_1;
PShape maskA_1_2;
PShape maskA_2;
PShape maskA_3_1;
PShape maskA_3_2;
PShape maskA_4;
PShape maskA_5;

PShape RmaskA_1_1;
PShape RmaskA_1_2;
PShape RmaskA_2;
PShape RmaskA_3_1;
PShape RmaskA_3_2;
PShape RmaskA_4;
PShape RmaskA_5;

PImage EyeImg;


float Eye_x, Eye_y;


void maskEyeSetting() {

  textEye= RG.getText("三眼面具", "wt.ttf", 72, RFont.CENTER);


  if (showMaskEye==false) {
    show[1]=1;
    countLife();
    EyeImg=loadImage("maskEye/tex_eye.png");
    MaskEyeIn=true;


    showMaskEye=true;
  } else if (showMaskEye==true) {
    show[1]=0;
    countLife();
    MaskEyeIn=false;
  }
  MaskEyeLineIn=new pdLine(500, 1000);
  MaskEyeLineOut=new pdLine(3500, 1000);
  MaskEyeLine=new pdLine(0, 1000);
  MaskEyeLine.reset();
  MaskEyeLineIn.reset();
  MaskEyeLineIn.done=false;
  MaskEyeLineOut.reset();
}


void maskEyedrawing() {

  showMaskEye=returnState(MaskEyeLine, MaskEyeIn);

  //----fade
  Eye_x=width/2+countX[1].o;

  if (MaskEyeIn==true)Eye_y=height/2+5+map(easeOutBack(MaskEyeLine.o), 0, 1, 500, 0);
  else  Eye_y=height/2+5+map(easeInBack(MaskEyeLine.o), 0, 1, 0, -500);
  //----fadeEnd

  s3d.strokeWeight(1);
  s3d.noStroke();


  s3d.pushMatrix();
  {
    s3d.translate(Eye_x, Eye_y+anim(300, 0, -50, 2), -50);//升降

    s3d.pushMatrix();//文字開始

    // s3d.translate(40, 0, 0);
    // s3d.fill(maskNmae, 155);
    // MaskEyeLineIn.update();
    // MaskEyeLineOut.update();
    // if (MaskEyeLineIn.bang==true ) {
    //   textEye.children[0].transform(70, easeInBack(MaskEyeLineIn.oo)*300, 30, 30) ;
    //   textEye.children[1].transform(102, -easeInBack(MaskEyeLineIn.oo)*300, 30, 30) ;
    //   textEye.children[2].transform(137, easeInBack(MaskEyeLineIn.oo)*300, 30, 30) ;
    //   textEye.children[3].transform(172, -easeInBack(MaskEyeLineIn.oo)*300, 30, 30) ;
    // } else if (MaskEyeLineIn.done==true  ) {
    //   textEye.children[0].transform(70, easeInBack(MaskEyeLineOut.o)*300, 30, 30) ;
    //   textEye.children[1].transform(102, -easeInBack(MaskEyeLineOut.o)*300, 30, 30) ;
    //   textEye.children[2].transform(137, easeInBack(MaskEyeLineOut.o)*300, 30, 30) ;
    //   textEye.children[3].transform(172, -easeInBack(MaskEyeLineOut.o)*300, 30, 30) ;
    //   defultCam();
    // }
    //
    // if (MaskEyeLineOut.bang==false) MaskEyeLineIn.done=false;
    // if (MaskEyeLineOut.o<0.99 && MaskEyeLineIn.o>0.01 && MaskEyeIn==true)textEye.draw(s3d);

    s3d.popMatrix();//文字結束

    s3d.rotateZ(PI);
    //--------------抖動
    s3d.rotateY(radians(anim(600, -30, 30, 2)));
    s3d.scale(0.63);

    //---------------眼睛_ 左
    s3d.pushMatrix();
    s3d.rotateZ(anim(10, 0, PI*-0.01, 8));

    if (vertexNoise==true) randomVertex(maskA_1_1);
    else returnVertex(RmaskA_1_1, maskA_1_1);

    if (vol>0.8) s3d.scale(random(1, 1.2),random(1, 1.2),1);
    else s3d.scale(1);

    s3d.shape(maskA_1_1);
    s3d.popMatrix();


    //---------------眼睛_右
    s3d.pushMatrix();
    s3d.rotateZ(anim(10, 0, PI*0.01, 8));

    if (vertexNoise==true) randomVertex(maskA_1_2);
    else returnVertex(RmaskA_1_2, maskA_1_2);

    if (vol>0.8) s3d.scale(random(1, 1.2),random(1, 1.2),1);
    else s3d.scale(1);

    s3d.shape(maskA_1_2);
    s3d.popMatrix();
    //---------------臉
    s3d.pushMatrix();

    if (vertexNoise==true) randomVertex(maskA_2);
    else returnVertex(RmaskA_2, maskA_2);

    s3d.shape(maskA_2);
    s3d.popMatrix();
    //---------------左
    s3d.pushMatrix();
    s3d.translate(map(sin((step/360*2)*6.28), -1, 1, 0, -40), 0);


    if (vertexNoise==true) randomVertex(maskA_3_1);
    else returnVertex(RmaskA_3_1, maskA_3_1);

    s3d.shape(maskA_3_1);
    s3d.popMatrix();
    //---------------右
    s3d.pushMatrix();
    s3d.translate(map(sin((step/360*2)*6.28), -1, 1, 0, 40), 0);

    if (vertexNoise==true) randomVertex(maskA_3_2);
    else returnVertex(RmaskA_3_2, maskA_3_2);

    s3d.shape(maskA_3_2);
    s3d.popMatrix();
    //---------------背板



    s3d.pushMatrix();
    s3d.rotate(radians(step));

    if (vertexNoise==true) randomVertex(maskA_4);
    else returnVertex(RmaskA_4, maskA_4);

    s3d.shape(maskA_4);
    s3d.popMatrix();
    //---------------眼睛
    s3d.pushMatrix();

    if (vertexNoise==true) randomVertex(maskA_5);
    else returnVertex(RmaskA_5, maskA_5);
    if (wireFrameCtl==false) {
      maskA_5.disableStyle();
      s3d.tint( color(255, anim(200, 100, 255, 2), anim(200, 100, 255, 4)));
      s3d.shape(maskA_5);
      maskA_5.enableStyle();
    } else {
      s3d.tint( color(255, anim(200, 100, 255, 2), anim(200, 100, 255, 4)));
      s3d.shape(maskA_5);
    }
    s3d.popMatrix();
    //---------------
  }
  s3d.popMatrix();
  if (wireFrameCtl==true) {
    noWireFrame( maskA_1_1, random(1.80, 2.40), color(255, 120));
    noWireFrame( maskA_1_2, random(1.80, 2.40), color(255, 120));
    noWireFrame( maskA_2, random(1.80, 2.40), color(255, 120));
    noWireFrame( maskA_3_1, random(1.80, 2.40), color(255, 120));
    noWireFrame( maskA_3_2, random(1.80, 2.40), color(255, 120));
    noWireFrame( maskA_4, random(1.80, 2.40), color(255, 120));
    noWireFrame( maskA_5, random(1.80, 2.40), color(255, 120));
  } else {
    setTexture( maskA_1_1, EyeImg);
    setTexture( maskA_1_2, EyeImg);
    setTexture(maskA_2, EyeImg);
    setTexture( maskA_3_1, EyeImg);
    setTexture( maskA_3_2, EyeImg);
    setTexture( maskA_4, EyeImg);
    setTexture( maskA_5, EyeImg);
  }

  if (vertexNoise==true) {
    addWireFrame(maskA_1_1);
    addWireFrame(maskA_1_2);
    addWireFrame(maskA_2);
    addWireFrame(maskA_3_1);
    addWireFrame(maskA_3_2);
    addWireFrame(maskA_4);
    addWireFrame(maskA_5);
  }
}

void Eye(boolean theFlag) {
  if (theFlag==true) {
    showMaskEye=false;
    thread("maskEyeSetting");
    //randomCam();
  } else {
    showMaskEye=true;
    thread("maskEyeSetting");
  }
}
