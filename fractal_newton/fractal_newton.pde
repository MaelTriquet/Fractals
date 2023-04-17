int deg = floor(random(3, 5));
float[] poly = new float[deg+1];
float x_min = -2;
float y_min = -2;
float w = 4;
float h = 4;
float[] colors = new float[deg];
PVector[] roots = new PVector[deg];
int updated_root = 0;
int max_it = 50;
float dx;
float dy;
PVector a = new PVector(1, 0);
float speed = 0.125/2;
void setup() {
  size(500, 500);
  background(0);
  loadPixels();
  colorMode(HSB);
  dx = w/width;
  dy = h/height;
  for (int i = 0; i < deg+1; i++) {
    poly[i] = random(-2, 2);
  }

  for (int i = 0; i < colors.length; i++) {
    colors[i] = random(255);
  }
}

void draw() {
  float x = x_min;
  for (int i = 0; i < width; i++) {
    float y = y_min;
    for (int j = 0; j < height; j++) {
      PVector z = new PVector(x, y);
      PVector next_z;
      float epsilon;
      int converg_time = max_it;
      for (int k = 0; k < max_it; k++) {
        PVector p_over_dp = divi(apply(poly, z), apply_d(poly, z));
        next_z = z.copy().sub(multi(a, p_over_dp));
        epsilon = dist(next_z.x, next_z.y, z.x, z.y);
        z = next_z;
        if (epsilon < .01) {
          converg_time = k;
          break;
        }
      }
      float color_applied = 300;
      if (converg_time < max_it) {
        for (int k = 0; k < updated_root; k++) {
          if (dist(z.x, z.y, roots[k].x, roots[k].y) < .1) {
            color_applied = colors[k];
          }
        }
      } else {
        color_applied = 0;
      }
      if (color_applied == 300 && updated_root < deg) {
        roots[updated_root] = z;
        updated_root++;
        color_applied = colors[updated_root-1];
      }
      pixels[i+j*width] = color(color_applied, 255, 255 - map(converg_time, 0, 50, 0, 255));
      y += dy;
    }
    x += dx;
  }
  updatePixels();
  a.y = float(frameCount) / 100;
  //a = new PVector(map(mouseX, 0, width, 0, 2), map(mouseY, 0, height, -.5, .5));
}

PVector apply(float[] poly, PVector z) {
  PVector res = new PVector();
  for (int i = 0; i < poly.length; i++) {
    res.add((power(i, z).mult(poly[i])));
  }
  return res;
}

PVector apply_d(float[] poly, PVector z) {
  PVector res = new PVector();
  for (int i = 1; i < poly.length; i++) {
    res.add((power(i-1, z).mult(poly[i] * i)));
  }
  return res;
}

PVector power(int n, PVector z) {
  if (n == 0) {
    return new PVector(1, 0);
  }
  if (n%2 == 0) {
    return power(n/2, multi(z, z));
  }
  return multi(z, power((n-1)/2, multi(z, z)));
}

PVector multi(PVector a, PVector b) {
  return new PVector(a.x * b.x - a.y * b.y, a.x * b.y + a.y * b.x);
}

PVector divi(PVector a, PVector b) {
  PVector conjug = new PVector(b.x, -b.y);
  if (b.x * b.x + b.y * b.y == 0) {
    return new PVector(1000, 1000);
  }
  float fac = 1/(b.x*b.x + b.y*b.y);
  return multi(new PVector(a.x * fac, a.y * fac), conjug);
}
