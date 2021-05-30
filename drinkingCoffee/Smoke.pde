class Smoke
{
  // Smoke variables
  float speed;
  int x, y, z;
  float r;
  
  // Constructor
  public Smoke()
  {
    assignRandom(5);
  }
  
  // Assigning starting values to variables
  void assignRandom(float r) 
  {
    speed = random(3, 5);
    y = 20;
    x = (int)random(-15, 15);
    z = (int)random(-15, 15);
    this.r = r;
  }
  
  // Draw function
  void drawSmoke()
  {
    
    // Drawing sphere
    push();
     
     noStroke();
     fill(125);
     translate(x,y,z);
     sphere(r);

    pop();
    
    // Decreasing radius of sphere and y value
    y -= speed;
    r -= 0.2;

    if(r <= 0) assignRandom(5);
  }
}
