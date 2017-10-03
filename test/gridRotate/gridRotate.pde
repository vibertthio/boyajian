// Pallete
color[] colors = {
  color(253, 148, 38),
  color(252, 86, 44),
  color(56, 195, 206),
  color(124, 156, 124),
  color(18, 99, 104),
};

RotateGrid grid;

void setup() {
  size(500, 500);
  grid = new RotateGrid(colors[1]);
}

void draw() {
  background(50);
  grid.draw();
}
