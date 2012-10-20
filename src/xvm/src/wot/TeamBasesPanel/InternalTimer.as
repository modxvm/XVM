import wot.utils.Logger;

class wot.TeamBasesPanel.InternalTimer
{
    public var timeNow:Number;
    private var interval;
    
    private static var TICK_INTERVAL_MS:Number = 50; // 100ms
    private static var TICK_INTERVAL_S:Number = TICK_INTERVAL_MS / 1000; // 0.1s
    private var prevCapTime:Number;

    public function InternalTimer()
    {
        timeNow = 0;
        prevCapTime = 0;
        interval = setInterval(this, "incTime", TICK_INTERVAL_MS);
        //Logger.add("InternalTimer()");
    }
    
    public function getTimePassedSinceLastCap():Number
    {
        //Logger.add(" passed = " + timeNow);
        //Logger.add(" lastCapTime = " + prevCapTime);
        var newCapTime:Number = timeNow;
        var capInterval:Number = newCapTime - prevCapTime;
        prevCapTime = newCapTime;
        Logger.add("capInterval = " + capInterval);
        return capInterval;
    }
    
    public function clear()
    {
        clearInterval(interval);
    }
    
    private function incTime()
    {
        // TODO:
        //  check for ticking while object deleted
        
        //Logger.add(" * tick - " + secondsElapsed);
        timeNow = timeNow + TICK_INTERVAL_S;
    }
}