import wot.TeamBasesPanel.CapCycle;
import wot.TeamBasesPanel.InternalTimer;
import wot.utils.Logger;
import wot.TeamBasesPanel.TimeRound;

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

class wot.TeamBasesPanel.CapSpeed
{
    private static var m_minimalCapSpeed:Number;
    
    private var m_cycle:CapCycle;
    private var m_timer:InternalTimer;

    private var m_speed:Number;
    private var m_log:Boolean;
    
    public function CapSpeed(log:Boolean) 
    {
        this.m_log = log;
        
        m_minimalCapSpeed = Infinity;
        m_cycle = new CapCycle(log);
        m_timer = new InternalTimer();
    }
    
    public function calculate(newPointsVal:Number, prevPoints:Number):Void
    {
        var interval:Number = m_timer.getInterval(); // Changes InternalTimer state!
        var rawSpeed:Number = (newPointsVal - prevPoints) / interval;
        
        if (m_log) Logger.add(" CapSpeed: raw = " + rawSpeed);
        if (rawSpeed <= 0.2 || rawSpeed > 8)
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
            if (m_log) Logger.add(" CapSpeed: drop!");
            return;
        }
        
        rawSpeed = TimeRound.round(rawSpeed, 1000); // to 0.001 digit
        var normalSpeed:Number = TimeRound.round(rawSpeed, 10); // to 0.1 digit
        
        defineMinimalSpeed(normalSpeed);
        
       /**
        * Calculate average speed between two last updates.
        * See CapCycle class for details.
        */
        m_cycle.update(rawSpeed);
        m_speed = m_cycle.getAverageSpeed();
       
        // if (m_log) Logger.add(" CapSpeed: av = " + m_speed + " raw = " + rawSpeed);
    }
    
    public function getSpeed():Number
    {
        return m_speed;
    }
        
    public function getOneTankSpeed():Number
    {
        return m_minimalCapSpeed;
    }
    
    // -- Private
    
    private function defineMinimalSpeed(normalSpeed):Void
    {
        if (m_minimalCapSpeed == undefined)
        {
            if (normalSpeed == 0.4 || normalSpeed == 0.8) // Encounter battle type
                m_minimalCapSpeed = 0.4;
            if (normalSpeed == 1 || normalSpeed == 2) // Other types
                m_minimalCapSpeed = 1;
        }
    }
}