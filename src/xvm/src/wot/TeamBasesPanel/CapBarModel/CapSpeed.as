import wot.TeamBasesPanel.CapBarModel.CapCycle;
import wot.TeamBasesPanel.CapBarModel.InternalTimer;
import wot.TeamBasesPanel.CapBarModel.OneTankSpeed;
import wot.utils.Round;

/**
* This class determines capture speed based on latest information
* about points captured and time passed since last capture updates.
*
* Speed of 0.5 means one cap point is captured in two seconds.
*/

class wot.TeamBasesPanel.CapBarModel.CapSpeed
{
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
        var approxSpeed:Number = Round.round(rawSpeed, 100); // to 0.01 digit
        if (approxSpeed < OneTankSpeed.APPROX_MIN_SPEED_ENCOUNTER || approxSpeed > 8)
        {
           /**
            * Extremes conditions with infinity, negatives, NaN like
            * capture points dropped,
            * capture is blocked or
            * high speed due to replay rewind.
            * 
            * Reset everything and bail out.
            * Will recalculate in two cycles of normal capture flow.
            */
            m_cycle.clear();
            m_speed = 0;
            return;
        }
        
       /**
        * Define capturing cycle size and
        * calculate average speed for last cycle.
        * See CapCycle class for details.
        */
        m_cycle.update(approxSpeed);
        m_speed = m_cycle.getAverageSpeed();
    }
    
    public function getSpeed():Number
    {
        return m_speed;
    }
}
