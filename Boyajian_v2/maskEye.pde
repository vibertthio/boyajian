boolean showMaskEye =false;
pdLine  MaskEyeLine;
pdLine  MaskEyeLineIn;
pdLine  MaskEyeLineOut;
boolean MaskEyeIn;

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

RFont name;
RGroup maGroupe ;
RPoint[] points;
RShape content;

void maskEyeSetting() {
  RG.init(this);
  name = new RFont("wt.ttf", 72, RFont.CENTER);
  content= RG.getText("三眼面具", "wt.ttf", 72, RFont.CENTER);
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
    MaskEyeLineIn.reset();
    MaskEyeLineOut.reset();
    MaskEyeLineIn.done=false;
  } else if (showMaskEye==true) {
    MaskEyeIn=false;
  }
  MaskEyeLine.reset();
}


void maskEyedrawing() {
  MaskEyeLineIn.update();
  MaskEyeLineOut.update();

  showMaskEye=returnState(MaskEyeLine, MaskEyeIn);
  s3d.pushMatrix();
  {
    //----fade
    if (MaskEyeIn==true)s3d.translate(0, map(easeOutBack(MaskEyeLine.o), 0, 1, 500, 0));
    else  s3d.translate(0, map(easeInBack(MaskEyeLine.o), 0, 1, 0, -500));
    //----fadeEnd

    s3d.pushMatrix();
    {
      s3d.translate(width/2, height/2+100, -50);
      s3d.scale(3.0);
      //s3d.blendMode(ADD);  
      s3d.fill(color(0.13*255, 0.59*255, 0.72*255), 255);

      if (MaskEyeLineIn.bang==true ) {
        content.children[0].transform(-162, -57+easeInBack(MaskEyeLineIn.oo)*300, 36, 36) ;
        content.children[1].transform(-81, -57-easeInBack(MaskEyeLineIn.oo)*300, 36, 36) ;
        content.children[2].transform(38, -57+easeInBack(MaskEyeLineIn.oo)*300, 36, 36) ;
        content.children[3].transform(122, -57-easeInBack(MaskEyeLineIn.oo)*300, 36, 36) ;
      } else if (MaskEyeLineIn.done==true  ) {
        content.children[0].transform(-162, -57+easeInBack(MaskEyeLineOut.o)*300, 36, 36) ;
        content.children[1].transform(-81, -57-easeInBack(MaskEyeLineOut.o)*300, 36, 36) ;
        content.children[2].transform(38, -57+easeInBack(MaskEyeLineOut.o)*300, 36, 36) ;
        content.children[3].transform(122, -57-easeInBack(MaskEyeLineOut.o)*300, 36, 36) ;
      }

      if (MaskEyeLineOut.bang==false) {
        MaskEyeLineIn.done=false;
      }

      if (MaskEyeLineOut.o>0.001 || MaskEyeLineIn.o>0.001 )
        if ( MaskEyeIn==true )content.draw(s3d);
    }
    s3d.popMatrix();

    s3d.translate(width/2, height/2+25+map(sin(float(frameCount%300)/300*6.28), -1, 1, 0, -50), -50);
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

void randomVertex(PShape who) {
  for (int j=0; j<who.getChildCount(); j++) {
    for (int i = 0; i < who.getChild(j).getVertexCount(); i++) {
      PVector v = who.getChild(j).getVertex(i);
      v.x += random(-6, 6);
      v.y += random(-6, 6);
      v.z += random(-6, 6);
      who.getChild(j).setVertex(i, v);
    }
  }
}

void returnVertex(PShape origon, PShape who) {
  for (int j=0; j<origon.getChildCount(); j++) {
    for (int i = 0; i < origon.getChild(j).getVertexCount(); i++) {
      PVector v = origon.getChild(j).getVertex(i);
      PVector v1 = who.getChild(j).getVertex(i);

      v1.x =(v.x-v1.x)*0.05 +v1.x;
      v1.y =(v.y-v1.y)*0.05 +v1.y;
      v1.z =(v.z-v1.z)*0.05 +v1.z;
      who.getChild(j).setVertex(i, v1);
    }
  }
}