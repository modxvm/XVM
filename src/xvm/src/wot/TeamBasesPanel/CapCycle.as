import wot.utils.Logger;
import wot.TeamBasesPanel.TimeRound;

/**
 * Capture cycle at capCycle class consists of two capture point updates
 * because server sends two updates with defferent intervals and cap points
 * in any case except one capturer present.
 * "a b a b a b a ..."
 * 
 * Thus to calculate time left and number of capturers
 * we need to find average data between two updates which in many cases are different.
 * Calculating time left and number of capturers based on one update only
 * leads to different results for different updates ("a" and "b").
 * 
 * Two capturers timeline example below.
 * Two cycles, four updates.
 * "s" - seconds between updates. "p" - points captured.
 * ( cycle )
 * 
 * (1p/1.5s 1p/1s) (1p/1.5s 1p/1s) ...
 * 
 * Three capturers:
 *
 * (1p/1.5s 2p/1s) (1p/1.5s 2p/1s) ...
 * 
 * One capturer below:
 * One capterer at capCycle class is considered particular case
 * of many capturers with two identical steps.
 * 
 * (1p/2.5s 1p/2.5s) (1p/2.5s 1p/2.5s) ... 
 * 
 * Cycle boundaries are moving itself with new updates incoming
 * so average could be found at any update step.
 * 
 * 1p/1.5s (2p/1s  1p/1.5s) 2p/1s   ...
 * 1p/1.5s  2p/1s (1p/1.5s  2p/1s)  ...
 */

class wot.TeamBasesPanel.CapCycle
{
    private var m_prevSpeed:Number; // speed at previous update
    private var m_averageSpeed:Number; // average speed for two updates
    private var log:Boolean;
    
    public function CapCycle(log:Boolean)
    {
        this.log = log;
    }
    
    public function update(curSpeed:Number)
    {
        //if (log) Logger.add("  CapCycle: curSpeed = " + curSpeed);
        if (m_prevSpeed == undefined)
        {
           /**
            * The very first update incoming.
            * Lets do not try to calculate at that moment.
            * Just save a step.
            */
            if (log) Logger.add("  CapCycle: m_prevSpeed == undefined; m_prevSpeed = curSpeed");
            m_prevSpeed = curSpeed;
        }
        else
        {
            //TimeRound.round(
            m_averageSpeed = (m_prevSpeed + curSpeed) / 2;
            //if (log) Logger.add("  CapCycle: update: m_averageSpeed = " + m_averageSpeed);
            m_prevSpeed = curSpeed;
        }
    }
    
    public function getAverageSpeed():Number
    {
        return m_averageSpeed;
    }
    
    public function clear()
    {
        m_prevSpeed = undefined
    }
}