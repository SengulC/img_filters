// FILTER FUNCTIONS //<>// //<>//

//void subtract (PImage img1, PImage img2) {
//  PImage outputImg = createImage(imgDimensions, imgDimensions, RGB);
//  for (int i=0; i<outputImg.pixels.length; i++) {
//    outputImg[i] = img1[i] - img2[i];
//  }
//}

PImage basicToonShade(PImage img) {
  PImage outputImg = createImage(imgDimensions, imgDimensions, RGB);
  PImage blurredImg = img.copy();
  blurredImg.filter(BLUR, 2);
  PImage slightlyBlurredImg = img.copy();
  slightlyBlurredImg.filter(BLUR, 0.7);
  PImage edgedImg = laplacianEdgeDetection(slightlyBlurredImg);
  PImage posterizedImg = posterize(blurredImg, 6);

  for (int x = 0; x < img.width; x++) {
    for (int y = 0; y < img.height; y++) {
      float edge = edgedImg.get(x, y);
      color post = posterizedImg.get(x, y);
      outputImg.set(x, y, color(
        // no under/overflow
        constrain(red(post) + edge, 20, 175),
        constrain(green(post) + edge, 20, 175),
        constrain(blue(post)  + edge, 20, 175)
        ));
    }
  }
  outputImg.updatePixels();
  return outputImg;
}

PImage posterize(PImage img, int levels) {
  PImage outputImg = img.copy();
  outputImg.loadPixels();
  float factor = 255.0/(levels - 1);
  for (int i=0; i < outputImg.pixels.length; i++) {
    color c = img.pixels[i];
    float r = round(red(c)/factor)*factor;
    float g = round(green(c)/factor)*factor;
    float b = round(blue(c)/factor)*factor;
    outputImg.pixels[i] = color(r, g, b);
  }
  outputImg.updatePixels();
  return outputImg;
}

float laplac8(PImage im, int x, int y)
{
  return abs(brightness(im.get (x, y))
    - (float)(
    brightness(im.get(x+1, y))
    + brightness(im.get(x-1, y))
    + brightness(im.get(x, y+1))
    + brightness(im.get(x, y-1))
    + brightness(im.get(x+1, y+1))
    + brightness(im.get(x-1, y-1))
    + brightness(im.get(x-1, y+1))
    + brightness(im.get(x+1, y-1))
    )/8.0);
}

PImage laplacianEdgeDetection(PImage img) {
  PImage outputImg = createImage(imgDimensions, imgDimensions, RGB);

  for (int i=0; i<img.width; i++) {
    for (int j=0; j<img.height; j++) {
      outputImg.set(i, j, color(laplac8(img, i, j)));
    }
  }

  // threshold and invert
  outputImg = invert(outputImg);
  outputImg = thresholding(outputImg, false, 225);
  return outputImg;
}

PImage halftoning (PImage img, int outputDim) {
  PImage tempImg = img.copy(); // create copy of img to enlarge
  tempImg.resize(imgDimensions, imgDimensions);
  tempImg.loadPixels();
  // create output img to edit pixels on and return
  PImage outputImg = createImage(imgDimensions*2, imgDimensions*2, RGB);

  // iterate over original image dimensions in tempImg, but write to outputImg with enlarged workspace
  for (int x=0; x < imgDimensions; x++) {
    for (int y=0; y < imgDimensions; y++) {
      color curPixel = tempImg.get(x, y);
      if (brightness(curPixel) > 200) {
        outputImg.set(x*2, y*2, color(255));
        outputImg.set(x*2+1, y*2, color(255));
        outputImg.set(x*2, y*2+1, color(255));
        outputImg.set(x*2+1, y*2+1, color(255));
      } else if (200 > brightness(curPixel) && brightness(curPixel)> 150) {
        outputImg.set(x*2, y*2, color(0));
        outputImg.set(x*2+1, y*2, color(255));
        outputImg.set(x*2, y*2+1, color(255));
        outputImg.set(x*2+1, y*2+1, color(255));
      } else if (150 > brightness(curPixel) && brightness(curPixel) > 100) {
        outputImg.set(x*2, y*2, color(0));
        outputImg.set(x*2+1, y*2, color(255));
        outputImg.set(x*2, y*2+1, color(0));
        outputImg.set(x*2+1, y*2+1, color(255));
      } else if (100 > brightness(curPixel) && brightness(curPixel) > 50) {
        outputImg.set(x*2, y*2, color(0));
        outputImg.set(x*2+1, y*2, color(0));
        outputImg.set(x*2, y*2+1, color(255));
        outputImg.set(x*2+1, y*2+1, color(0));
      } else {
        outputImg.set(x*2, y*2, color(0));
        outputImg.set(x*2+1, y*2, color(0));
        outputImg.set(x*2, y*2+1, color(0));
        outputImg.set(x*2+1, y*2+1, color(0));
      }
    }
  }

  // size output img back down
  outputImg.resize(0, outputDim);
  return outputImg;
}

PImage thresholding(PImage img, boolean multi, float T) {
  PImage out = new PImage(img.width, img.height, RGB);
  img.loadPixels();
  if (!multi) {
    for (int i=0; i< img.pixels.length; i++) {
      if (brightness(img.pixels[i]) > T)
        out.pixels[i] = color(255);
      else
        out.pixels[i] = color(0);
    }
  } else {
    for (int i=0; i< img.pixels.length; i++) {
      color curPixel = img.pixels[i];
      if (brightness(curPixel) > 200) {
        curPixel = color(255);
      } else if (brightness(curPixel) > 150) {
        curPixel = color(200);
      } else if (brightness(curPixel) > 100) {
        curPixel = color(150);
      } else if (brightness(curPixel) > 50) {
        curPixel = color(50);
      } else {
        curPixel = color(0);
      }
      out.pixels[i] = curPixel;
    }
  }
  out.updatePixels();
  return out;
}

void rgbScan (PImage img, String rgb) {
  color newColor = color(0, 0, 0);
  img.loadPixels();
  for (int i=0; i< img.pixels.length; i++) {
    switch(rgb) {
    case "r" :
      newColor = color (red(img.pixels[i]), 0, 0);
      break;
    case "g" :
      newColor = color (0, green(img.pixels[i]), 0);
      break;
    case "b" :
      newColor = color (0, 0, blue(img.pixels[i]));
      break;
    }
    img.pixels[i] = newColor;
  }
  img.updatePixels();
}

PImage grayscale (PImage img, int degree) {
  img.loadPixels();
  PImage out = new PImage(img.width, img.height, RGB);
  for (int i=0; i< img.pixels.length; i++) {
    float grayVal = (red(img.pixels[i]) + green(img.pixels[i]) + blue(img.pixels[i]))/degree;
    out.pixels[i] = color(grayVal, grayVal, grayVal);
  }
  out.updatePixels();
  return out;
}

PImage invert (PImage img) {
  img.loadPixels();
  PImage out = new PImage(img.width, img.height, RGB);
  for (int i=0; i< img.pixels.length; i++) {
    out.pixels[i] = color(255-red(img.pixels[i]), 255-green(img.pixels[i]), 255 - blue(img.pixels[i]));
  }
  out.updatePixels();
  return out;
}
