import wot.utils.Logger;
import wot.TeamBasesPanel.CapBarModel.CapCycle;
import wot.TeamBasesPanel.CapBarModel.InternalTimer;
import wot.TeamBasesPanel.CapBarModel.TimeRound;

/**
 * This class determines capture speed based on latest information
 * about points captured and time passed since last capture update.
 *
 * Then this speed is sent to CapCycle which determines average
 * speed for two latest updates. Average speed returned is then used
 * at upper CaptureBar class.
 * 
 * Speed of 0.5 means one cap point is captured in two seconds.
 */

class wot.TeamBasesPanel.CapBarModel.CapSpeed
{
   /**
    * 0.5, 0.4 minimal for encounter battle type.
    * 1 is minimal speed for other battle types.
    */
    private static var s_minimalCapSpeed:Number = 1; 
    
    private var m_cycle:CapCycle;
    private var m_timer:InternalTimer;

    private var m_speed:Number;
    
    public function CapSpeed() 
    {
        m_cycle = new CapCycle();
        m_timer = new InternalTimer();
    }
    
    public function calculate(newPointsVal:Number, prevPoints:Number):Void
    {
        var interval:Number = m_timer.getInterval(); // Changes InternalTimer state!
        var rawSpeed:Number = (newPointsVal - prevPoints) / interval;
        
        if (rawSpeed <= 0.2 || rawSpeed > 12)
        {
           /**
            * Capture points dropped.
            * Capture is blocked.
            * High speed due to replay rewind.
            * Extremes conditions like infinity, negatives, NaN.
            * 
            * Reset everything and bail out.
            * Will recalculate in one cycle of normal capture flow.
            */
            m_cycle.clear();
            m_speed = 0;
            return;
        }
        
       /**
        * Calculate average speed between two last updates.
        * See CapCycle class for details.
        */
        m_cycle.update(rawSpeed);
        m_speed = m_cycle.getAverageSpeed();
        m_speed = TimeRound.round(m_speed, 10); // to 0.1 digit
        
        defineMinimalSpeed();
    }
    
    public function getSpeed():Number
    {
        return m_speed;
    }
        
    public function getOneTankSpeed():Number
    {
        //Logger.add(" CapSpeed.getOneTankSpeed = " + s_minimalCapSpeed)
        return s_minimalCapSpeed;
    }
    
    // -- Private
    
    private function defineMinimalSpeed():Void
    {
        Logger.add(" CapSpeed.m_speed = " + m_speed);
        if (m_speed < s_minimalCapSpeed)
            s_minimalCapSpeed = m_speed;
    }
}
