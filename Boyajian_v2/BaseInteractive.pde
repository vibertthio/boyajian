void keyPressed() {
  if (key == '1') thread("maskEyeSetting");
  if (key == '2') thread("maskListenSetting");
  if (key == '3') thread("maskSmellSetting");
  if (key == '4') thread("maskTouchSetting");
  if (key == '5') thread("maskTasteSetting");
  if (key == '6') thread("maskDreamSetting");

  if (key == 'r') defultCam();
  if (key == 't') randomCam();
  if (key == 'e') showPtnTgl = !showPtnTgl;
  if (key == 'b') {
    blendIndex = int(random(10));
    imgIndex=int(random(5));
  }
  if (key == 'n') {
    blendIndex=7;
    imgIndex=2;
  }


  if (key == 'a') {
    for (int i=0; i<nb; i++) {
      slash[i].initSlash();
    }
  }

  // change background and shader algorithm
  if (key == CODED) {
    if (keyCode == UP) {
      blendIndex = ( blendIndex + 1 ) % 10;
    } else if (keyCode == DOWN) {
      if (blendIndex > 0) {
        blendIndex = ( blendIndex - 1 ) % 10;
      } else {
        blendIndex = 9;
      }
    } else if (keyCode == RIGHT) {
      imgIndex = ( imgIndex + 1 ) % 5;
      blendGLSL.set( "lowLayer", bgs [imgIndex]);
    } else if (keyCode == LEFT) {
      if (imgIndex > 0) {
        imgIndex = ( imgIndex - 1 ) % 5;
      } else {
        imgIndex = 4;
      }
      blendGLSL.set( "lowLayer", bgs [imgIndex]);
    }
  }
}


void mouseDragged()
{
  if (mouseButton == LEFT)
  {
    rotX += (mouseX - pmouseX)*0.01;
    rotY += (mouseY - pmouseY)*0.01;
  }
  if (mouseButton == RIGHT)
  {
    camX -= (mouseX - pmouseX)*0.5;
    camY -= (mouseY - pmouseY)*0.5;
  }
  if (mouseButton == CENTER)camZ += (mouseY - pmouseY)*0.5;
}

void randomCam() {
  cam[0]=random(350, 750);
  cam[1]=random(100, 300);
  cam[2]=random(400, 460);
  cam[3]=random(-1, 1);
  cam[4]=random(-1, 1);
  resetCamDo=true;
}

void defultCam() {
  cam[0]=600;
  cam[1]=200;
  cam[2]=430;
  cam[3]=0;
  cam[4]=0;
  resetCamDo=true;
}
