/**
 * "Sine Flower" 2D image generator.
 *
 * Written in processing, see: http://processing.org
 *
 * Controls:
 *  
 * - Up key: increase radius of circles
 * - Down key: decrease radius of circles
 * - Left key: decrease number of circles
 * - Right key: increase number of circles
 * - Enter key: save current output to PNG
 * - Mouse button click: toggle animation
 * 
 *
 * @author Justin Ethier
 *
 Copyright (c) 2011 Justin Ethier

 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 */

import java.awt.Point;


//
// Variables to control output image
//
 
  // Colors
  float[] colors        = {0, 0, 0, 128}, // R, G, B, Alpha (0 == full transparency)
          colorDiffs    = {1, 1, 1, 0},
          colorMin      = {64, 128, 0, 255},
          colorMax      = {255, 255, 0, 128};
          
  // Radius
  int     initialRadius = 50,
          maxRadius     = 400,
          incRadius     = 10;
          
  // # of "quadrants" - IE, groups of 4 circles, each offset 90 degrees                    
  int numQuads = 8;  

  int _strokeWeight = 1;
  int _frameRate = 15;
  
  boolean animating = true;
//
// End variables
//


/**
 * Setup initial UI configuration
 */
void setup() { 
  size(1024, 768); 
  frameRate(_frameRate);
  strokeWeight(_strokeWeight);
  noFill();  
  
  if (!animating) noLoop();
} 

/**
 * Key pressed event, used for live interaction
 */
void keyPressed() {
  if (keyCode == LEFT) 
  {
    if(numQuads > 1){ numQuads--; }
    redraw();
  }
  else if (keyCode == RIGHT){
    numQuads++;
    redraw();    
  }
  else if (keyCode == UP){
    incRadius -= 1;
    if (incRadius < 0) incRadius = 1;
    redraw();
  }
  else if (keyCode == DOWN){
    incRadius += 1;
    redraw();    
  }
  else if (keyCode == ENTER){
    // TODO: save variables too
    save("output.png");
  }
}

/**
 * Mouse pressed event handler
 */
void mousePressed() {
  if (animating){
    noLoop();
    redraw();  
  } else {
    loop();  
  }
  
  animating = !animating;
}

 
void draw() { 
  background(255, 255, 255); // Clear any previous output

  // TODO: may get better results on inside if count starts from min and increases...
  //       but there may be a problem with sheering, perhaps due to using ellipse()
  //       instead of individual pixels
//  for (int r = maxRadius; r >= initialRadius; r -= incRadius){
  for (int r = initialRadius; r  < maxRadius; r += incRadius){    
    drawFlower(numQuads, (float)r, colors, colorDiffs, colorMin, colorMax); 
  }
  
//  noLoop();
}

/**
 * Ajust stroke color by applying differential values to the
 * color array, and setting the new stroke color.
 */
void adjustColors(float[] colors, float[] diffs, float[] colorMin, float[] colorMax){
  for(int i = 0; i < colors.length; i++){
    colors[i] = colors[i] + diffs[i];
    
    if (colors[i] > colorMax[i]){
      colors[i] = colorMax[i];
      diffs[i] *= -1;
    } else if (colors[i] < colorMin[i]){
      colors[i] = colorMin[i];
      diffs[i] *= -1;
    } 
  }
 
  stroke(colors[0], colors[1], colors[2], colors[3]);
}

/**
 *
 */
void drawFlower(int numQuads, float radius, float[] colors, float[] colorDiffs, float[] colorMin, float[] colorMax)
{
  float x = width/2, y = height/2;
  float angle = 0;
  
  for (int quadAngle = 0; quadAngle < 360; quadAngle += 90 / numQuads)
  {  
    adjustColors(colors, colorDiffs, colorMin, colorMax);
    Point p = pointOnCircle(angle + quadAngle, radius/2);
    ellipse(x + p.x, y + p.y, radius, radius);
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

