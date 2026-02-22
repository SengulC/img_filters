// MAIN SETUP AND DRAW/REDRAW CODE

PImage centreImg, centreImgMenuCopy, originalImg, originalImgMenuCopy;
int x, y, i, j;
int imgDimensions = 700;
boolean brushFlag, drawImgFlag;
Particle[] brushStrokes;
File saveFolder;
int sizeOfFolder;

void setup() {
  size (700, 800);

  String path = dataPath("savedImages/");
  saveFolder = new File(path);
  sizeOfFolder = 0;

  centreImg = loadImage("challengers.jpg"); // for the brushStroke and later application of filters - the central image
  centreImgMenuCopy = loadImage("challengers.jpg"); // for the menu thumbnails
  originalImg = loadImage("challengers.jpg"); // for keeping a record of original image pixels - reset filters
  originalImgMenuCopy = loadImage("challengers.jpg");
  centreImg.resize(0, 700);
  originalImg.resize(0, 700);

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
    loop();
    for (int i=0; i<30; i++)
    {
      brushStrokes[i].render();
      brushStrokes[i].update();
    }
  } else {
    noLoop();
    if (drawImgFlag) {
      image(centreImg, 0, 0);
    }
    drawMenu();
  }
}

void drawMenu() {
  centreImgMenuCopy.resize(0, 100);
  originalImgMenuCopy.resize(0, 100); // - REMEBEER TO RESIZE IMAGE BACK IF NEEDED
  centreImgMenuCopy.loadPixels();

  // filter 1
  rgbScan(centreImgMenuCopy, "r");
  image(centreImgMenuCopy, 0, imgDimensions);

  // filter 2
  centreImgMenuCopy = originalImgMenuCopy.copy();
  centreImgMenuCopy = basicToonShade(centreImgMenuCopy);
  image(centreImgMenuCopy, 100, imgDimensions);

  // filter 3
  centreImgMenuCopy = originalImgMenuCopy.copy();
  centreImgMenuCopy = laplacianEdgeDetection(centreImgMenuCopy);
  image(centreImgMenuCopy, 200, imgDimensions);

  // filter 4
  centreImgMenuCopy = originalImgMenuCopy.copy();
  centreImgMenuCopy = thresholding(centreImgMenuCopy, false, 125);
  image(centreImgMenuCopy, 300, imgDimensions);

  // filter 5
  centreImgMenuCopy = originalImgMenuCopy.copy();
  centreImgMenuCopy = halftoning(centreImgMenuCopy, 100);
  image(centreImgMenuCopy, 400, imgDimensions);

  // filter 6
  centreImgMenuCopy = originalImgMenuCopy.copy();
  grayscale(centreImgMenuCopy, 3);
  image(centreImgMenuCopy, 500, imgDimensions);

  // filter 7
  centreImgMenuCopy = originalImgMenuCopy.copy();
  centreImgMenuCopy = invert(centreImgMenuCopy);
  image(centreImgMenuCopy, 600, imgDimensions);

  // reset
  centreImgMenuCopy = originalImgMenuCopy.copy();
}
