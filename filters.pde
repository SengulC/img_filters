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
