/**
 * @author ilitvinov
 */
import wot.TeamBasesPanel.InternalTimer;
import wot.utils.Logger;

/**
 * Capture progress bar.
 * 
 * Extra features implemented:
 * ) Time left to capture point
 * 
 * TODO:
 * invadersNum
 * clear timer
 */

class wot.TeamBasesPanel.CaptureBar extends net.wargaming.ingame.CaptureBar
{
    private static var TIME_ROUND:Number = 10; // val of 100 rounds 0.40999999 to 0.41
    private var lastPointsIncome:Number;
    private var timeAtPrevUpdate:Number;
    private var capRate:Number;
    private var minimalCapRate:Number;
    private var timer:Object;
    
    /**
     * CaptureBar() constructor is called once per battle.
     * Not once per capture bar creation on stage.
     */
    
    public function CaptureBar()
    {
        super();
    }
    
    // Called by TeamBasesPanel original WG class
    
    public function updateProgress(newPointsVal)
    {
        Logger.add("-");
        //Logger.add("updateProgress(points = " + newPointsVal + ")");
        lastPointsIncome = newPointsVal - m_points;
        super.updateProgress(newPointsVal);
        
        /**
         * capRate is used for invadersNum and capTimeLeft calculation.
         * 0.5 - one cap point is captured in two seconds.
         */
        
        capRate = round(getCapRate()); // changes InternalTimer state!
        Logger.add("capRate = " + capRate);
        
        m_titleTF.text = m_title;
        
        /**
         * capRate == 0 means capture is blocked.
         * Situation occurs when opposing tanks both stand on shared cap point.
         * Сapture bar freezes and blinks white. Cap points already captured remain.
         * captureInterrupt function at original TeamBasesPanel class
         * is called in that case.
         */
        
        if (capRate != 0)
            m_titleTF.text += " " + invadersNum + " / " + capTimeLeft;
    }
    
    /**
     * Cant be inserted to constructor easily.
     * Cant be passed as argument externally easily.
     * Thus called straight by extended TeamBasesPanel class.
     */ 
    public function timerStart()
    {
        this.timer = new InternalTimer();
    }
    
    // -- Private
    
    private function get invadersNum():String
    {
        //Logger.add("invadersNum: " + capRate / minimalCapRate);
        return "";
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
        var sLeft:Number = capPointsLeft / capRate;
        Logger.add("-> capSecondsLeft = " + sLeft);
        return sLeft;
    }
    
    private function getCapRate():Number
    {
        return lastPointsIncome / timer.getTimePassedSinceLastCap(); // changes InternalTimer state!
    }
    
    private function get capPointsLeft():Number
    {
        //Logger.add("capPointsLeft = " + (100 - m_points));
        return 100 - m_points;
    }

    /**
     * Without rounding capRate values vary too much.
     * 0.4, 0.41, 0.39
     * this leads to inaccurate capTimeLeft calculation.
     */
            
    private static function round(num:Number):Number
    {
        num *= TIME_ROUND;
        num = Math.round(num);
        num /= TIME_ROUND;
        return num;
    }
}