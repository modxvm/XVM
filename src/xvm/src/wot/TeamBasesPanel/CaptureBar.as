/**
 * @author ilitvinov
 */
import wot.utils.Logger;

class wot.TeamBasesPanel.CaptureBar extends net.wargaming.ingame.CaptureBar
{
    private static var TIME_ROUND:Number = 10; // 100 - 0.40999999 -> 0.41
    private var lastPointsIncome:Number;
    private var timeAtPrevUpdate:Number;
    private var timer:Object;
    
    public function CaptureBar()
    {
        super();
    }
    
    public function updateProgress(newPointsVal)
    {
        Logger.add("-");
        //Logger.add("updateProgress(points = " + newPointsVal + ")");
        lastPointsIncome = newPointsVal - m_points;
        super.updateProgress(newPointsVal);
        m_titleTF.text = m_title + " " + capTimeLeft;
    }
    
    public function insertTimerRef(timer:Object)
    {
        //Logger.add("insertTimerRef(");
        this.timer = timer;
    }

    function stopCapture()
    {
        Logger.add("stopCapture()");
        super.stopCapture()
    }
    
    // -- Private
    
    private function get capTimeLeft():String
    {
        var secLeft:Number = capSecondsLeft;
        if (secLeft == 0)
            return "";
        var m:Number=Math.floor((secLeft%3600)/60);
        var s:Number=Math.floor((secLeft%3600)%60);
        return (m < 10?"0" + m.toString():m.toString()) +
        ":"+(s<10?"0"+s.toString():s.toString());
    }
    
    private function get capSecondsLeft():Number
    {
        var capRate:Number = round(getCapRate()); // changes InternalTimer state!
        Logger.add("capRate = " + capRate);
        
        // In case of captureInterrupt
        if (capRate == 0)
            return 0;
        
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
    
    private static function round(num:Number):Number
    {
        num *= TIME_ROUND;
        num = Math.round(num);
        num /= TIME_ROUND;
        return num;
    }
}