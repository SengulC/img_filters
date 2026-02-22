//void subtract (PImage img1, PImage img2) {
//  PImage outputImg = createImage(imgDimensions, imgDimensions, RGB);
//  for (int i=0; i<outputImg.pixels.length; i++) {
//    outputImg[i] = img1[i] - img2[i];
//  }
//}

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

PImage thresholding(PImage img, boolean multi, int T) {
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
    case "r":
      newColor = color (red(img.pixels[i]), 0, 0);
      break;
    case "g":
      newColor = color (0, green(img.pixels[i]), 0);
      break;
    case "b":
      newColor = color (0, 0, blue(img.pixels[i]));
      break;
    }
    img.pixels[i] = newColor;
  }
  img.updatePixels();
}

void grayscale (PImage img, int degree) {
  img.loadPixels();
  for (int i=0; i< img.pixels.length; i++) {
    float grayVal = (red(img.pixels[i]) + green(img.pixels[i]) + blue(img.pixels[i]))/degree;
    img.pixels[i] = color(grayVal, grayVal, grayVal);
  }
  img.updatePixels();
}

void invert (PImage img) {
  for (int i=0; i< img.pixels.length; i++) {
    img.pixels[i] = color(255-red(img.pixels[i]), 255-green(img.pixels[i]), 255 - blue(img.pixels[i]));
  }
}
