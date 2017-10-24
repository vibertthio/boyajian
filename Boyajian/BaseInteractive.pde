boolean keyz[] = new boolean [20];
int tempEffect=3;
void keyReleased() {
  if ( key==CODED) {
    if (keyCode == ALT) {
      keyz[0] = false;
    }
  }
  if (key=='s') {
    effectGLSL = loadShader("glsl/no.glsl");
    effectGLSL.set("alpha", 0.8);
  }

  if (key=='l')  autoBlend=false;
  if (key=='p') autoBg=false;
}


void keyPressed() {

  if (key=='l') autoBlend=true;
  if (key=='p') autoBg=true;
  if (key=='o')  oneShotBang=true;


  if (key=='s') {
    if (tempEffect==1) ;
    else if (tempEffect==2) effectGLSL = loadShader("glsl/radialBlur.glsl");
    else if (tempEffect==3) effectGLSL = loadShader("glsl/rgbGlitch_1.glsl");
    else if (tempEffect==4) effectGLSL = loadShader("glsl/rgbGlitch_2.glsl");
    else if (tempEffect==5) effectGLSL = loadShader("glsl/Noisy_Mirror.frag");
    else if (tempEffect==6) effectGLSL = loadShader("glsl/glitch.glsl");
    else if (tempEffect==7) effectGLSL = loadShader("glsl/zoomBlur.glsl");
    else if (tempEffect==8) effectGLSL = loadShader("glsl/bloom.glsl");
    else if (tempEffect==9) effectGLSL = loadShader("glsl/sobel_2.glsl");
    else if (tempEffect==10) effectGLSL = loadShader("glsl/sobel_1.glsl");
    effectGLSL.set("vol", 1.0);
  }
  if (key == '_') {
    smooth.reset(120);
  }

  if ( key==CODED) {
    if (keyCode == ALT) {
      keyz[0] = true;
    }
  }
  if (keyz[0]==true) {
    if (key == '1') {
      blendIndex=5;
      imgIndex=0;
      blendGLSL.set( "lowLayer", bgs [imgIndex]);
      pp=4;
      layer[8]=200;
    }
    if (key == '2') {
      blendIndex=5;
      imgIndex=1;
      blendGLSL.set( "lowLayer", bgs [imgIndex]);
      pp=6;
      layer[8]=230;
    }
    if (key == '3') {
      blendIndex=3;
      imgIndex=2;
      blendGLSL.set( "lowLayer", bgs [imgIndex]);
      pp=14;
      layer[8]=200;
    }
    if (key == '4') {
      blendIndex=3;
      imgIndex=3;
      blendGLSL.set( "lowLayer", bgs [imgIndex]);
      pp=8;
      layer[8]=200;
    }
    if (key == '5') {
      blendIndex=7;
      imgIndex=4;
      blendGLSL.set( "lowLayer", bgs [imgIndex]);
      pp=3;
      layer[8]=220;
    }
  }

  if (keyz[0]==false) {
    if (key == '1') {
      effectGLSL = loadShader("glsl/no.glsl");
      effectGLSL.set( "alpha", 1.0);
    }
    if (key == '2') {
      effectGLSL = loadShader("glsl/radialBlur.glsl");
      effectGLSL.set("vol", 1.0);
      tempEffect=2;
    }
    if (key == '3') {
      effectGLSL = loadShader("glsl/rgbGlitch_1.glsl");
      effectGLSL.set("vol", 1.0);
      tempEffect=3;
    }
    if (key == '4') {
      effectGLSL = loadShader("glsl/rgbGlitch_2.glsl");
      effectGLSL.set("vol", 1.0);
      tempEffect=4;
    }
    if (key == '5') {
      effectGLSL = loadShader("glsl/Noisy_Mirror.frag");
      effectGLSL.set("vol", 0.4);
      tempEffect=5;
    }
    if (key == '6') {
      effectGLSL = loadShader("glsl/glitch.glsl");
      effectGLSL.set("vol", 0.6);
      tempEffect=6;
    }

    if (key == '7') {
      effectGLSL = loadShader("glsl/zoomBlur.glsl");
      effectGLSL.set("vol", 0.6);
      tempEffect=7;
    }

    if (key == '8') {
      effectGLSL = loadShader("glsl/bloom.glsl");
      effectGLSL.set("vol", 0.6);
      tempEffect=8;
    }
    if (key == '9') {
      effectGLSL = loadShader("glsl/sobel_2.glsl");
      effectGLSL.set("vol", 1.0);
      effectGLSL.set("resolution", width, height);
      tempEffect=9;
    }
    if (key == '0') {
      effectGLSL = loadShader("glsl/sobel_1.glsl");
      effectGLSL.set("vol", 1.0);
      effectGLSL.set("resolution", width, height);
      tempEffect=10;
    }
  }

  if (key == 'q') splitNum =1;
  if (key == 'a') splitNum =2;
  if (key == 'z') splitNum =4;

  if (key == 'u') superCloseCam();
  if (key == 'y') closeCam();
  if (key == 'e') zoonCam();
  if (key == 'r') defultCam();
  if (key == 't') randomCam();
  if (key == 'g') superRandomCam();
  if (key == 's') record = !record;


  if (key == 'w') wireFrameCtl =!wireFrameCtl;
  if (key == 'k') vertexNoise =!vertexNoise;
  if (key == 'h') holdVertex =!holdVertex;

  if (key == 'f') {
    autoCamMetroUpDown.tgl= !autoCamMetroUpDown.tgl;
    if (autoCamMetroUpDown.tgl==false) {
      defultCam();
    }
  }

  // Vibert's Functions
  if (key == 'v') {
    println("press v!");
    animationRotateGridTrigger();
  }
  if (key == 'c') {
    animationGrowGridTrigger();
  }
  if (key == 'x') {
    animationStripTrigger();
  }
  if (key == 'b') {
    animationCircleTrigger();
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

float nr;
float vl;
float pi;
float vel;
float ch;

int notes[]=new int[300];
void sendNote2p5() {
  float nn=pi;
  float vv=vel;
  //---------------------------------------------ch1
  if (ch==1) {
    if (nn==24)if (vv==127)Eye(true);
    else Eye(false);

    if (nn==25)if (vv==127)Smell(true);
    else Smell(false);

    if (nn==26)if (vv==127)Listen(true);
    else Listen(false);

    if (nn==27)if (vv==127)Touch(true);
    else Touch(false);

    if (nn==28)if (vv==127)Taste(true);
    else Taste(false);

    if (nn==29)if (vv==127)Memory(true);
    else Memory(false);

    if (nn==30)if (vv==127)Dream(true);
    else Dream(false);

    if (nn==31)if (vv==127)Faces(true);
    else Faces(false);

    //------------

    if (nn==36)if (vv==127)SwordA(true);
    else SwordA(false);

    if (nn==37)if (vv==127)SwordB(true);
    else SwordB(false);

    if (nn==38)if (vv==127)ShieldA(true);
    else ShieldA(false);

    if (nn==39)if (vv==127)ShieldB(true);
    else ShieldB(false);

    if (nn==40)if (vv==127)Door(true);
    else Door(false);

    if (nn==41)if (vv==127)Cloth(true);
    else Cloth(false);

    if (nn==42)if (vv==127)Goat(true);
    else Goat(false);

    if (nn==43)if (vv==127)Wind(true);
    else Wind(false);
  }
  //---------------------------------------------ch2 up
  if (ch==2) {
    if (nn==24)if (vv==127) {
      rotateGridTriggerIndex = 0;
      animationRotateGridTrigger() ;
    }

    if (nn==25)if (vv==127) {
      rotateGridTriggerIndex = 1;
      animationRotateGridTrigger() ;
    }

    if (nn==26)if (vv==127)
    {
      rotateGridTriggerIndex = 2;
      animationRotateGridTrigger() ;
    }

    if (nn==27)if (vv==127) {
      rotateGridTriggerIndex = 3;
      animationRotateGridTrigger() ;
    }

    if (nn==28)if (vv==127) {
      rotateGridTriggerIndex = 4;
      animationRotateGridTrigger() ;
    }

    if (nn==29)if (vv==127) {
      rotateGridTriggerIndex = 5;
      animationRotateGridTrigger() ;
    }

    if (nn==30)if (vv==127) {
      rotateGridTriggerIndex = 6;
      animationRotateGridTrigger() ;
    }

    if (nn==31)if (vv==127) {
      rotateGridTriggerIndex = 7;
      animationRotateGridTrigger() ;
    }

    //---------------------------------------------ch2 down

    if (nn==36)if (vv==127) {
      growGridTriggerIndex=0;
      animationGrowGridTrigger() ;
    }

    if (nn==37)if (vv==127) {
      growGridTriggerIndex=1;
      animationGrowGridTrigger() ;
    }

    if (nn==38)if (vv==127) {
      growGridTriggerIndex=2;
      animationGrowGridTrigger() ;
    }

    if (nn==39)if (vv==127) {
      growGridTriggerIndex=3;
      animationGrowGridTrigger() ;
    }

    if (nn==40)if (vv==127) {
      growGridTriggerIndex=4;
      animationGrowGridTrigger() ;
    }

    if (nn==41)if (vv==127) {
      growGridTriggerIndex=5;
      animationGrowGridTrigger() ;
    }

    if (nn==42)if (vv==127) {
      growGridTriggerIndex=6;
      animationGrowGridTrigger() ;
    }

    if (nn==43)if (vv==127) {
      growGridTriggerIndex=7;
      animationGrowGridTrigger() ;
    }
  }
  //---------------------------------------------ch3 up

  if (ch==3) {
    if (nn==24)if (vv==127) {
      stripTriggerIndex=0;
      animationStripTrigger() ;
      println("test");
    }

    if (nn==25)if (vv==127) {
      stripTriggerIndex=1;
      animationStripTrigger() ;
    }

    if (nn==26)if (vv==127)
    {
      stripTriggerIndex=2;
      animationStripTrigger() ;
    }

    if (nn==27)if (vv==127) {
      stripTriggerIndex=3;
      animationStripTrigger() ;
    }

    if (nn==28)if (vv==127) {
      stripTriggerIndex=4;
      animationStripTrigger() ;
    }

    if (nn==29)if (vv==127) {
      stripTriggerIndex=5;
      animationStripTrigger() ;
    }

    if (nn==30)if (vv==127) {
      stripTriggerIndex=6;
      animationStripTrigger() ;
    }

    if (nn==31)if (vv==127) {
      stripTriggerIndex=7;
      animationStripTrigger() ;
    }
  }


  if (nn==105)if (vv==127)holdVertex=true;
  else holdVertex=false;

  if (nn==106)if (vv==127)autoCam(true);
  else autoCam(false);

  if (nn==110)if (vv==127)autoBg(true);
  else autoBg(false);

  if (nn==112)if (vv==127)autoBlend(true);
  else autoBlend(false);

  if (nn==113)if (vv==127)l3Sw(true);
  else l3Sw(false);

  if (nn==115)if (vv==127)l3Rt(true);
  else l3Rt(false);
}


void sendCtl2p5() {
  //-----------------------------
  if (nr==40) layer[4]=vl;
  if (nr==41) chColumnThreshold=int(map(vl, 0, 255, 0, 10));
  if (nr==42) chColumnSpeed =int(map(vl, 0, 255, 40, 2));
  if (nr==43) ColumnNum =int(map(vl, 0, 255, 2, 580));
  //-----------------------------
  if (nr==20) layer[2]=vl;
  if (nr==21) showLine=int(vl);
  if (nr==22) showEarParticle=int(vl);
  if (nr==23) showEyeParticle=int(vl);
  //-----------------------------
  if (nr==60) layer[6]=vl;
  if (nr==61) ctl61=vl;
  if (nr==62) ctl62=vl;
  if (nr==63) {
    if (vl>125)anim_dir=-1;
    else anim_dir=1;
  }
  //-----------------------------

  if (nr==30) layer[3]=vl;
  if (nr==31) showCylinder=vl;
  if (nr==32) ctl32=vl;
  if (nr==33) ctl33=vl;

  if (nr==50) layer[5]=vl;
  if (nr==51) ctl51=map(vl, 0, 255, 1, 2);

  if (nr==70) layer[7]=vl;
  if (nr==71) {
    blendIndex=int(map(vl, 0, 255, 0, 10));
  }
  if (nr==72) {
    imgIndex=int(map(vl, 0, 255, 0, 7));
    blendGLSL.set( "lowLayer", bgs [imgIndex]);
  }

  if (nr==73) {
    countWhiteAdd=int(map(vl, 0, 255, 0, 50));
  }
  //------------logo
  if (nr==80) layer[8]=vl;
  if (nr==81) pp=int(map(vl, 0, 255, 0, 14));
  if (nr==82) ctl82=(map(vl, 0, 255, 0.3, 4));
  if (nr==83) ctl83=map(vl, 0, 255, 0.55, 2);

  //------------
  if (nr==10) layer[1]=vl;
  if (nr==11) contrastA=vl/255;
  if (nr==12) contrastB=vl/255;
  if (nr==13) Falloff=map(vl, 0, 255, 1, 3);
  //------------
}

void controllerChange(ControlChange change) {
  nr=change.number();
  vl=change.value()*2;
  sendCtl2p5();
}


void noteOn(Note note) {
  pi=note.pitch();
  vel=note.velocity();
  ch=note.channel()+1;
  myBus.sendNoteOn(note.channel(), note.pitch(), note.velocity());
  notes[note.pitch()]=note.velocity();
  sendNote2p5();
}

void noteOff(Note note) {
  pi=note.pitch();
  vel=note.velocity();
  ch=note.channel()+1;
  myBus.sendNoteOff(note.channel(), note.pitch(), note.velocity());

  if (notes[note.pitch()]==127) {
    notes[note.pitch()]=note.velocity();
    sendNote2p5();
  }
  //println("off", note.channel(), note.pitch(), note.velocity());
}