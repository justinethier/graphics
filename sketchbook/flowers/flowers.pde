/**
 * "Sine Flower" 2D image generator.
 *
 * Written in processing, see: http://processing.org
 *
 * Controls:
 *  
 * - Up key: increase number of of circle "rings"
 * - Down key: decrease number of of circle "rings"
 *
 * - Page Up key: increase radius of circles in outer "rings"
 * - Page Down key: decrease radius of circles in outer "rings" 
 *
 * - Left key: decrease number of circles
 * - Right key: increase number of circles
 *
 * - Enter key: save current output to PNG
 * - Mouse button click: toggle animation
 * 
 *
 * @author Justin Ethier
 *
 * Copyright (c) 2011 Justin Ethier
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import java.awt.Point;


//
// Variables to control output image
//
 
 // TODO: some method of dynamically changing color.
 // may consider simplifying this color scheme as part of that
  // Colors
  float[] colors        = {0, 0, 0, 128}, // R, G, B, Alpha (0 == full transparency)
          colorDiffs    = {1, 1, 1, 0},
          colorMin      = {64, 128, 0, 255},
          colorMax      = {255, 255, 0, 128};
          
  // Radius of each individual circle
  // TODO: would be nice if this could somehow expand to fit the available space of the page.
  int     initialRadius = 50,
          incRadius     = 10;
  
  // # of "rings" of circles
  int numRings = 35;
          
  // # of "quadrants" - IE, groups of 4 circles, each offset 90 degrees                    
  int numQuads = 8;  

  int _strokeWeight = 1;
  int _frameRate = 15;
  
  boolean animating = true;
  int output_num = 0;
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
  else if (keyCode == KeyEvent.VK_PAGE_UP){
    incRadius += 1;    
    redraw();    
  }
  else if (keyCode == KeyEvent.VK_PAGE_DOWN){
    incRadius -= 1;
    if (incRadius < 0) incRadius = 1;
    redraw();
  }  
  else if (keyCode == UP){
    numRings += 1;    
    redraw();    
  }
  else if (keyCode == DOWN){
    numRings -= 1;
    if (numRings < 0) numRings = 1;
    redraw();
  }
  else if (keyCode == ENTER){
    // Take a snapshot, and save settings to file as well
    String[] vars = {
      Arrays.toString(colors),
      Arrays.toString(colorDiffs),
      Arrays.toString(colorMin),
      Arrays.toString(colorMax),
      "" + initialRadius,
      "" + incRadius,
      "" + numRings,
      "" + numQuads,      
      "" + _strokeWeight,
      "" + _frameRate,
      "" + animating
    };

    saveStrings("output-vars-" + String.format("%04d", output_num) + ".txt", vars);    
    save("output-" + String.format("%04d", output_num++) + ".png");
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
  
  int r = initialRadius;
  for (int rings = 0; rings < numRings; rings++){
//  for (int r = initialRadius; r  < maxRadius; r += incRadius){    
  
    drawFlower(numQuads, (float)r, colors, colorDiffs, colorMin, colorMax); 
    r += incRadius;
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

