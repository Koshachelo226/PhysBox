class circleObject{
  float radius;
  boolean checked = false;
  float density = 1;
  PVector CirclePos = new PVector(0,0);
  PVector CircleDir = new PVector(0,0);
  
  void circleWindowCollides() {
    if (CirclePos.x < radius/2) {
      CircleDir.x = -CircleDir.x;
      CircleDir.mult(bounce);
      CirclePos.add(CircleDir);
      CirclePos.x = radius/2;
    }
    if (CirclePos.y < radius/2) {
      CircleDir.y = -CircleDir.y;
      CircleDir.mult(bounce);
      CirclePos.add(CircleDir);
      CirclePos.y = radius/2;
    }
    if (CirclePos.x > width-radius/2) {
      CircleDir.x = -CircleDir.x;
      CircleDir.mult(bounce);
      CirclePos.add(CircleDir);
      CirclePos.x = width-radius/2;
    }
    if (CirclePos.y > height-radius/2) {
      CircleDir.y = -CircleDir.y;
      CircleDir.mult(bounce);
      CirclePos.add(CircleDir);
      CirclePos.y = height-radius/2;
    }
  }
  
  void drawC() {
    circle(CirclePos.x, CirclePos.y, radius);
  }
  
  void circlePowersCalc() {
    float volume = PI*radius;
    float mass = volume*density;
    float section = (2*PI*radius)/2;
    PVector archPower = new PVector(0, -(densityWater*volume*g.y));
    //PVector gravityPower = new PVector (0, (g.y * mass)/20);
    CircleDir.add(g);
    CircleDir.add(VentPower);
    if (CirclePos.y > height*(0.7)) {
      CircleDir.add(archPower);
    }
    
    CirclePos.add(CircleDir);
    circleWindowCollides();
  }
  
  void circleCollide() {
    for (int j = 0; j < CirclesNumber; j++) {
      if (circles[j].CirclePos == CirclePos) continue;
      
      PVector distanceVect = PVector.sub(circles[j].CirclePos, CirclePos);
      float dist = distanceVect.mag();
      float radius2 = circles[j].radius;
      
      if (dist <= radius2) {
        PVector nextVector = (CircleDir.add(circles[j].CircleDir)).mult(0.5);
        float distCorrection = (radius2-dist)/2.0;
        PVector d = distanceVect.copy();
        PVector correctionVect = d.normalize().mult(distCorrection).mult(bounce);
        
        //PVector MyCorrect = (CircleDir.add(circles[j].CircleDir)).mult(0.5);
        
        circles[j].CircleDir.add(correctionVect);
        CircleDir.sub(correctionVect);
      }
    }
  }
      //PVector newVel = (CircleDir.add(nextC.CircleDir)).div(2);
      
      //PVector collided = PVector.fromAngle(PVector.angleBetween(CirclePos, nextC.CirclePos);
      
      //CircleDir.add(collided);
      //println(CircleDir);
      //CircleDir.div(2);
      //println(CircleDir);
      //nextC.CircleDir.mult(-1);
      
      //CircleDir = (CircleDir.add(nextC.CircleDir)).sub(CircleDir);
    
}
