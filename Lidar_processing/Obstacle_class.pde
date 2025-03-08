class Obstacle {
  ArrayList<PVector> vertices;
  
  Obstacle() {
    vertices = new ArrayList<PVector>();
    int sides = (int)random(3, 6);
    float centerX = random(100, width-100);
    float centerY = random(100, height-100);
    
    for (int i = 0; i < sides; i++) {
      float angle = map(i, 0, sides, 0, TWO_PI);
      float radius = random(30, 80);
      float x = centerX + cos(angle) * radius;
      float y = centerY + sin(angle) * radius;
      vertices.add(new PVector(x, y));
    }
  }
  
  void display() {
    fill(150, 50);
    stroke(0);
    beginShape();
    for (PVector v : vertices) {
      vertex(v.x, v.y);
    }
    endShape(CLOSE);
  }
}

PVector lineIntersection(PVector start1, PVector end1, PVector start2, PVector end2) {
  float x1 = start1.x, y1 = start1.y;
  float x2 = end1.x, y2 = end1.y;
  float x3 = start2.x, y3 = start2.y;
  float x4 = end2.x, y4 = end2.y;
  
  float den = (y4 - y3)*(x2 - x1) - (x4 - x3)*(y2 - y1);
  if (den == 0) return null;
  
  float ua = ((x4 - x3)*(y1 - y3) - (y4 - y3)*(x1 - x3)) / den;
  float ub = ((x2 - x1)*(y1 - y3) - (y2 - y1)*(x1 - x3)) / den;
  
  if (ua >= 0 && ua <= 1 && ub >= 0 && ub <= 1) {
    return new PVector(x1 + ua*(x2 - x1), y1 + ua*(y2 - y1));
  }
  return null;
}
