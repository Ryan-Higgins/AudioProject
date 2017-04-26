class HiHat extends Instrument
{
  AudioPlayer hiHat;
  float timer;
  boolean isPlaying;

  HiHat(float delay)
  {
    super(delay); 
    hiHat = minim.loadFile("Hihat.wav", width);
  }

  void repeat()
  {
    if (isPlaying)
    {
      hiHat.play();
      timer += 0.5f;
      if (timer >= delay)
      {
        hiHat.rewind();
        timer = 0;
      }
    }
    println(isPlaying);
  }
  
  void play()
  {
   hiHat.rewind();
   hiHat.play();
  }
  
  void render()
  {
   for(int i = 0; i < hiHat.bufferSize(); i++)
   {
     stroke(0,0,255);
     line(i,0,i, 0 + abs((hiHat.left.get(i) * height/2))); 
   }
  }
}