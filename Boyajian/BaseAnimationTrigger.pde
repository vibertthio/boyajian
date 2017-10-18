int animationRotateGridTriggerIndex = 0;
void animationRotateGridTrigger() {
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

  layer[6] = 220;
  println("Rotate Grid Animation ## " + animationRotateGridTriggerIndex);
  switch(animationRotateGridTriggerIndex) {
    case 0:
      animations.rotateGrid.allAngleShiftBang();
      break;
    case 1:
      animations.rotateGrid.allAngleShiftBang(8);
      break;
    case 2:
      animations.rotateGrid.allStretchBang();
      break;
    case 3:
      animations.rotateGrid.allStretchBang(10);
      break;
    case 4:
      animations.rotateGrid.allStretchBang();
      break;
    case 5:
      animations.rotateGrid.allColorBang();
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
      animations.rotateGrid.colAngleShiftBang(7);
      break;
  }
  animationRotateGridTriggerIndex ++;
  animationRotateGridTriggerIndex %= 13;
}

int animationGrowGridTriggerIndex = 0;
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

  layer[6] = 30;
  println("Grow Grid Animation ## " + animationGrowGridTriggerIndex);
  switch(animationGrowGridTriggerIndex) {
    case 0:
      animations.growGrid.allSizeBang();
      break;
    case 1:
      animations.growGrid.allVibrateBang();
      break;
    case 2:
      animations.growGrid.allRotateBang();
      break;
    case 3:
      animations.growGrid.allRotateBang(4);
      break;
    case 4:
      animations.growGrid.allBlinkBang();
      break;
    case 5:
      animations.growGrid.allXShiftBang();
      break;
    case 6:
      animations.growGrid.allYShiftBang();
      break;
    case 7:
      animations.growGrid.rowSizeBang(2);
      break;
    case 8:
      animations.growGrid.colAngleShiftBang(5);
      break;
    case 9:
      animations.growGrid.rotateSequence.bang(floor(random(2)));
      break;
    case 10:
      animations.growGrid.sizeSequence.bang(floor(random(2)));
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
  animationGrowGridTriggerIndex++;
  animationGrowGridTriggerIndex %= 13;
}

void testAnimation() {
  animations.rotateGrid.rowRotateSequence.bang(4);
  animations.rotateGrid.rowXShiftSequence.bang(4);
  // animations.rotateGrid.rowBlinkSequence.bang(4);
}
