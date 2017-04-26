class Boxes
{
int boxCount = 20; 
float boxSpeed = random (2,5);
int boxSize=20;

//float [] boxX = new float [boxCount];
//float [] boxY = new float [boxCount]; 
float boxX;
float boxY;

Boxes()
{
    boxY = height + ( boxSize * 19);
    boxX = random ( boxSize /2 , width - boxSize); 
}


void boxes()
{
  //for (int i =0; i < boxX.length; i++)
  //{
    // Draw a cube
    rotateX(0f);
    strokeWeight(4);
    stroke(0, 255, 255);
    noFill();
    pushMatrix();
    translate(boxX, boxY, 35);
    boxY -=  boxSpeed ;
    // boxZ +=1;
    rotateX(radians(frameCount));
    rotateY(radians(frameCount));
    box(boxSize);
    if (boxY  < 0 )
    {
      boxX= random(boxSize/2 , height - boxSize);
      boxY = height + boxSize;
    }
    popMatrix();
  }
}