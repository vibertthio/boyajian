//VisualColumn.pde
int ColumnNum=600;
int settingColumnNum=ColumnNum;
int chColumnImg=0;
int chColumnSpeed=20;

float[] ColumnShow=new float[ColumnNum];
float chColumnThreshold=5;
float ColumnWidth;


void visualColumnDrawing() {

  if (frameCount%10==0) {
    settingColumnNum=ColumnNum;
    ColumnWidth=float(width)/float(settingColumnNum);
  }


  columnImg.beginDraw();
  columnImg.background(255,0);
  columnImg.rectMode(CENTER);


  if (frameCount%chColumnSpeed==0) {
    for (int i=0; i<settingColumnNum; i++) {
      ColumnShow[i]=random(10);
    }

    int k=int(random(2));
    if (k==0) ptnRo=90;
    else ptnRo=0;
  }

  if (frameCount%(chColumnSpeed*2)==0) chColumnImg=int(random(15));
  columnImg.blendMode(ADD);
  columnImg.pushMatrix();
  columnImg.translate(width/2+(width/4), height/2);
  columnImg.rotate(radians(ptnRo));
  columnImg.imageMode(CENTER);
  //columnImg.image(pattern[chColumnImg], 0, 0, width/2, width/2);
  columnImg.popMatrix();

  columnImg.pushMatrix();
  columnImg.translate(width/2-(width/4), height/2);
  columnImg.rotate(-1*radians(ptnRo));
  columnImg.imageMode(CENTER);
  //columnImg.image(pattern[chColumnImg], 0, 0, width/2, width/2);
  columnImg.popMatrix();

  columnImg.blendMode(BLEND);
  for (int i=0; i<settingColumnNum; i++) {
    if (ColumnShow[i]>chColumnThreshold) {
      columnImg.fill(0, 255);
      columnImg.rect(posAvg(width, settingColumnNum, i), height/2, ColumnWidth, height);
    }
  }

  columnImg.endDraw();
  
  imageMode(CENTER);
  blendMode(BLEND);
  tint(255, layer[4]);
  image(columnImg, width/2, height/2, width, height);
}