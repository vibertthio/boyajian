float a1;
float a2;
float a3;
float a4;

float rotX=0;
float rotY=0;

float camX=600;
float camY=200;
float camZ=430;

float easing = 0.05;
boolean resetCamDo=false;
float[] cam={600, 200, 430, 0, 0};

void s3dDrawing() {
  a1=(a1+1)%360;
  a2=(a1+1)%180;
  a3=(a1+1)%150;

  s3d.beginDraw();
  s3d.background(255, 0);
  {
    s3d.setMatrix(getMatrix()); // replace the PGraphics-matrix

    s3d.lightFalloff(1.80, 0.001, 0.000);
    s3d.directionalLight(255, 256, 255, 0, -100, -300);
    s3d.pointLight(255, 255, 255, 300, 200, 300);
    s3d.ambientLight(50, 50, 50);

    s3d.beginCamera();
    s3d.camera( camX + camZ*sin(rotX), camY + camZ*sin(rotY), camZ*cos(rotY)*cos(rotX), camX, camY, 0, 0, 1, 0);
    println(rotX, rotY, camX, camY, camZ);
    s3d.endCamera();

    if (resetCamDo==true)resetCam(cam[0], cam[1], cam[2], cam[3], cam[4]);

    if (mousePressed) {
      s3d.stroke(255, 0, 0);
      s3d.strokeWeight(2);
      s3d.line(width/2, height/2, 0, width/2+200, height/2, 0);
      s3d.stroke(0, 255, 0);
      s3d.line(width/2, height/2, 0, width/2, height/2-200, 0);
      s3d.stroke(0, 0, 255);
      s3d.line(width/2, height/2, 0, width/2, height/2, 200);
      s3d.pushMatrix();
      s3d.stroke(255);
      s3d.translate(width/2, height/2, 0);
      s3d.sphere(5);
      s3d.popMatrix();
    }
  }
  GL2 gl = ((PJOGL)beginPGL()).gl.getGL2();
  gl.glEnable(GL2.GL_BLEND);
  gl.glBlendFunc(GL2.GL_SRC_ALPHA, GL2.GL_ONE_MINUS_SRC_ALPHA);

  gl.glHint( GL2.GL_POLYGON_SMOOTH_HINT, GL2.GL_NICEST );
  gl.glEnable(GL2.GL_ALPHA_TEST);
  gl.glAlphaFunc(GL2.GL_GREATER, 0.1);
  endPGL();

  if (showMaskEye==true) {
    maskEyedrawing();
  }

  if (showMaskListen==true) {
    maskListendrawing();
  }

  if (showMaskSmell==true) {
    maskSmelldrawing();
  }

  if (showMaskTouch==true) {
    maskTouchdrawing();
  }

  s3d.pushMatrix();
  s3d.noStroke();
  s3d.translate(width/2, height/2);
  s3d.rotateY(radians(287));
  s3d.shape(globe);
  s3d.popMatrix();

  s3d.endDraw();
}