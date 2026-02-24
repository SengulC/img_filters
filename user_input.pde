// USER INPUT VIA KEYBOARD AND MOUSE
// SAVING/LOADING NEW IMAGE
// CHANGING FILTERS VIA MENU CLICK
int threshold = 125, grayval = 3, posterizelvl = 3;
boolean multithreshold;
String[] rgbvals = {"r", "g", "b"};
int rgbindex = 0;

void mousePressed() {
  // if in y region of menu
  loop();

  if (mouseY > 700) {
    centreImg = originalImg.copy();
    if (mouseX < 100) {
      //filter1
      rgbScan(centreImg, rgbvals[rgbindex]);
      image(centreImg, 0, 0);
      rgbindex++;
      if (rgbindex == 3)
        rgbindex = 0;
    } else if (mouseX < 200) {
      //filter2
      centreImg = basicToonShade(centreImg, posterizelvl);
      image(centreImg, 0, 0);
      posterizelvl++;
      if (posterizelvl>15)
        posterizelvl = 3;
    } else if (mouseX < 300) {
      //filter3
      centreImg = laplacianEdgeDetection(centreImg);
      image(centreImg, 0, 0);
    } else if (mouseX < 400) {
      //filter4
      centreImg = thresholding(centreImg, multithreshold, threshold);
      image(centreImg, 0, 0);
      threshold+=10;
      if (threshold > 200)
        multithreshold = true;
    } else if (mouseX < 500) {
      //filter5
      centreImg = halftoning(centreImg, imgDimensions);
      image(centreImg, 0, 0);
    } else if (mouseX < 600) {
      //filter6
      centreImg = grayscale(centreImg, grayval);
      image(centreImg, 0, 0);
      grayval++;
      if (grayval > 6)
        grayval = 3;
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
  brushFlag = true;
  centreImg = loadImage(newImg);
  centreImgMenuCopy = loadImage(newImg);
  originalImg = loadImage(newImg);
  originalImgMenuCopy = loadImage(newImg);
  centreImg.resize(0, 700);
  originalImg.resize(0, 700);
  drawImgFlag = true;
  threshold = 125;
  grayval = 3;
  posterizelvl = 3;
  multithreshold = false;
  redraw();
}
