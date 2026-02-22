// USER INPUT VIA KEYBOARD AND MOUSE
// SAVING/LOADING NEW IMAGE
// CHANGING FILTERS VIA MENU CLICK

void mousePressed() {
  // if in y region of menu
  if (mouseY > 700) {
    if (mouseX < 100) {
      //filter1();
      print(1);
    }
    else if (mouseX < 200) {
      //filter2();
      print(2);
    }
    else if (mouseX < 300) {
      //filter3();
      print(3);
    }
    else if (mouseX < 400) {
      //filter4();
      print(4);
    }
    else if (mouseX < 500) {
      //filter5();
      print(5);
    }
    else if (mouseX < 600) {
      //filter6();
      print(6);
    }
    else if (mouseX < 700) {
      //filter7();
      print(7);
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
  centreImg.resize(0, 700);
  drawImgFlag = true;
  redraw();
}
