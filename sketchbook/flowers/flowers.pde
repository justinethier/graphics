/**
 * "Sine Flower" 2D image generator.
 *
 * Written in processing, see: http://processing.org
 *
 * @author Justin Ethier
 *
 */

import java.awt.Point;

void setup() { 
  size(640, 480); 
  frameRate(30);
} 
 
void draw() { 
  background(255, 255, 255);

  noFill();
  for (int r = 50; r < 500; r += 50){
    // TODO: change colors, make r's increment smaller
    drawFlower( (float)r); 
  }
  
  noLoop();
}

void drawFlower(float radius)
{
  strokeWeight(1);
   float x = width/2, y = height/2;
  float angle = 0;
  
  for (int quadAngle = 0; quadAngle < 360; quadAngle += 90/2) // / numQuads)
  {  
    Point p = pointOnCircle(angle + quadAngle, radius/2);
    ellipse(x + p.x, y + p.y, radius, radius);
  }  
}

public Point pointOnCircle(double degrees, double radius) // static
{
  double x = (Math.cos(Math.toRadians(degrees)) * radius);
  double y = (Math.sin(Math.toRadians(degrees)) * radius);		
		
  return new Point( (int)x, (int)y);
}

