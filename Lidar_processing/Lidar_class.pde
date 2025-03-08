class Lidar {
  PVector position;
  float startAngle, endAngle;
  int numLasers;
  float maxDistance;
  boolean isDragging;
  
  Lidar(float x, float y, float start, float end, int lasers, float dist) {
    position = new PVector(x, y);
    startAngle = start;
    endAngle = end;
    numLasers = lasers;
    maxDistance = dist;
    isDragging = false;
  }
  
  void update() {
    if (isDragging) {
      position.set(mouseX, mouseY);
    }
  }
  
  void display() {
    // Draw field of view
    noStroke();
    fill(0, 0, 255, 30);
    arc(position.x, position.y, maxDistance*2, maxDistance*2, startAngle, endAngle, PIE);
  }
  
  void castLasers(ArrayList<Obstacle> obstacles) {
    for (int i = 0; i < numLasers; i++) {
      float angle = calculateLaserAngle(i);
      PVector direction = PVector.fromAngle(angle);
      PVector endPoint = PVector.add(position, PVector.mult(direction, maxDistance));
      
      PVector closestIntersection = null;
      float record = maxDistance;
      
      for (Obstacle obs : obstacles) {
        for (int j = 0; j < obs.vertices.size(); j++) {
          PVector a = obs.vertices.get(j);
          PVector b = obs.vertices.get((j + 1) % obs.vertices.size());
          PVector intersection = lineIntersection(position, endPoint, a, b);
          
          if (intersection != null) {
            float distance = position.dist(intersection);
            if (distance < record) {
              record = distance;
              closestIntersection = intersection;
            }
          }
        }
      }
      
      // Draw laser
      stroke(0, 100);
      if (closestIntersection != null) {
        line(position.x, position.y, closestIntersection.x, closestIntersection.y);
        fill(255, 0, 0);
        noStroke();
        ellipse(closestIntersection.x, closestIntersection.y, 5, 5);
      } else {
        line(position.x, position.y, endPoint.x, endPoint.y);
      }
    }
  }
  
  float calculateLaserAngle(int index) {
    if (numLasers == 1) return startAngle;
    return startAngle + (endAngle - startAngle) * (index / (float)(numLasers - 1));
  }
  
  void startDragging() {
    if (dist(position.x, position.y, mouseX, mouseY) < 20) {
      isDragging = true;
    }
  }
  
  void stopDragging() {
    isDragging = false;
  }
  
  void updatePosition(float x, float y) {
    position.set(x, y);
  }
  
  void resetPosition() {
    position.set(width/2, height/2);
  }
}
