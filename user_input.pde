// USER INPUT VIA KEYBOARD AND MOUSE
// SAVING/LOADING NEW IMAGE
// CHANGING FILTERS VIA MENU CLICK

void mousePressed() {
  // if in y region of menu
  if (mouseY > 700) {
    centreImg = originalImg.copy();
    loop();
    if (mouseX < 100) {
      //filter1
      rgbScan(centreImg, "r");
      image(centreImg, 0, 0);
    } else if (mouseX < 200) {
      //filter2
      centreImg = basicToonShade(centreImg);
      image(centreImg, 0, 0);
    } else if (mouseX < 300) {
      //filter3
      centreImg = laplacianEdgeDetection(centreImg);
      image(centreImg, 0, 0);
    } else if (mouseX < 400) {
      //filter4
      centreImg = thresholding(centreImg, false, 125);
      image(centreImg, 0, 0);
    } else if (mouseX < 500) {
      //filter5
      centreImg = halftoning(centreImg, imgDimensions);
      image(centreImg, 0, 0);
    } else if (mouseX < 600) {
      //filter6
      centreImg = grayscale(centreImg, 3);
      image(centreImg, 0, 0);
    } else if (mouseX < 700) {
      //filter7
      centreImg = invert(centreImg);
      image(centreImg, 0, 0);
    }
  }
}

void keyPressed() {
  if (key == 'p' || key == 'P') {
    brushFlag = true;
    redraw();
  }

  if (key == TAB) {
    brushFlag = false;
    image(centreImg, 0, 0);
  }

  if (key == ENTER || key == RETURN) {
    PImage capture = get(0, 0, imgDimensions*2, imgDimensions*2);
    // getting length of saveFolder to not overwrite any prev. captures
    if (saveFolder.exists() && saveFolder.isDirectory()) {
      sizeOfFolder = saveFolder.listFiles().length;
    }
    capture.save("./data/savedImages/filtered-img"+sizeOfFolder+".jpg");
  }

  if (key == BACKSPACE) {
    //brushFlag = false;
    selectInput("Select a file to process:", "fileSelected");
  }
}

void fileSelected(File selection) {
  if (selection == null) {
    print("Window was closed or the user hit cancel.");
  } else {
    String newImgPath = selection.getAbsolutePath();
    updateImages(newImgPath);
  }
}

void updateImages(String newImg) {
  centreImg = loadImage(newImg);
  centreImgMenuCopy = loadImage(newImg);
  originalImg = loadImage(newImg);
  originalImgMenuCopy = loadImage(newImg);
  centreImg.resize(0, 700);
  originalImg.resize(0, 700);
  drawImgFlag = true;
  redraw();
}
