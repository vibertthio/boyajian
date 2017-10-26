RShape textDoor;
boolean showtoolDoor =false;
boolean toolDoorIn;

pdLine  toolDoorLine;
pdLine  toolDoorLineIn;
pdLine  toolDoorLineOut;

PShape Door_1;
PShape Door_2;
PImage DoorImg;
float Door_x, Door_y;

void toolDoorSetting() {

  textDoor= RG.getText("召喚鈴刀", "wt.ttf", 72, RFont.CENTER);


  if (showtoolDoor==false) {
    show[12]=1;
    countLife();

    toolDoorIn=true;


    showtoolDoor =true;
  } else if (showtoolDoor==true) {
    toolDoorIn=false;
    show[12]=0;
    countLife();
  }
  toolDoorLineIn=new pdLine(500, 1000);
  toolDoorLineOut=new pdLine(3500, 1000);
  toolDoorLine=new pdLine(0, 1000);
  toolDoorLine.reset();
  toolDoorLineIn.reset();
  toolDoorLineIn.done=false;
  toolDoorLineOut.reset();
}


void toolDoordrawing() {

  showtoolDoor=returnState(toolDoorLine, toolDoorIn);
  s3d.pushMatrix();
  {
    Door_x=width/2+countX[12].o;

    if (toolDoorIn==true) Door_y=height/2+44+ map(easeOutBack(toolDoorLine.o), 0, 1, 500, 0);
    else  Door_y=height/2+44+map(easeInBack(toolDoorLine.o), 0, 1, 0, -500);

    s3d.translate(Door_x, Door_y+anim(300, 0, -50, 2), -50);

    // s3d.pushMatrix();
    // s3d.translate(40, 0, 0);
    // s3d.fill(maskNmae, 155);
    // toolDoorLineIn.update();
    // toolDoorLineOut.update();
    // if (toolDoorLineIn.bang==true ) {
    //   textDoor.children[0].transform(70, easeInBack(toolDoorLineIn.oo)*300, 30, 30) ;
    //   textDoor.children[1].transform(102, -easeInBack(toolDoorLineIn.oo)*300, 30, 30) ;
    //   textDoor.children[2].transform(137, easeInBack(toolDoorLineIn.oo)*300, 30, 30) ;
    //   textDoor.children[3].transform(172, -easeInBack(toolDoorLineIn.oo)*300, 30, 30) ;
    // } else if (toolDoorLineIn.done==true  ) {
    //   textDoor.children[0].transform(70, easeInBack(toolDoorLineOut.o)*300, 30, 30) ;
    //   textDoor.children[1].transform(102, -easeInBack(toolDoorLineOut.o)*300, 30, 30) ;
    //   textDoor.children[2].transform(137, easeInBack(toolDoorLineOut.o)*300, 30, 30) ;
    //   textDoor.children[3].transform(172, -easeInBack(toolDoorLineOut.o)*300, 30, 30) ;
    //   defultCam();
    // }
    // if (toolDoorLineOut.bang==false) toolDoorLineIn.done=false;
    // if (toolDoorLineOut.o<0.99 && toolDoorLineIn.o>0.01 && toolDoorIn==true )textDoor.draw(s3d);
    //
    // s3d.popMatrix();


    s3d.rotateZ(PI);
    s3d.rotateY(radians(anim(550,-30,30,8)));
    s3d.scale(0.36);
    //---------------
    float angle=(step%90)/90;
    float angleMap=map(angle,0,1,0,360);

    s3d.pushMatrix();
    s3d.rotateY(radians(-angleMap));
    s3d.shape(Door_1);
    s3d.popMatrix();

    s3d.pushMatrix();
    s3d.translate(100,0,0);
    s3d.rotateY(radians(angleMap+30));
    s3d.shape(Door_1);
    s3d.popMatrix();

    s3d.pushMatrix();
    s3d.translate(-100,0,0);
    s3d.rotateY(radians(angleMap+60));
    s3d.shape(Door_1);
    s3d.popMatrix();
    //---------------
    s3d.pushMatrix();
    s3d.shape(Door_2);
    s3d.popMatrix();
  }
  s3d.popMatrix();
  if (wireFrameCtl==true) {
    noWireFrame(Door_1, random(1.80, 2.40), color(0, 165, 250, 120));
  } else {
    setTexture(Door_1, DoorImg);
  }
}
void Door(boolean theFlag) {
  if (theFlag==true) {
    showtoolDoor=false;
    thread("toolDoorSetting");
    //randomCam();
  } else {
    showtoolDoor=true;
    thread("toolDoorSetting");
  }
}
