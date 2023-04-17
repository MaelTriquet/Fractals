float x_min = -2;
float y_min = -2;
float w = 4;
float h = 4;
float dx;
float dy;
float speed = 0.001;
void setup() {
  size(800, 800);
  background(0);
  colorMode(HSB);
  dx = w/width;
  dy = h / height;
}
void draw() {
  loadPixels();
  float x = x_min;
  for (int i = 0; i < width; i++) {
    float y = y_min;
    for (int j = 0; j < height; j++) {
      float compteur = 0;
      float a = 0;
      float b = 0;
      while (compteur < 100) {
        float temp = a;
        a = a*a - b*b + x;
        b = 2 * temp * b + y;
        if (sqrt(a*a + b*b) > 4) {
          break;
        }
        compteur ++;
      }
      if (compteur == 100) {
        pixels[j * width + i] = color(0);
      } else {
        pixels[j * width + i] = color(255-map(sqrt(map(compteur, 0, 50, 0, 1)), 0, 1, 0, 255), 255, 255);
      }
      y += dy;
    }
    x += dx;
  }
  updatePixels();
  x_min = map(mouseX, 0, width, x_min, x_min + w) - w/(1+speed) * map(mouseX, 0, width, 0, 1);
  y_min = map(mouseY, 0, height, y_min, y_min + h) - h/(1+speed)* map(mouseY, 0, height, 0, 1);
  w /= 1+speed;
  h /= 1+speed;
  dx = w/width;
  dy = h/height;
}

void keyPressed() {
  switch(key) {
  case '+':
    speed *= 2;
    break;
  case '-':
    speed /= 2;
    break;
  }
}
