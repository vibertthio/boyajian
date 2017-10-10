RShape textSwordA;
boolean showtoolSwordA =false;
boolean toolSwordAIn;

pdLine  toolSwordALine;
pdLine  toolSwordALineIn;
pdLine  toolSwordALineOut;

PShape SwordA_1;
float SwordA_x,SwordA_y;

void toolSwordASetting() {

  textSwordA= RG.getText("鎏金鈍刀", "wt.ttf", 72, RFont.CENTER);
  toolSwordALineIn=new pdLine(500, 1000);
  toolSwordALineOut=new pdLine(3500, 1000);

  if (showtoolSwordA==false) {
    show[10]=1;
    countLife();
    toolSwordALine=new pdLine(0, 1000);
    toolSwordAIn=true;
    SwordA_1 = loadShape("toolSwordA/sworda.obj");

    showtoolSwordA =true;
  } else if (showtoolSwordA==true) {
    toolSwordAIn=false;
    show[10]=0;
    countLife();
  }
  toolSwordALine.reset();
  toolSwordALineIn.reset();
  toolSwordALineIn.done=false;
  toolSwordALineOut.reset();
}


void toolSwordAdrawing() {
  toolSwordALineIn.update();
  toolSwordALineOut.update();
  showtoolSwordA=returnState(toolSwordALine, toolSwordAIn);
  s3d.pushMatrix();
  {
    SwordA_x=width/2+countX[10].o;
    SwordA_y=height/2+68;
    //----fade
    if (toolSwordAIn==true)s3d.translate(0, map(easeOutBack(toolSwordALine.o), 0, 1, 500, 0));
    else  s3d.translate(0, map(easeInBack(toolSwordALine.o), 0, 1, 0, -500));
    //----fadeEnd
    {//文字開始
      s3d.pushMatrix();
      s3d.translate(width/2, height/2-17, -50);
      s3d.scale(3.0);
      s3d.fill(maskNmae, 155);

      {//文字動畫
         if (toolSwordALineIn.bang==true ) {
          textSwordA.children[0].transform(70, easeInBack(toolSwordALineIn.oo)*300, 20, 20) ;
          textSwordA.children[1].transform(102, -easeInBack(toolSwordALineIn.oo)*300, 20, 20) ;
          textSwordA.children[2].transform(137, easeInBack(toolSwordALineIn.oo)*300, 20, 20) ;
          textSwordA.children[3].transform(172, -easeInBack(toolSwordALineIn.oo)*300, 20, 20) ;
        } else if (toolSwordALineIn.done==true  ) {
          textSwordA.children[0].transform(70, easeInBack(toolSwordALineOut.o)*300, 20, 20) ;
          textSwordA.children[1].transform(102, -easeInBack(toolSwordALineOut.o)*300, 20, 20) ;
          textSwordA.children[2].transform(137, easeInBack(toolSwordALineOut.o)*300, 20, 20) ;
          textSwordA.children[3].transform(172, -easeInBack(toolSwordALineOut.o)*300, 20, 20) ;
          defultCam();
        }

        if (toolSwordALineOut.bang==false) {
          toolSwordALineIn.done=false;
        }
      }//文字動畫結束

      s3d.strokeWeight(1);
      s3d.noStroke();
      if (toolSwordALineOut.o>0.001 || toolSwordALineIn.o>0.001 )
        if ( toolSwordAIn==true )textSwordA.draw(s3d);
      s3d.popMatrix();
    }//文字結束
    //-----model

    s3d.translate(SwordA_x, SwordA_y+map(sin(float(frameCount%300)/300*6.28), -1, 1, 0, -50), -50);
    s3d.rotateZ(PI);
    s3d.rotateY(radians(map(sin(float(frameCount%600)/600*6.28), -1, 1, -30, 30)));
    //--------------抖動
    s3d.rotateZ(map(pow(sin(float(frameCount%10)/10*6.28), 8.0), 0, 1, 0, PI*-0.01));
    s3d.scale(0.57);
    //---------------
    s3d.pushMatrix();
    s3d.rotateZ(pow(sin((a2+70)/90*6.28), 4.0)*0.2);
    s3d.shape(SwordA_1);
    s3d.popMatrix();

  }
  s3d.popMatrix();
}
void SwordA(boolean theFlag) {
  if (theFlag==true) {
    showtoolSwordA=false;
    thread("toolSwordASetting");
    randomCam();
  } else {
    showtoolSwordA=true;
    thread("toolSwordASetting");
  }
}