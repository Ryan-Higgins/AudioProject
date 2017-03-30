class Trumpet extends Instrument
{
  AudioPlayer trumpet;
  float timer;
  boolean isPlaying;

  Trumpet(float delay)
  {
    super(delay);
    trumpet = minim.loadFile("Trumpet.wav", width);
  }

  void repeat()
  {
    if (isPlaying)
    { 
      trumpet.play();
      timer += 0.5f;
      if (timer >= delay)
      {
        trumpet.rewind();
        timer = 0;
      }
    }
  }

  void play()
  {
    trumpet.rewind();
    trumpet.play();
  }
  
  void render()
  {
   for(int i = 0; i < trumpet.bufferSize(); i++)
   {
     stroke(255,0,0);
     line(i,height/2,i, height/2 + abs((trumpet.left.get(i) * height/2)));  
   }
  }
}