void thresholding(PImage img, boolean multi, int T) {
  img.loadPixels();
  if (!multi) {
    for (int i=0; i< img.pixels.length; i++) {
      if (brightness(img.pixels[i]) > T)
        img.pixels[i] = color(255);
      else
        img.pixels[i] = color(0);
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
      img.pixels[i] = curPixel;
    }
    img.updatePixels();
  }
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
