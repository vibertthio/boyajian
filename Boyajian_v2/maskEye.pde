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

PShape RmaskA_1_1;
PShape RmaskA_1_2;
PShape RmaskA_2;
PShape RmaskA_3_1;
PShape RmaskA_3_2;
PShape RmaskA_4;

float Eye_x,Eye_y;

void maskEyeSetting() {

  textEye= RG.getText("三眼面具", "wt.ttf", 72, RFont.CENTER);
  MaskEyeLineIn=new pdLine(500, 1000);
  MaskEyeLineOut=new pdLine(3500, 1000);

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
  MaskEyeLineIn.reset();
  MaskEyeLineIn.done=false;
  MaskEyeLineOut.reset();
}


void maskEyedrawing() {
  MaskEyeLineIn.update();
  MaskEyeLineOut.update();
  showMaskEye=returnState(MaskEyeLine, MaskEyeIn);
  s3d.pushMatrix();
  {
    Eye_x=width/2;
    Eye_y=height/2;
    //----fade
    if (MaskEyeIn==true)s3d.translate(0, map(easeOutBack(MaskEyeLine.o), 0, 1, 500, 0));
    else  s3d.translate(0, map(easeInBack(MaskEyeLine.o), 0, 1, 0, -500));
    //----fadeEnd
    {//文字開始
      s3d.pushMatrix();
      s3d.translate(width/2, height/2-17, -50);
      s3d.scale(3.0);
      s3d.fill(color(0.72*255, 0.53*255, 0.0*255), 155);

      {//文字動畫
        if (MaskEyeLineIn.bang==true ) {
          textEye.children[0].transform(70, easeInBack(MaskEyeLineIn.oo)*300, 20, 20) ;
          textEye.children[1].transform(102, -easeInBack(MaskEyeLineIn.oo)*300, 20, 20) ;
          textEye.children[2].transform(137, easeInBack(MaskEyeLineIn.oo)*300, 20, 20) ;
          textEye.children[3].transform(172, -easeInBack(MaskEyeLineIn.oo)*300, 20, 20) ;
        } else if (MaskEyeLineIn.done==true  ) {
          textEye.children[0].transform(70, easeInBack(MaskEyeLineOut.o)*300, 20, 20) ;
          textEye.children[1].transform(102, -easeInBack(MaskEyeLineOut.o)*300, 20, 20) ;
          textEye.children[2].transform(137, easeInBack(MaskEyeLineOut.o)*300, 20, 20) ;
          textEye.children[3].transform(172, -easeInBack(MaskEyeLineOut.o)*300, 20, 20) ;
          defultCam();
        }

        if (MaskEyeLineOut.bang==false) {
          MaskEyeLineIn.done=false;
        }
      }//文字動畫結束

      s3d.strokeWeight(1);
      s3d.noStroke();
      if (MaskEyeLineOut.o>0.001 || MaskEyeLineIn.o>0.001 )
        if ( MaskEyeIn==true )textEye.draw(s3d);
      s3d.popMatrix();
    }//文字結束
    //-----model
    
    s3d.translate(Eye_x, height/2+map(sin(float(frameCount%300)/300*6.28), -1, 1, 0, -50), -50);
    s3d.rotateZ(PI);
    s3d.rotateY(radians(map(sin(float(frameCount%600)/600*6.28), -1, 1, -30, 30)));
    s3d.scale(0.85);

    //---------------眼睛_ 左
    s3d.pushMatrix();
    s3d.rotateZ(map(pow(sin(float(frameCount%10)/10*6.28), 8.0), 0, 1, 0, PI*-0.01));
    if (keyPressed==true &&key == 'k') {
      randomVertex(maskA_1_1);
    } else {
      returnVertex(RmaskA_1_1, maskA_1_1);
    }

    s3d.shape(maskA_1_1);
    s3d.popMatrix();


    //---------------眼睛_右
    s3d.pushMatrix();
    s3d.rotateZ(map(pow(sin(float(frameCount%10)/10*6.28), 8.0), 0, 1, 0, PI*0.01));
    if (keyPressed==true &&key == 'k') {
      randomVertex(maskA_1_2);
    } else {
      returnVertex(RmaskA_1_2, maskA_1_2);
    }
    s3d.shape(maskA_1_2);
    s3d.popMatrix();
    //---------------臉
    s3d.pushMatrix();
    if (keyPressed==true &&key == 'k') {
      randomVertex(maskA_2);
    } else {
      returnVertex(RmaskA_2, maskA_2);
    }
    s3d.shape(maskA_2);
    s3d.popMatrix();
    //---------------左
    s3d.pushMatrix();
    s3d.translate(map(pow(sin(a2/180*6.28), 8.0), 0, 1, 0, -40), 0);
    if (keyPressed==true &&key == 'k') {
      randomVertex(maskA_3_1);
    } else {
      returnVertex(RmaskA_3_1, maskA_3_1);
    }
    s3d.shape(maskA_3_1);
    s3d.popMatrix();
    //---------------右
    s3d.pushMatrix();
    s3d.translate(map(pow(sin(a2/180*6.28), 8.0), 0, 1, 0, 40), 0);
    if (keyPressed==true &&key == 'k') {
      randomVertex(maskA_3_2);
    } else {
      returnVertex(RmaskA_3_2, maskA_3_2);
    }
    s3d.shape(maskA_3_2);
    s3d.popMatrix();
    //---------------背板
    s3d.pushMatrix();
    s3d.rotate((easeInBack(a1/360))*6.28);
    if (keyPressed==true &&key == 'k') {
      randomVertex(maskA_4);
    } else {
      returnVertex(RmaskA_4, maskA_4);
    }
    s3d.shape(maskA_4);
    s3d.popMatrix();
    //---------------
  }
  s3d.popMatrix();
}

void Eye(boolean theFlag) {
  if (theFlag==true) {
    showMaskEye=false;
    thread("maskEyeSetting");
    randomCam();
  } else {
    showMaskEye=true;
    thread("maskEyeSetting");
  }
}