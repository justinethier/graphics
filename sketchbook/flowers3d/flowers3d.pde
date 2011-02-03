// TODO: 3d version of the flowers. 
// Start by tring to draw 3 spheres in the "starting" configuration...

void setup() { 
  size(1024, 768, P3D); 
  frameRate(30);
  strokeWeight(1);
  noStroke();  
  
  noLoop();
} 

void draw(){
  //background(255, 255, 255); // Clear any previous output
  lights();
  
  fill(255, 128, 128, 128);
  
  // Some sample code...
  
  translate(height/2, width/2);
  sphere(50);
  translate(50, 0);
  sphere(50);
  translate(0, 50);
  sphere(50);  
  translate(50, 0);
  sphere(50);  
}
