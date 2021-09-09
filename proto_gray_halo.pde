/**
 * Creates two layers, and a brush, and draws a line in each layer.
 * Then, draw the two layers each time draw() is called.
 */
PGraphics layer1;
PGraphics layer2;
PGraphics brush1;

/**
 * Creates the two layers and the brush.
 */
void setup() {
  size(720, 720, P2D);
  layer1 = createLayer();
  layer2 = createLayer();
  brush1 = createBrush();
  // Fill each layer with a long diagonal stroke.
  final int spaceBetweenBrushes = 10;
  for (int x = 0; x < width; x += spaceBetweenBrushes) {
    int y = x;
    drawInLayer(layer1, brush1, x, y, color(255, 127, 0, 255));
  }
  for (int x = 0; x < width; x += spaceBetweenBrushes) {
    int y = height - x;
    drawInLayer(layer2, brush1, x, y, color(255, 127, 0, 255));
  }
}

/**
 * Draws the two layers.
 */
void draw() {
  background(0, 0, 0, 0);
  blendMode(BLEND);
  image(layer1, 0, 0);
  image(layer2, 0, 0);
  // image(brush1, 0, 0);
}

/**
 * Draws a brush in a layer at a given position with a given color.
 */
void drawInLayer(PGraphics layer, PGraphics brush, int x, int y, color tint) {
  layer.beginDraw();
  layer.pushStyle();
  layer.pushMatrix();
  layer.tint(red(tint), green(tint), blue(tint), alpha(tint));
  layer.translate(x, y);
  // println("draw in layer " + x + "," + y);
  layer.imageMode(CENTER);
  layer.image(brush, 0, 0); // , brush.width, brush.height);
  layer.popMatrix();
  layer.popStyle();
  layer.endDraw();
}

/**
 * Creates an empty layer.
 */
PGraphics createLayer() {
  final color background_color = color(127, 127, 127, 0); // medium grey
  PGraphics layer = createGraphics(width, height, P2D);
  layer.colorMode(RGB, 255);
  layer.beginDraw();
  layer.background(background_color);
  layer.endDraw();
  return layer;
}

/**
 * Create a brush that is a circular gradient.
 */
PGraphics createBrush() {
  final int brushWidth = 100;
  final int brushHeight = brushWidth;
  PGraphics brush = createGraphics(brushWidth, brushHeight, P2D);
  float maxDistance = brushWidth;
  int centerX = brushWidth / 2;
  int centerY = brushHeight / 2;
  brush.loadPixels();
  for (int x = 0; x < brush.width; x++) {
    for (int y = 0; y < brush.height; y++) {
      float distance = dist(x, y, centerX, centerY);
      int gray = (int) map(distance, 0, maxDistance, 255, 0);
      println("gray: " + gray);
      int index = x + y * brush.width;
      // White, whose alpha is the distance from the center.
      brush.pixels[index] = color(255, 255, 255, gray);
    }
  }
  brush.updatePixels();
  return brush;
}
