ArrayList<Obstacle> obstacles = new ArrayList<Obstacle>();
Lidar lidar;

void setup() {
  size(800, 600);
  //fullScreen();
  lidar = new Lidar(width/2, height/2, -PI, PI, 100, 200);
  generateObstacles();
}

void draw() {
  background(255);
  
  // Draw obstacles
  for (Obstacle obs : obstacles) {
    obs.display();
  }
  
  // Update and draw lidar
  lidar.update();
  lidar.display();
  lidar.castLasers(obstacles);
}

void generateObstacles() {
  obstacles.clear();
  for (int i = 0; i < 5; i++) {
    obstacles.add(new Obstacle());
  }
}

void mousePressed() {
  lidar.startDragging();
}

void mouseDragged() {
  lidar.updatePosition(mouseX, mouseY);
}

void mouseReleased() {
  lidar.stopDragging();
}

void keyPressed() {
  if (key == ' ') {
    lidar.resetPosition();
    generateObstacles();
  }
}
