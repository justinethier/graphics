// TODO: 3d version of the flowers. 
// Start by tring to draw 3 spheres in the "starting" configuration...

import java.awt.Point;

void setup() { 
  size(1024, 768, P3D); 
  frameRate(15);
  strokeWeight(1);
  noStroke();  
  
//  noLoop();
} 

void draw(){
  background(255);
  lights();
  
  fill(255, 128, 128, 128);
  
  // Some sample code...
  
  translate(width/2, height/2);
  
  float radius = 100;
  for(int angl = 0; angl < 360; angl += 15){
    Point p = pointOnCircle(angl, radius/2);
    translate(p.x, p.y);
    sphere(radius);
  }
}

/**
 *
 */
public Point pointOnCircle(double degrees, double radius) // static
{
  double x = (Math.cos(Math.toRadians(degrees)) * radius);
  double y = (Math.sin(Math.toRadians(degrees)) * radius);

  return new Point( (int)x, (int)y);
}
