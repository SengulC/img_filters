// MAIN SETUP AND DRAW/REDRAW CODE

PImage centreImg, centreImgMenuCopy, originalImg, originalImgMenuCopy;
int imgDimensions = 700;
boolean brushFlag, drawImgFlag;
Particle[] brushStrokes;
File saveFolder;
int sizeOfFolder;
PGraphics menu;
boolean toRenderMenu = true;

void setup() {
  size (700, 800);
  frameRate(60);

  menu = createGraphics(700, 100);

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
    if (drawImgFlag) {
      image(centreImg, 0, 0);
    }
    if (toRenderMenu) {
      drawMenu();
      image(menu, 0, 700);
      toRenderMenu = false;
    }
  }
}

void drawMenu() {
  noLoop();
  redraw();
  print("hi");
  menu.beginDraw();
  centreImgMenuCopy.resize(0, 100);
  originalImgMenuCopy.resize(0, 100); // - REMEBEER TO RESIZE IMAGE BACK IF NEEDED
  centreImgMenuCopy.loadPixels();

  // filter 1
  rgbScan(centreImgMenuCopy, "r");
  menu.image(centreImgMenuCopy, 0, 0);

  // filter 2
  centreImgMenuCopy = originalImgMenuCopy.copy();
  centreImgMenuCopy = basicToonShade(centreImgMenuCopy, posterizelvl);
  menu.image(centreImgMenuCopy, 100, 0);

  // filter 3
  centreImgMenuCopy = originalImgMenuCopy.copy();
  centreImgMenuCopy = laplacianEdgeDetection(centreImgMenuCopy);
  menu.image(centreImgMenuCopy, 200, 0);

  // filter 4
  centreImgMenuCopy = originalImgMenuCopy.copy();
  centreImgMenuCopy = thresholding(centreImgMenuCopy, false, 125);
  menu.image(centreImgMenuCopy, 300, 0);

  // filter 5
  centreImgMenuCopy = originalImgMenuCopy.copy();
  centreImgMenuCopy = halftoning(centreImgMenuCopy, 100);
  menu.image(centreImgMenuCopy, 400, 0);

  // filter 6
  centreImgMenuCopy = originalImgMenuCopy.copy();
  centreImgMenuCopy = grayscale(centreImgMenuCopy, 3);
  menu.image(centreImgMenuCopy, 500, 0);

  // filter 7
  centreImgMenuCopy = originalImgMenuCopy.copy();
  centreImgMenuCopy = invert(centreImgMenuCopy);
  menu.image(centreImgMenuCopy, 600, 0);

  // reset
  centreImgMenuCopy = originalImgMenuCopy.copy();
  menu.endDraw();
}
