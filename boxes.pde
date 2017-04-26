class Boxes
{
  // this is the code for the spinning cubes in the background
  int boxCount = 20; 
  float boxSpeed = random (2, 5);
  int boxSize=20;
  float boxX;
  float boxY;

  Boxes()
  {
    boxY = height + ( boxSize * 19);
    boxX = random ( boxSize /2, width - boxSize);
  }


  void boxes()
  {

    // this is how i drew the cube
    rotateX(0f);
    strokeWeight(4);
    stroke(0, 255, 255);
    noFill();
    pushMatrix();
    translate(boxX, boxY, 35);
    boxY -=  boxSpeed ;
    rotateX(radians(frameCount));
    rotateY(radians(frameCount));
    box(boxSize);
    if (boxY  < 0 ) // this is how i got the boxes to destory and appear back at the end of the screen once they went of screeen at the top.
    {
      boxX= random(boxSize/2, height - boxSize);
      boxY = height + boxSize;
    }
    popMatrix();
  }
}