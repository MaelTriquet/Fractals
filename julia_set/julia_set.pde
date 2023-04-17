float  x_min = -1.5;
float  y_min = -1.5;
float  w = 3;
float  h = 3;
float  dx;
float  dy;
float  c_x = -0.8;
float  c_y = 0.156;
int max_it = 50;
void setup() {
  size(800, 800);
  background(0);
  colorMode(HSB);
  dx = w/width;
  dy = h / height;
}
void draw() {
  loadPixels();
  float  x = x_min;
  for (int i = 0; i < width; i++) {
    float  y = y_min;
    for (int j = 0; j < height; j++) {
      float  compteur = 0;
      float  a = x;
      float  b = y;
      while (compteur < max_it) {
        float  temp = a;
        a = a*a - b*b + c_x;
        b = 2 * temp * b + c_y;
        if (sqrt(a*a + b*b) > 1) {
          compteur += map(compteur, 0, max_it, 0, 2) / (a*a + b*b);
          break;
        }
        compteur ++;
      }
      if (compteur == max_it) {
        pixels[j * width + i] = color(0);
      } else {
        pixels[j * width + i] = color((160 + 255 - map(compteur, 0, max_it, 0, 255))%255, 255, 255);
      }
      y += dy;
    }
    x += dx;
  }
  updatePixels();
  c_x = .7885 * cos(float(frameCount)/200);
  c_y = .7885 * sin(float(frameCount)/200);
  //c_x = map(mouseX, 0, width, -1, 1);
  //c_y = map(mouseY, 0, height, -1, 1);
  //x_min = map(mouseX, 0, width, x_min, x_min + w) - w/(1+speed) * map(mouseX, 0, width, 0, 1);
  //y_min = map(mouseY, 0, height, y_min, y_min + h) - h/(1+speed)* map(mouseY, 0, height, 0, 1);
  //w /= 1+speed;
  //h /= 1+speed;
  //dx = w/width;
  //dy = h/height;
}
