// TODO: 3d version of the flowers. 
// Start by tring to draw 3 spheres in the "starting" configuration...

import java.awt.Point;

void setup() { 
  size(1024, 768, P3D); 
  frameRate(15);
  strokeWeight(1);
  noStroke();  
  
  noLoop();
} 

void draw(){
  background(255);
  lights();
  
  color c = color(255, 128, 128, 128);
  
  // Some sample code...
 
  float numInLine = 22, 
        numInRow=20,
        radius=50,
        dr = 1;
  translate(-radius, -radius, 0);
  
  for(int row = 0; row < numInRow; row++) {
   for(int i = 0; i < numInLine; i++){
      sphere(radius);
      translate(dr * radius/1.0, 0, 0);
    }

    translate(0, radius/1.0);
    dr *= -1;
  }
}

/**
 *
 * /
public Point pointOnCircle(double degrees, double radius) // static
{
  double x = (Math.cos(Math.toRadians(degrees)) * radius);
  double y = (Math.sin(Math.toRadians(degrees)) * radius);

  return new Point( (int)x, (int)y);
}*/
