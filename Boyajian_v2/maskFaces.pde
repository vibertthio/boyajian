RShape textFaces;
boolean showMaskFaces =false;
boolean MaskFacesIn;

pdLine  MaskFacesLine;
pdLine  MaskFacesLineIn;
pdLine  MaskFacesLineOut;

PShape Faces_1;
PShape Faces_2;
PShape Faces_3;


void maskFacesSetting() {

  textFaces= RG.getText("三首犬衛", "wt.ttf", 72, RFont.CENTER);
  MaskFacesLineIn=new pdLine(500, 1000);
  MaskFacesLineOut=new pdLine(3500, 1000);

  if (showMaskFaces==false) {
    MaskFacesLine=new pdLine(0, 1000);
    MaskFacesIn=true;
    Faces_1 = loadShape("maskFaces/faces_1.obj");
    Faces_2=  loadShape("maskFaces/faces_2.obj");
    Faces_3 = loadShape("maskFaces/faces_3.obj");
    showMaskFaces =true;
  } else if (showMaskFaces==true) {
    MaskFacesIn=false;
  }
  MaskFacesLine.reset();
  MaskFacesLineIn.reset();
  MaskFacesLineIn.done=false;
  MaskFacesLineOut.reset();
}


void maskFacesdrawing() {
  MaskFacesLineIn.update();
  MaskFacesLineOut.update();
  showMaskFaces=returnState(MaskFacesLine, MaskFacesIn);
  s3d.pushMatrix();
  {
    //----fade
    if (MaskFacesIn==true)s3d.translate(0, map(easeOutBack(MaskFacesLine.o), 0, 1, 500, 0));
    else  s3d.translate(0, map(easeInBack(MaskFacesLine.o), 0, 1, 0, -500));
    //----fadeEnd
    {//文字開始
      s3d.pushMatrix();
      s3d.translate(width/2, height/2-17, -50);
      s3d.scale(3.0);
      s3d.fill(color(0.72*255, 0.53*255, 0.0*255), 155);

      {//文字動畫
         if (MaskFacesLineIn.bang==true ) {
          textFaces.children[0].transform(70, easeInBack(MaskFacesLineIn.oo)*300, 20, 20) ;
          textFaces.children[1].transform(102, -easeInBack(MaskFacesLineIn.oo)*300, 20, 20) ;
          textFaces.children[2].transform(137, easeInBack(MaskFacesLineIn.oo)*300, 20, 20) ;
          textFaces.children[3].transform(172, -easeInBack(MaskFacesLineIn.oo)*300, 20, 20) ;
        } else if (MaskFacesLineIn.done==true  ) {
          textFaces.children[0].transform(70, easeInBack(MaskFacesLineOut.o)*300, 20, 20) ;
          textFaces.children[1].transform(102, -easeInBack(MaskFacesLineOut.o)*300, 20, 20) ;
          textFaces.children[2].transform(137, easeInBack(MaskFacesLineOut.o)*300, 20, 20) ;
          textFaces.children[3].transform(172, -easeInBack(MaskFacesLineOut.o)*300, 20, 20) ;
          defultCam();
        }

        if (MaskFacesLineOut.bang==false) {
          MaskFacesLineIn.done=false;
        }
      }//文字動畫結束

      s3d.strokeWeight(1);
      s3d.noStroke();
      if (MaskFacesLineOut.o>0.001 || MaskFacesLineIn.o>0.001 )
        if ( MaskFacesIn==true )textFaces.draw(s3d);
      s3d.popMatrix();
    }//文字結束
    //-----model

    s3d.translate(width/2, height/2+map(sin(float(frameCount%300)/300*6.28), -1, 1, 0, -50), -50);
    s3d.rotateZ(PI);
    s3d.rotateY(radians(map(sin(float(frameCount%600)/600*6.28), -1, 1, -30, 30)));
    //--------------抖動
    s3d.rotateZ(map(pow(sin(float(frameCount%10)/10*6.28), 8.0), 0, 1, 0, PI*-0.01));
    s3d.scale(0.8);
    //---------------
    s3d.pushMatrix();
    s3d.rotateZ(pow(sin(a2/90*6.28), 4.0)*0.2);
    s3d.shape(Faces_1);
    s3d.popMatrix();
    //---------------
    s3d.pushMatrix();
    s3d.rotateZ(pow(sin(a2/90*6.28), 4.0)*-0.2);
    s3d.shape(Faces_2);
    s3d.popMatrix();
    //---------------
    s3d.pushMatrix();
    s3d.shape(Faces_3);
    s3d.popMatrix();
    //---------------
  }
  s3d.popMatrix();
}
void Faces(boolean theFlag) {
  if (theFlag==true) {
    showMaskFaces=false;
    thread("maskFacesSetting");
    randomCam();
  } else {
    showMaskFaces=true;
    thread("maskFacesSetting");
  }
}
