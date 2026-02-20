PImage centreImg, centreImgMenuCopy, originalImg;
int x, y, i, j;
int imgDimensions = 700;
boolean brushFlag, drawImgFlag;

void setup() {
  size (700, 800);
  centreImg = loadImage("challengers.jpg"); // for the brushStroke and later application of filters - the central image
  centreImgMenuCopy = loadImage("challengers.jpg"); // for the menu thumbnails
  originalImg = loadImage("challengers.jpg"); // for keeping a record of original image pixels - reset filters
  centreImg.resize(0, 700);

  brushFlag = false; // SET ME TO FALSE FOR FASTER RENDERING
  if (!brushFlag)
    drawImgFlag = true; // FOR TESTING PURPOSES
  if (brushFlag) {
    frameRate(1080);
    x=0; // x,y, pointers going from left-top
    i=imgDimensions; // i,j pointers going from right-btm
    y=10;
    j=imgDimensions-10;
  }
}

void draw() {
  if (brushFlag) {
    brushStrokeRender();
  } else {
    if (drawImgFlag) {
      centreImg = halftoning(centreImg);
      //thresholding(centreImg, false, 125);
      image(centreImg, 0, 0);
    }
    drawMenu();
  }
}

void brushStrokeRender() {
  if (j < y-20) { // once two pointers roughly meet turn this rendering off
    brushFlag = false;
  }

  noStroke();
  float randomDia = random(5, 30);

  color cStart = centreImg.get(x, y);
  fill(cStart);
  circle(x, y, randomDia);

  color cEnd = centreImg.get(i, j);
  fill(cEnd);
  circle(i, j, randomDia);

  x++;
  i--;

  if (x == imgDimensions) {
    x=0;
    y+=15; // has to be big enough to continue off of circle drawn on prev line
  }
  if (i == 0) {
    i=imgDimensions;
    j-=15;
  }
}

void keyPressed() {
  if (key == TAB) {
    brushFlag = false;
    image(centreImg, 0, 0);
  }
  if (key == ENTER || key == RETURN) {
    PImage capture = get(0, 0, imgDimensions*2, imgDimensions*2);
    int code = 0;
    capture.save("filtered-img"+code+".jpg");
    code++;
  }
  if (key == BACKSPACE) {
    brushFlag = false;
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

void drawMenu() {
  noLoop();
  //clear();
  centreImgMenuCopy.resize(0, 100);
  originalImg.resize(0, 100); // - REMEBEER TO RESIZE IMAGE BACK IF NEEDED

  // filter 1
  rgbScan(centreImgMenuCopy, "r");
  image(centreImgMenuCopy, 0, imgDimensions);

  // filter 2
  centreImgMenuCopy = originalImg.copy();
  rgbScan(centreImgMenuCopy, "g");
  image(centreImgMenuCopy, 100, imgDimensions);

  // filter 3
  centreImgMenuCopy = originalImg.copy();
  rgbScan(centreImgMenuCopy, "b");
  image(centreImgMenuCopy, 200, imgDimensions);

  // filter 4
  centreImgMenuCopy = originalImg.copy();
  thresholding(centreImgMenuCopy, false, 125);
  image(centreImgMenuCopy, 300, imgDimensions);

  // filter 5
  centreImgMenuCopy = originalImg.copy();
  centreImgMenuCopy.filter(BLUR);
  image(centreImgMenuCopy, 400, imgDimensions);

  // filter 6
  centreImgMenuCopy = originalImg.copy();
  grayscale(centreImgMenuCopy, 3);
  image(centreImgMenuCopy, 500, imgDimensions);

  // filter 7
  centreImgMenuCopy = originalImg.copy();
  invert(centreImgMenuCopy);
  image(centreImgMenuCopy, 600, imgDimensions);
}
