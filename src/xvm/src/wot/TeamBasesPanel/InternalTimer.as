//import wot.utils.Logger;

class wot.TeamBasesPanel.InternalTimer
{
    // High tick intervals increase +- calculation errors.
    private static var TICK_INTERVAL_MS:Number = 100; // 50ms
    private static var TICK_INTERVAL_S:Number = TICK_INTERVAL_MS / 1000; // 0.05s
    private var prevTime:Number;
    private var timeNow:Number;
    private var flashTimer;

    public function InternalTimer()
    {
        timeNow = 0;
        prevTime = 0;
        flashTimer = setInterval(this, "incTime", TICK_INTERVAL_MS);
    }
    
    public function getInterval():Number
    {
        var newTime:Number = timeNow;
        var interval:Number = newTime - prevTime;
        prevTime = newTime;
        interval = roundToWholeAndHalf(interval);
        return interval;
    }
    
    public function dispose()
    {
        // TODO: 1
        clearInterval(flashTimer);
    }
    
    // -- Private
    
    private function roundToWholeAndHalf(interval:Number):Number
    {
        // 0.40000000000001 -> 0.5
        // 0.60000000000001 -> 0.5
        // 0.9 -> 1
        interval *= 2;
        interval = Math.round(interval);
        return interval /= 2;
    }
    
    private function incTime()
    {
        // TODO:
        //  check for ticking while object deleted
        
        // Logger.add(" * tick - " + secondsElapsed);
        timeNow = timeNow + TICK_INTERVAL_S;
    }
}