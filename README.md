<h1>Image Filters via Pixel Manipulation</h1>

_Written in Processing/Java_

Play around @ [sengulc.itch.io/image-filters](https://sengulc.itch.io/image-filters)

<h2>Filters</h2>
RGB filtering

    Preserve only R/G/B channel
    Interaction: cycle through R/G/B filtering 

Basic toon shade: posterize + edge detection

    Simple attempt at a toon shader. 
    I blur the posterized image to create a softer look, and ever so slightly blur the edge so that random/anomalous edges don’t stick out too much.
    Then I add the pixel color values of these two images to create the toon look.
    Interaction: cycle through posterize levels 

Posterize with levels

    Reduce color depth by constraining RGB channels via given level 

Edge detection

    Laplacian function with 8 neighbors 

Grayscale with intensity 

    Divide color value by intensity
    Interaction: cycle through intensity 

Invert

    Subtract RGB channels from 255.0 

Threshold (single or multi level)

    For single, use threshold to set pixels with brightnesses below to black and above to white
    For multi, use multiple thresholds to set to black, white (as above) and shades of gray for values in between
    Interaction: cycle through single-threshold levels then end and stay on multithreshold 

Halftoning

    Used above multi thresholding algorithm to render patterns of 2x2 pixels
    In order to do this, I doubled my ‘working space’ with the image, recorded my halftoned patterns into an output image of that double-size as well
    Then, I returned the output image sized down 
