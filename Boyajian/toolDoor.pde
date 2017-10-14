RShape textDoor;
boolean showtoolDoor =false;
boolean toolDoorIn;

pdLine  toolDoorLine;
pdLine  toolDoorLineIn;
pdLine  toolDoorLineOut;

PShape Door_1;
float Door_x, Door_y;

void toolDoorSetting() {

  textDoor= RG.getText("召喚鈴刀", "wt.ttf", 72, RFont.CENTER);


  if (showtoolDoor==false) {
    show[12]=1;
    countLife();

    toolDoorIn=true;
    Door_1 = loadShape("toolDoor/door.obj");

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

    if (toolDoorIn==true) Door_y=height/2+69+ map(easeOutBack(toolDoorLine.o), 0, 1, 500, 0);
    else  Door_y=height/2+69+map(easeInBack(toolDoorLine.o), 0, 1, 0, -500);

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
    s3d.rotateY(radians(map(sin(float(frameCount%600)/600*6.28), -1, 1, -30, 30)));
    //--------------抖動
    s3d.rotateZ(map(pow(sin(float(frameCount%10)/10*6.28), 8.0), 0, 1, 0, PI*-0.01));
    s3d.scale(0.36);
    //---------------
    s3d.pushMatrix();
    s3d.rotateZ(anim(90,0,0.2,4));
    s3d.shape(Door_1);
    s3d.popMatrix();
  }
  s3d.popMatrix();
}
void Door(boolean theFlag) {
  if (theFlag==true) {
    showtoolDoor=false;
    thread("toolDoorSetting");
    randomCam();
  } else {
    showtoolDoor=true;
    thread("toolDoorSetting");
  }
}