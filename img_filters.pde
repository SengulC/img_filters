PImage centreImg, centreImgMenuCopy, originalImg;
int x, y, i, j;
int imgDimensions = 700;
boolean brushFlag, drawImgFlag;
Particle[] brushStrokes;

void setup() {
  size (700, 800);
  centreImg = loadImage("challengers.jpg"); // for the brushStroke and later application of filters - the central image
  centreImgMenuCopy = loadImage("challengers.jpg"); // for the menu thumbnails
  originalImg = loadImage("challengers.jpg"); // for keeping a record of original image pixels - reset filters
  centreImg.resize(0, 700);

  // particle setup
  brushStrokes = new Particle[30];
  for (int i=0; i<30; i++)
  {
    brushStrokes[i] = new Particle(300, 200, random(-10, 10), random(-10, 10), 10, color(255));
  }

  brushFlag = true; // SET ME TO FALSE FOR FASTER RENDERING
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
    //brushStrokeRender();
    for (int i=0; i<30; i++)
    {
      brushStrokes[i].render();
      brushStrokes[i].update();
    }
  } else {
    noLoop();
    if (drawImgFlag) {
      //centreImg = halftoning(centreImg, imgDimensions);
      image(centreImg, 0, 0);
    }
    drawMenu();
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
  centreImgMenuCopy = halftoning(centreImgMenuCopy, 100);
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
