class Drum extends Instrument
{
  AudioPlayer drum;
  float timer;
  boolean isPlaying;

  Drum(float delay)
  {
    super(delay);
    drum = minim.loadFile("Bass-Drum-1.wav", width);
  }

  void repeat()
  {
    if (isPlaying)
    {
      drum.play();
      timer += 0.5f;
      if (timer >= delay)
      {
        drum.rewind();
        timer = 0;
      }
    }
    
  }
  
  void play()
  {
   drum.rewind();
   drum.play();   
  }
  
  void render()
  {
    for(int i = 0; i < drum.bufferSize(); i++)
    {
    stroke(255,255,0);
    line(i,height/2,i, height/2 - abs((drum.left.get(i) * height/2))); 
    }    
  }
}