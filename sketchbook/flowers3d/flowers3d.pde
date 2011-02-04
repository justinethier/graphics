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

/**
 * Key pressed event, used for live interaction
 */
float eyeYOffset = 0;
float eyeZOffset = 0;
void keyPressed() {
  if (keyCode == UP){
    camera(width/2.0, height/2.0, 
            (height/2.0) / tan(PI*60.0 / 360.0) + (eyeZOffset += 10),
            width/2.0,
            height/2.0,
            0,0,1,0);
    redraw();
  }
  else if (keyCode == DOWN){
    camera(width/2.0, height/2.0, 
            (height/2.0) / tan(PI*60.0 / 360.0) + (eyeZOffset -= 10),
            width/2.0,
            height/2.0,
            0,0,1,0);
    redraw();
  }
  else if (keyCode == LEFT){
    camera(width/2.0, 
           height/2.0 + (eyeYOffset -= 10), 
            (height/2.0) / tan(PI*60.0 / 360.0) + (eyeZOffset),
            width/2.0,
            height/2.0,
            0,0,1,0);
    redraw();
  }
}

void draw(){
  background(255);
  lights();
  
  fill(255, 128, 128, 128);
  
  float radius = 10;
  for(int r = 0; r < 35; r++){
    pushMatrix(); 
    translate(width/2.0, height/2.0 - r*radius*2.0);
    for(int angl = 0; angl < 360; angl += 15){
      Point p = pointOnCircle(angl, r * radius/2);
      translate(p.x, p.y);
      sphere(radius * r);
    }
    popMatrix(); 
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
