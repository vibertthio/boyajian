void keyPressed() {
  if (key == '1')  {effectGLSL = loadShader("glsl/no.glsl");
}
  if (key == '2') {
    effectGLSL = loadShader("glsl/radialBlur.glsl");
    effectGLSL.set("vol", 1.0);
  }
  if (key == '3') {
    effectGLSL = loadShader("glsl/rgbGlitch_1.glsl");
    effectGLSL.set("vol", 1.0);
  }
  if (key == '4') {
    effectGLSL = loadShader("glsl/rgbGlitch_2.glsl");
    effectGLSL.set("vol", 1.0);
  } 
  if (key == '5') {
    effectGLSL = loadShader("glsl/Noisy_Mirror.frag");
    effectGLSL.set("vol", 0.4);
  } 
  if (key == '6') {
     effectGLSL = loadShader("glsl/glitch.glsl");
    effectGLSL.set("vol", 0.6);
  } 

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


float nr;
float vl;
float pi;
float vel;

int notes[]=new int[300];
void sendNote2p5() {
  float nn=pi;
  float vv=vel;
  if (nn==41)if (vv==127)Eye(true);
  else Eye(false);

  if (nn==42)if (vv==127)Smell(true);
  else Smell(false);

  if (nn==43)if (vv==127)Listen(true);
  else Listen(false);

  if (nn==44)if (vv==127)Touch(true);
  else Touch(false);

  if (nn==57)if (vv==127)Taste(true);
  else Taste(false);

  if (nn==58)if (vv==127)Memory(true);
  else Memory(false);

  if (nn==59)if (vv==127)Dream(true);
  else Dream(false);

  if (nn==60)if (vv==127)Faces(true);
  else Faces(false);

  //-----------------------------------

  if (nn==73)if (vv==127)SwordA(true);
  else SwordA(false);

  if (nn==74)if (vv==127)SwordB(true);
  else SwordB(false);

  if (nn==75)if (vv==127)ShieldA(true);
  else ShieldA(false);

  if (nn==76)if (vv==127)ShieldB(true);
  else ShieldB(false);

  if (nn==89)if (vv==127);
  else ;

  if (nn==90)if (vv==127);
  else ;

  if (nn==91)if (vv==127);
  else ;

  if (nn==92)if (vv==127);
  else ;
  
  if (nn==105)if (vv==127)autoCam(true);
  else autoCam(false);
  
  if (nn==106)if (vv==127)showPtn(true);
  else showPtn(false);
  
  if (nn==110)if (vv==127)autoBg(true);
  else autoBg(false);
  
  if (nn==112)if (vv==127)autoBlend(true);
  else autoBlend(false);
  
  if (nn==113)if (vv==127)l3Sw(true); 
  else l3Sw(false); 
  
  if (nn==115)if (vv==127)l3Rt(true);
  else l3Rt(false);
}

void sendCtl2p5(float nr, float vl) {
}

void controllerChange(ControlChange change) {
  nr=change.number();
  vl=change.value()*2;
  //sendCtl2p5(nr, vl);
}


void noteOn(Note note) {
  pi=note.pitch();
  vel=note.velocity();
  myBus.sendNoteOn(note.channel(), note.pitch(), note.velocity());
  notes[note.pitch()]=note.velocity();
  sendNote2p5();
}

void noteOff(Note note) {
  pi=note.pitch();
  vel=note.velocity();
  myBus.sendNoteOff(note.channel(), note.pitch(), note.velocity());

  if (notes[note.pitch()]==127) {
    notes[note.pitch()]=note.velocity();
    sendNote2p5();
  }
  //println("off", note.channel(), note.pitch(), note.velocity());
}