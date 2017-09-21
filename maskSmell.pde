boolean showMaskSmell =false;
pdLine  MaskSmellLine;
boolean MaskSmellIn;

PShape Smell_1;
PShape Smell_2;
PShape Smell_3;


void maskSmellSetting() {
  if (showMaskSmell==false) {
    MaskSmellLine=new pdLine(0, 1000);
    MaskSmellIn=true;
    Smell_1 = loadShape("maskSmell/smell_1.obj");
    Smell_2=  loadShape("maskSmell/smell_2.obj");
    Smell_3 = loadShape("maskSmell/smell_3.obj");
    showMaskSmell =true;
  } else if (showMaskSmell==true) {
    MaskSmellIn=false;
  }
  MaskSmellLine.reset();
}


void maskSmelldrawing() {
  showMaskSmell=returnState(MaskSmellLine, MaskSmellIn);
  s3d.pushMatrix();
  //----fade
  if (MaskSmellIn==true)s3d.translate(0, map(easeOutBack(MaskSmellLine.o), 0, 1, 500, 0));
  else  s3d.translate(0, map(easeInBack(MaskSmellLine.o), 0, 1, 0, -500));
  //----fadeEnd

  s3d.translate(width/2, height/2+map(sin(float(frameCount%300)/300*6.28), -1, 1, 0, -50), -50);
  s3d.rotateZ(PI);
  s3d.rotateY(radians(map(sin(float(frameCount%600)/600*6.28), -1, 1, -30, 30)));
  //--------------抖動
  s3d.rotateZ(map(pow(sin(float(frameCount%10)/10*6.28), 8.0), 0, 1, 0, PI*-0.01));
  s3d.scale(0.8);
  //---------------
  s3d.pushMatrix();

  s3d.shape(Smell_1);
  s3d.popMatrix();
  //---------------
  s3d.pushMatrix();

  s3d.shape(Smell_2);
  s3d.popMatrix();
  //---------------
  s3d.pushMatrix();

  s3d.shape(Smell_3);
  s3d.popMatrix();
  //---------------
  s3d.popMatrix();
}