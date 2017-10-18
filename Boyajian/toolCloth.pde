RShape textCloth;
boolean showtoolCloth =false;
boolean toolClothIn;

pdLine  toolClothLine;
pdLine  toolClothLineIn;
pdLine  toolClothLineOut;

PShape Cloth_1;
PImage ClothImg;

float Cloth_x, Cloth_y;

void toolClothSetting() {

  textCloth= RG.getText("召喚鈴刀", "wt.ttf", 72, RFont.CENTER);

  if (showtoolCloth==false) {
    show[13]=1;
    countLife();
    ClothImg=loadImage("toolCloth/tex_cloth.png");
    toolClothIn=true;
    Cloth_1 = loadShape("toolCloth/cloth.obj");

    showtoolCloth =true;
  } else if (showtoolCloth==true) {
    toolClothIn=false;
    show[13]=0;
    countLife();
  }
  toolClothLineIn=new pdLine(500, 1000);
  toolClothLineOut=new pdLine(3500, 1000);
  toolClothLine=new pdLine(0, 1000);
  toolClothLine.reset();
  toolClothLineIn.reset();
  toolClothLineIn.done=false;
  toolClothLineOut.reset();
}


void toolClothdrawing() {

  showtoolCloth=returnState(toolClothLine, toolClothIn);
  s3d.pushMatrix();
  {
    Cloth_x=width/2+countX[13].o;

    if (toolClothIn==true) Cloth_y=height/2+-25+ map(easeOutBack(toolClothLine.o), 0, 1, 500, 0);
    else  Cloth_y=height/2+69+map(easeInBack(toolClothLine.o), 0, 1, 0, -500);

    s3d.translate(Cloth_x, Cloth_y+anim(300, 0, -50, 2), -50);

    // s3d.pushMatrix();
    // s3d.translate(40, 0, 0);
    // s3d.fill(maskNmae, 155);
    // toolClothLineIn.update();
    // toolClothLineOut.update();
    // if (toolClothLineIn.bang==true ) {
    //   textCloth.children[0].transform(70, easeInBack(toolClothLineIn.oo)*300, 30, 30) ;
    //   textCloth.children[1].transform(102, -easeInBack(toolClothLineIn.oo)*300, 30, 30) ;
    //   textCloth.children[2].transform(137, easeInBack(toolClothLineIn.oo)*300, 30, 30) ;
    //   textCloth.children[3].transform(172, -easeInBack(toolClothLineIn.oo)*300, 30, 30) ;
    // } else if (toolClothLineIn.done==true  ) {
    //   textCloth.children[0].transform(70, easeInBack(toolClothLineOut.o)*300, 30, 30) ;
    //   textCloth.children[1].transform(102, -easeInBack(toolClothLineOut.o)*300, 30, 30) ;
    //   textCloth.children[2].transform(137, easeInBack(toolClothLineOut.o)*300, 30, 30) ;
    //   textCloth.children[3].transform(172, -easeInBack(toolClothLineOut.o)*300, 30, 30) ;
    //   defultCam();
    // }
    // if (toolClothLineOut.bang==false) toolClothLineIn.done=false;
    // if (toolClothLineOut.o<0.99 && toolClothLineIn.o>0.01 && toolClothIn==true )textCloth.draw(s3d);
    //
    // s3d.popMatrix();


    s3d.rotateZ(PI);
    s3d.rotateY(radians(anim(500,-30,30,8)));
    s3d.scale(0.47);
    //---------------
    s3d.pushMatrix();
    s3d.shape(Cloth_1);
    s3d.popMatrix();
  }
  s3d.popMatrix();
  if (wireFrameCtl==true) {
    noWireFrame(Cloth_1, random(1.80, 2.40), color(0, 165, 250, 120));
  } else {
    setTexture(Cloth_1, ClothImg);
  }
}
void Cloth(boolean theFlag) {
  if (theFlag==true) {
    showtoolCloth=false;
    thread("toolClothSetting");
    randomCam();
  } else {
    showtoolCloth=true;
    thread("toolClothSetting");
  }
}
