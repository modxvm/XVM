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
    private var m_cycle:CapCycle;
    private var m_timer:InternalTimer;

    private var m_speed:Number;
    private var m_minimalCapSpeed:Number;
    private var log:Boolean;
    
    public function CapSpeed(log:Boolean) 
    {
        this.log = log;
        
        m_minimalCapSpeed = Infinity;
        m_cycle = new CapCycle(log);
        m_timer = new InternalTimer();
    }
    
    public function calculate(newPointsVal:Number, prevPoints:Number)
    {
        var interval:Number = m_timer.getInterval(); // changes InternalTimer state!
        var rawSpeed:Number = (newPointsVal - prevPoints) / interval;
        
        var normalSpeed:Number = TimeRound.round(rawSpeed);
        
        defineMinimalSpeed(normalSpeed);
        
        if (normalSpeed >= m_minimalCapSpeed && normalSpeed < 10)
        {
           /**
            * Calculate average speed between two last updates.
            * See CapCycle class for details.
            */
            m_cycle.update(normalSpeed);
            m_speed = m_cycle.getAverageSpeed();
        }
        else
        {
           /**
            * Capture points dropped.
            * Capture is blocked.
            * Extreme speed due to replay rewind.
            * 
            * Reset everything. Will recalculate in one cycle of normal capturing.
            */
            m_cycle.clear();
            m_speed = 0;
        }
        if (log) Logger.add(" CapSpeed: av = " + m_speed + " raw = " + rawSpeed);
    }
    
    public function getSpeed():Number
    {
        return m_speed;
    }
    
    // -- Private
    
    private function defineMinimalSpeed(normalSpeed)
    {
        //if (m_minimalCapSpeed > normalSpeed && )
            m_minimalCapSpeed = 0.4
        //if (log) Logger.add(" CapSpeed: m_minimalCapSpeed = " + m_minimalCapSpeed );
    }
}