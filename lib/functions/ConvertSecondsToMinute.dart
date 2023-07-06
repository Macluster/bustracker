



String ConvertSecondstoMinute(int seconds)
{
      double b=seconds/60;
      int r=seconds%60;
    
      return "${b.toInt()}:${(seconds%60).toString()}";
}