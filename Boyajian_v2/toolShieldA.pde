RShape textShieldA;
boolean showtoolShieldA =false;
boolean toolShieldAIn;

pdLine  toolShieldALine;
pdLine  toolShieldALineIn;
pdLine  toolShieldALineOut;

PShape ShieldA_1;
PShape ShieldA_2;

float ShieldA_x, ShieldA_y;

void toolShieldASetting() {

  textShieldA= RG.getText("弭戰之盾", "wt.ttf", 72, RFont.CENTER);


  if (showtoolShieldA==false) {
    show[9]=1;
    countLife();

    toolShieldAIn=true;
    ShieldA_1 = loadShape("toolShieldA/shielda_1.obj");
    ShieldA_2 = loadShape("toolShieldA/shielda_2.obj");

    showtoolShieldA =true;
  } else if (showtoolShieldA==true) {
    toolShieldAIn=false;
    show[9]=0;
    countLife();
  }

  toolShieldALineIn=new pdLine(500, 1000);
  toolShieldALineOut=new pdLine(3500, 1000);
  toolShieldALine=new pdLine(0, 1000);
  toolShieldALine.reset();
  toolShieldALineIn.reset();
  toolShieldALineIn.done=false;
  toolShieldALineOut.reset();
}


void toolShieldAdrawing() {

  showtoolShieldA=returnState(toolShieldALine, toolShieldAIn);
  s3d.pushMatrix();
  {
    ShieldA_x=width/2+countX[9].o;


    if (toolShieldAIn==true) ShieldA_y=height/2+54+map(easeOutBack(toolShieldALine.o), 0, 1, 500, 0);
    else   ShieldA_y=height/2+54+map(easeInBack(toolShieldALine.o), 0, 1, 0, -500);

    s3d.translate(ShieldA_x, ShieldA_y+anim(300, 0, -50, 2), -50);

    // s3d.pushMatrix();
    // s3d.translate(40, 0, -50);
    // s3d.fill(maskNmae, 155);
    // toolShieldALineIn.update();
    // toolShieldALineOut.update();
    // if (toolShieldALineIn.bang==true ) {
    //   textShieldA.children[0].transform(70, easeInBack(toolShieldALineIn.oo)*300, 30, 30) ;
    //   textShieldA.children[1].transform(102, -easeInBack(toolShieldALineIn.oo)*300, 30, 30) ;
    //   textShieldA.children[2].transform(137, easeInBack(toolShieldALineIn.oo)*300, 30, 30) ;
    //   textShieldA.children[3].transform(172, -easeInBack(toolShieldALineIn.oo)*300, 30, 30) ;
    // } else if (toolShieldALineIn.done==true  ) {
    //   textShieldA.children[0].transform(70, easeInBack(toolShieldALineOut.o)*300, 30, 30) ;
    //   textShieldA.children[1].transform(102, -easeInBack(toolShieldALineOut.o)*300, 30, 30) ;
    //   textShieldA.children[2].transform(137, easeInBack(toolShieldALineOut.o)*300, 30, 30) ;
    //   textShieldA.children[3].transform(172, -easeInBack(toolShieldALineOut.o)*300, 30, 30) ;
    //   defultCam();
    // }
    //
    // if (toolShieldALineOut.bang==false)  toolShieldALineIn.done=false;
    // if (toolShieldALineOut.o<0.99 && toolShieldALineIn.o>0.001 &&toolShieldAIn==true)textShieldA.draw(s3d);
    // s3d.popMatrix();

    s3d.rotateZ(PI);
    s3d.rotateY(radians(map(sin(float(frameCount%600)/600*6.28), -1, 1, -30, 30)));
    //--------------抖動
    s3d.rotateZ(map(pow(sin(float(frameCount%10)/10*6.28), 8.0), 0, 1, 0, PI*-0.01));
    s3d.scale(0.50);
    //---------------
    s3d.pushMatrix();
    s3d.shape(ShieldA_1);
    s3d.popMatrix();
    //---------------
    s3d.pushMatrix();
    s3d.shape(ShieldA_2);
    s3d.popMatrix();
  }
  s3d.popMatrix();
}
void ShieldA(boolean theFlag) {
  if (theFlag==true) {
    showtoolShieldA=false;
    thread("toolShieldASetting");
    randomCam();
  } else {
    showtoolShieldA=true;
    thread("toolShieldASetting");
  }
}