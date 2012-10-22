/**
 * @author ilitvinov
 */
import wot.TeamBasesPanel.CapSpeed;
import wot.utils.Logger;

/**
 * Capture progress bar.
 * 
 * Extra features implemented:
 * ) Time left to capture point
 * 
 * TODO:
 * cap pattern recognition system
 * clear timer
 */

class wot.TeamBasesPanel.CaptureBar extends net.wargaming.ingame.CaptureBar
{
    private var m_capSpeed:CapSpeed;
    
    /**
     * CaptureBar() constructor is called once per battle.
     * Not once per capture bar creation on stage.
     */
    
    public function CaptureBar()
    {
        super();
    }
    
    // Called by TeamBasesPanel original WG class
    
    public function updateProgress(newPointsVal:Number)
    {
        Logger.add("");
        //Logger.add("updateProgress(points = " + newPointsVal + ")");
        
        m_capSpeed.calculate(newPointsVal, m_points);
        
        super.updateProgress(newPointsVal);
        
        m_titleTF.text = m_title;
        
        /**
         * Cap block.
         * 
         * updateProgress is also called when capture is blocked at Encounter battle type.
         * Situation occurs when opposing tanks both stand on shared cap point.
         * Сapture bar freezes and blinks white. Cap points already captured remain.
         * captureInterrupt() function at original TeamBasesPanel class
         * is called twice in a seconds while block continues.
         * updateProgress() is also called twice a second.
         */
        
        //Logger.add("Bar: capSpeed = " + m_capSpeed.getSpeed())
        // if (m_capSpeed.getSpeed() != 0) m_titleTF.text += " " + m_capSpeed.getSpeed();
    }
    
    /**
     * Cant be inserted to constructor easily.
     * Cant be passed as argument externally easily.
     * Thus called straight by extended TeamBasesPanel class.
     */ 
    public function init(colorFeature:String)
    {
        var log = colorFeature == "green";
        m_capSpeed = new CapSpeed(log);
        Logger.add("init(): " + colorFeature);
    }
    
    // -- Private
    
    private function get capturersNum():String
    {
        /*
        var tanks:Number;
        
        if (m_minimalCapRate == 0)
            tanks = 1;
        else
            tanks = m_capRate / m_minimalCapRate;
        
        tanks = Math.round(tanks);
        Logger.add("invadersNum: " + tanks);
        return tanks.toString();
        */
        
        return "X";
    }
    
    /**
     * Time format
     * 125 -> 2:05
     */
    private function get capTimeLeft():String
    {
        var secLeft:Number = capSecondsLeft;
        if (secLeft == 0)
            return "";
        var m:Number=Math.floor((secLeft%3600)/60);
        var s:Number=Math.floor((secLeft%3600)%60);
        return m.toString() + ":" +
        (s < 10 ? "0" + s.toString() : s.toString());
    }
    
    private function get capSecondsLeft():Number
    {
        return capPointsLeft / m_capSpeed.getSpeed();
    }
    
    private function get capPointsLeft():Number
    {
        return 100 - m_points;
    }
}