void backGround()
{
  
  rotateX(0.6f);
  background(0);
  stroke(0, 0, 255);
  //float total = 0; 

  for (int i = 0; i < ai.bufferSize(); i ++)
  {
    for ( int j =0; j < height; j +=90)
    {
      line(i, j, i, j + (ai.left.get(i) * 50));
      //total += abs( ai.left.get(i));
      line(j, i, j + (ai.left.get(i) * 50), i);
    }
  }
}