class wot.TeamBasesPanel.CapBarModel.InternalTimer
{
    // High tick intervals increase +- calculation errors.
    private static var TICK_INTERVAL_MS:Number = 100; // 100ms
    private static var TICK_INTERVAL_S:Number = TICK_INTERVAL_MS / 1000; // 0.1s
    private static var SELF_DESTRUCT_TICKS_THRESHOLD = TICK_INTERVAL_S * 10 * 5;
    private var m_prevTime:Number;
    private var m_timeNow:Number;
    private var m_destructionTimer:Number;
    private var m_flashTimer;

    public function InternalTimer()
    {
        m_timeNow = 0;
        m_prevTime = 0;
        m_destructionTimer = 0;
        m_flashTimer = _global.setInterval(this, "incTime", TICK_INTERVAL_MS);
    }
    
    public function getInterval():Number
    {
       /**
        * Return time passed since last get.
        */
        var newTime:Number = m_timeNow;
        var interval:Number = newTime - m_prevTime;
        m_prevTime = newTime;
        interval = roundToWholeAndHalf(interval);
        
       /**
        * Reset self-destruction timer.
        * Timer is still in use.
        */ 
        m_destructionTimer = 0;
        
        return interval;
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
    
    private function incTime():Void
    {
        m_timeNow = m_timeNow + TICK_INTERVAL_S;
        m_destructionTimer = m_destructionTimer + TICK_INTERVAL_S;
        
        /**
         * Selfdestruct if timer have not been used for long time.
         */
        if (m_destructionTimer > SELF_DESTRUCT_TICKS_THRESHOLD)
            _global.clearInterval(m_flashTimer);
    }
}
