RShape textFaces;
boolean showMaskFaces =false;
boolean MaskFacesIn;

pdLine  MaskFacesLine;
pdLine  MaskFacesLineIn;
pdLine  MaskFacesLineOut;

PShape Faces_1;
PShape Faces_2;
PShape Faces_3;

PShape rFaces_1;
PShape rFaces_2;
PShape rFaces_3;

PImage FacesImg;

float Faces_x, Faces_y;

void maskFacesSetting() {

  textFaces= RG.getText("三首犬衛", "wt.ttf", 72, RFont.CENTER);

  if (showMaskFaces==false) {
    show[2]=1;
    countLife();
    FacesImg=loadImage("maskFaces/tex_faces.png");
    MaskFacesIn=true;
    Faces_1 = loadShape("maskFaces/faces_1.obj");
    Faces_2=  loadShape("maskFaces/faces_2.obj");
    Faces_3 = loadShape("maskFaces/faces_3.obj");

    rFaces_1 = loadShape("maskFaces/faces_1.obj");
    rFaces_2=  loadShape("maskFaces/faces_2.obj");
    rFaces_3 = loadShape("maskFaces/faces_3.obj");
    showMaskFaces =true;
  } else if (showMaskFaces==true) {
    MaskFacesIn=false;
    show[2]=0;
    countLife();
  }
  MaskFacesLineIn=new pdLine(500, 1000);
  MaskFacesLineOut=new pdLine(3500, 1000);
  MaskFacesLine=new pdLine(0, 1000);
  MaskFacesLine.reset();
  MaskFacesLineIn.reset();
  MaskFacesLineIn.done=false;
  MaskFacesLineOut.reset();
}


void maskFacesdrawing() {

  showMaskFaces=returnState(MaskFacesLine, MaskFacesIn);
  s3d.pushMatrix();
  {
    Faces_x=width/2+countX[2].o;

    //----fade
    if (MaskFacesIn==true) Faces_y=height/2+19+map(easeOutBack(MaskFacesLine.o), 0, 1, 500, 0);
    else  Faces_y=height/2+19+map(easeInBack(MaskFacesLine.o), 0, 1, 0, -500);
    //----fadeEnd
    s3d.translate(Faces_x, Faces_y+anim(300, 0, -50, 2), -50);

    // s3d.pushMatrix(); //-------文字開始
    // s3d.translate(40, 0, 0);
    // s3d.fill(maskNmae, 155);
    // MaskFacesLineIn.update();
    // MaskFacesLineOut.update();
    //
    // if (MaskFacesLineIn.bang==true ) {
    //   textFaces.children[0].transform(70, easeInBack(MaskFacesLineIn.oo)*300, 30, 30) ;
    //   textFaces.children[1].transform(102, -easeInBack(MaskFacesLineIn.oo)*300, 30, 30) ;
    //   textFaces.children[2].transform(137, easeInBack(MaskFacesLineIn.oo)*300, 30, 30) ;
    //   textFaces.children[3].transform(172, -easeInBack(MaskFacesLineIn.oo)*300, 30, 30) ;
    // } else if (MaskFacesLineIn.done==true  ) {
    //   textFaces.children[0].transform(70, easeInBack(MaskFacesLineOut.o)*300, 30, 30) ;
    //   textFaces.children[1].transform(102, -easeInBack(MaskFacesLineOut.o)*300, 30, 30) ;
    //   textFaces.children[2].transform(137, easeInBack(MaskFacesLineOut.o)*300, 30, 30) ;
    //   textFaces.children[3].transform(172, -easeInBack(MaskFacesLineOut.o)*300, 30, 30) ;
    //   defultCam();
    // }
    //
    // if (MaskFacesLineOut.bang==false) MaskFacesLineIn.done=false;
    // if (MaskFacesLineOut.o<0.99 && MaskFacesLineIn.o>0.01 && MaskFacesIn==true)  textFaces.draw(s3d);
    //
    // s3d.popMatrix();//-------文字end


    s3d.rotateZ(PI);
    s3d.rotateY(radians(anim(600, -30, 30, 2)));
    //--------------抖動
    s3d.rotateZ(anim(10, 0, PI*-0.01, 8));
    s3d.scale(0.51);
    //---------------
    s3d.pushMatrix();
    s3d.rotateZ(anim(90,0,0.2,4));
    if (vertexNoise==true) randomVertex(Faces_1);
    else returnVertex(rFaces_1, Faces_1);
    s3d.scale(vol*0.2+1.0);
    s3d.shape(Faces_1);
    s3d.popMatrix();
    //---------------
    s3d.pushMatrix();
    s3d.rotateZ(anim(90,0,-0.2,4));
    if (vertexNoise==true) randomVertex(Faces_2);
    else returnVertex(rFaces_2, Faces_2);
    s3d.scale(vol*0.2+1.0);
    s3d.shape(Faces_2);
    s3d.popMatrix();
    //---------------
    s3d.pushMatrix();
    if (vertexNoise==true) randomVertex(Faces_3);
    else returnVertex(rFaces_3, Faces_3);
    s3d.scale(1,vol*0.4+1.0,1);
    s3d.shape(Faces_3);
    s3d.popMatrix();
    //---------------
  }
  s3d.popMatrix();
  if (wireFrameCtl==true) {
    noWireFrame(Faces_1, random(1.80, 2.40), color(255, 120));
    noWireFrame(Faces_2, random(1.80, 2.40), color(255, 120));
    noWireFrame(Faces_3, random(1.80, 2.40), color(255, 120));
  } else {
    setTexture(Faces_1, FacesImg);
    setTexture(Faces_2, FacesImg);
    setTexture(Faces_3, FacesImg);
  }

  if (vertexNoise==true) {
    addWireFrame(Faces_1);
    addWireFrame(Faces_2);
    addWireFrame(Faces_3);
  }
}
void Faces(boolean theFlag) {
  if (theFlag==true) {
    showMaskFaces=false;
    thread("maskFacesSetting");
    //randomCam();
  } else {
    showMaskFaces=true;
    thread("maskFacesSetting");
  }
}