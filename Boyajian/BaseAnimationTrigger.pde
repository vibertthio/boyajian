int rotateGridTriggerIndex = 0;
int growGridTriggerIndex = 0;
int stripTriggerIndex = 0;
void animationRotateGridTrigger() {
  // animations.rotateGrid.adjustSpeed(5);
  // animations.rotateGrid.adjustSpeed(-3);
  // animations.rotateGrid.allAngleShiftBang();
  // animations.rotateGrid.allAngleShiftBang(8);
  // animations.rotateGrid.allStretchBang();
  // animations.rotateGrid.allStretchBang(10);
  // animations.rotateGrid.allWidthBang();
  // animations.rotateGrid.allHeightBang(5);
  // animations.rotateGrid.allHeightBang(10);
  // animations.rotateGrid.allColorBang();
  // animations.rotateGrid.allXShiftBang();
  // animations.rotateGrid.allYShiftBang();
  // animations.rotateGrid.allVibrateBang();
  // animations.rotateGrid.allBlinkBang();

  // animations.rotateGrid.rowAngleShiftBang(4);
  // animations.rotateGrid.rowAngleShiftBang(5);
  // animations.rotateGrid.colAngleShiftBang(5);
  // animations.rotateGrid.colAngleShiftBang(4);
  // animations.rotateGrid.rowRotateSequence.bang(3);
  // animations.rotateGrid.rowXShiftSequence.bang(4);
  // animations.rotateGrid.rowBlinkSequence.bang(4);

  layer[3] = 0;
  layer[6] = 220;
  println("Rotate Grid Animation ## " + rotateGridTriggerIndex);
  switch(rotateGridTriggerIndex) {
    case 0:
      animations.rotateGrid.allBlinkBang();
      break;
    case 1:
      animations.rotateGrid.allStretchBang(10);
      animations.rotateGrid.allColorBang();
      // animations.rotateGrid.allAngleShiftBang(8);
      break;
    case 2:
      animations.rotateGrid.rowColorSequence.bang(2);
      animations.rotateGrid.allStretchBang();
      break;
    case 3:
      animations.rotateGrid.rowRotateSequence.bang(3);
      animations.rotateGrid.rowStretchSequence.bang(3);
      break;
    case 4:
      animations.rotateGrid.allStretchBang();
      // animations.rotateGrid.allAngleShiftBang(4);
      break;
    case 5:
      animations.rotateGrid.allAngleShiftBang();
      break;
    case 6:
      animations.rotateGrid.allXShiftBang();
      break;
    case 7:
      animations.rotateGrid.allYShiftBang();
      break;
    case 8:
      animations.rotateGrid.allXShiftBang();
      animations.rotateGrid.allYShiftBang();
      break;
    case 9:
      animations.rotateGrid.allVibrateBang();
      break;
    case 10:
      animations.rotateGrid.allBlinkBang();
      break;
    case 11:
      animations.rotateGrid.rowAngleShiftBang(5);
      break;
    case 12:
      animations.rotateGrid.rowRotateSequence.bang(3);
      // animations.rotateGrid.colAngleShiftBang(7);
      break;
  }
  rotateGridTriggerIndex ++;
  rotateGridTriggerIndex %= 8;
}
void animationGrowGridTrigger() {
  // animations.growGrid.allSizeBang();
  // animations.growGrid.allVibrateBang();
  // animations.growGrid.allRotateBang();
  // animations.growGrid.allRotateBang(4);
  // animations.growGrid.allBlinkBang();
  // animations.growGrid.allXShiftBang();
  // animations.growGrid.allYShiftBang();
  // animations.growGrid.rowYShiftBang(2);
  // animations.growGrid.rowSizeBang(2);
  // animations.growGrid.colAngleShiftBang(5);
  // animations.growGrid.allCordTrigger();
  // animations.growGrid.rotateSequence.bang(floor(random(2)));
  // animations.growGrid.sizeSequence.bang(floor(random(2)));
  layer[3] = 0;
  layer[6] = 30;
  smooth.oldOne= 60;
  println("Grow Grid Animation ## " + growGridTriggerIndex);
  switch(growGridTriggerIndex) {
    case 0:
      animations.growGrid.allBlinkBang();
      break;
    case 1:
      animations.growGrid.allSizeBang();
      // animations.growGrid.allBlinkBang();
      animations.growGrid.allXShiftBang();
      animations.growGrid.allRotateBang();
      animations.growGrid.colColorSequence.bang(1);
      break;
    case 2:
      animations.growGrid.rowColorSequence.bang(1);
      animations.growGrid.colRotateSequence.bang(1);
      animations.growGrid.rowSizeSequence.bang(1);
      break;
    case 3:
      animations.growGrid.allYShiftBang();
      animations.growGrid.allVibrateBang();
      break;
    case 4:
      animations.growGrid.allSizeBang();
      // animations.growGrid.allBlinkBang();
      break;
    case 5:
      animations.growGrid.allRotateBang(2);
      // animations.growGrid.allXShiftBang();
      break;
    case 6:
      animations.growGrid.allYShiftBang();
      // animations.growGrid.allYShiftBang();
      break;
    case 7:
      animations.growGrid.allXShiftBang();
      // animations.growGrid.rowSizeBang(2);
      break;
    case 8:
      animations.growGrid.colAngleShiftBang(5);
      break;
    case 9:
      animations.growGrid.colRotateSequence.bang(floor(random(2)));
      break;
    case 10:
      animations.growGrid.rowSizeSequence.bang(floor(random(2)));
      break;
    case 11:
      animations.growGrid.allBlinkBang();
      animations.growGrid.allXShiftBang();
      animations.growGrid.allRotateBang();
      break;
    case 12:
      animations.growGrid.allBlinkBang();
      animations.growGrid.allYShiftBang();
      animations.growGrid.allVibrateBang();
      break;
  }
  growGridTriggerIndex++;
  growGridTriggerIndex %= 8;
}
void animationStripTrigger() {
  layer[6] = 120;
  smooth.oldOne= 120;
  layer[3] = 200;

  // animations.stripsSystem.crStrips.angleShiftBang();
  // animations.stripsSystem.crStrips.widthScaleBang();
  // animations.stripsSystem.crStrips.heightScaleBang();
  // animations.stripsSystem.crStrips.yShiftBang();
  // animations.stripsSystem.crStrips.vibrateBang();
  // animations.stripsSystem.crStrips.blinkBang();
  // animations.stripsSystem.hrStart();
  // animations.stripsSystem.hrStart(0.8);
  // animations.stripsSystem.vtStart();
  // animations.stripsSystem.vtStart(0.9);
  // animations.stripsSystem.hrStartStep(-200);
  // animations.stripsSystem.vtStartStep(-200);
  // animations.stripsSystem.hrStart(0.8, -200);
  // animations.stripsSystem.hrStartStep(-200);
  // animations.stripsSystem.vtStart(0.9);
  println("Strips Animation ## " + stripTriggerIndex);
  switch(stripTriggerIndex) {
    case 0:
      animations.stripsSystem.vtStart(0.0, 200);
      animations.stripsSystem.hrStart(0.8, -200);
      animations.stripsSystem.hrStrips.heightScaleBang(10);
      animations.stripsSystem.vtStrips.heightScaleBang(5);
      animations.stripsSystem.crStrips.blinkBang();
      animations.stripsSystem.crStrips.heightScaleBang(10);
      break;
    case 1:
      animations.stripsSystem.hrStartStep(-200);
      animations.stripsSystem.hrStrips.heightScaleBang(10);
      animations.stripsSystem.crStrips.widthScaleBang(2);
      animations.stripsSystem.crStrips.heightScaleBang(4);
      animations.stripsSystem.crStrips.yShiftBang(-3);
      animations.stripsSystem.crStrips.angleShiftBang(-3);
      break;
    case 2:
      animations.stripsSystem.hrStartStep(-200);
      animations.stripsSystem.vtStartStep(-200);
      animations.stripsSystem.hrStrips.heightScaleBang(10);
      animations.stripsSystem.vtStrips.heightScaleBang(10);
      animations.stripsSystem.crStrips.heightScaleBang(5);
      animations.stripsSystem.crStrips.yShiftBang(-5);
      // animations.stripsSystem.crStrips.widthScaleBang(5);
      break;
    case 3:
      animations.stripsSystem.vtStart(0.7, 200);
      animations.stripsSystem.crStrips.yShiftBang();
      animations.stripsSystem.vtStrips.heightScaleBang(6);
      animations.stripsSystem.crStrips.heightScaleBang(6);
      break;
    case 4:
      // animations.stripsSystem.crStrips.blinkBang();
      animations.stripsSystem.crStrips.heightScaleBang(10);
      animations.stripsSystem.crStrips.yShiftBang(10);
      break;
    case 5:
      animations.stripsSystem.crStrips.angleShiftBang();
      animations.stripsSystem.crStrips.widthScaleBang(4);
      animations.stripsSystem.crStrips.heightScaleBang(8);
      break;
    case 6:
      animations.stripsSystem.crStrips.yShiftBang();
      // animations.stripsSystem.crStrips.setColors();
      break;
    case 7:
      animations.stripsSystem.crStrips.yShiftBang(6);
      // animations.stripsSystem.crStrips.angleShiftBang();
      // animations.stripsSystem.crStrips.widthScaleBang(4);
      // animations.stripsSystem.crStrips.heightScaleBang(8);
      break;
    case 8:
      animations.stripsSystem.crStrips.vibrateBang();
      animations.stripsSystem.crStrips.blinkBang();
      break;
    case 9:
      animations.stripsSystem.crStrips.setColors(color(255, 255, 255));
      animations.stripsSystem.crStrips.angleShiftBang();
      animations.stripsSystem.crStrips.yShiftBang();
      animations.stripsSystem.crStrips.widthScaleBang(4);
      animations.stripsSystem.crStrips.heightScaleBang(8);
      break;
    case 10:
      animations.stripsSystem.hrStart(0.8, -200);
      break;
    case 11:
      animations.stripsSystem.hrStart(0.8, -200);
      animations.stripsSystem.vtStart(0.7, 200);
      break;
    case 12:
      animations.stripsSystem.hrStartStep(-200);
      break;
    case 13:
      animations.stripsSystem.vtStartStep(-200);
      break;
    case 14:
      animations.stripsSystem.hrStartStep(-200);
      animations.stripsSystem.vtStartStep(-200);
      break;
  }
  stripTriggerIndex++;
  stripTriggerIndex %= 8;
}
void animationCircleTrigger() {
  animations.stripsSystem.crStrips.startMap();
}
