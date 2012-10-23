/**
 * @author ilitvinov
 */

 import wot.TeamBasesPanel.CapSpeed;

/**
 * Capture progress bar.
 * 
 * Extra features implemented:
 * ) Time left to capture point
 * ) Number of capturibg tanks
 * 
 * TODO:
 * ) Clear timer ###
 * ) Separate lines for each capturer.
 */

class wot.TeamBasesPanel.CaptureBar extends net.wargaming.ingame.CaptureBar
{
    private var m_capSpeed:CapSpeed;
    private var m_log:Boolean;
    
   /**
    * CaptureBar() constructor is called once per battle.
    * Not once per capture bar creation on stage.
    * see this.init()
    */
    public function CaptureBar()
    {
        super();
    }
    
    // Called by TeamBasesPanel original WG class
    
    public function updateProgress(newPointsVal:Number):Void
    {
        m_capSpeed.calculate(newPointsVal, m_points);

        super.updateProgress(newPointsVal); // modifies m_point;
        
        m_titleTF.text = m_title;
        
        if (m_capSpeed.getSpeed() > 0 && capturersNum != undefined)
            m_titleTF.text += " / " + capturersNum;
        
        if (m_capSpeed.getSpeed() > 0)
            m_titleTF.text += " / " + capTimeLeft;
            
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
    }
    
    /**
     * Cant be inserted to constructor easily.
     * Cant be passed as argument externally easily.
     * Thus called straight by extended TeamBasesPanel class.
     */ 
    public function init():Void
    {
        m_capSpeed = new CapSpeed();
    }
    
    public function setStyle(format:TextFormat, filters:Array):Void
    {
        m_titleTF.setNewTextFormat(format);
        m_timerTF.setNewTextFormat(format);
        m_titleTF.filters = filters;
        m_timerTF.filters = filters;
    }
    
    // -- Private
    
    private function get capturersNum():String
    {
        var tanks:Number = Math.round(m_capSpeed.getSpeed() / m_capSpeed.getOneTankSpeed());
        return tanks.toString();
    }
    
    /**
     * Time format
     * 125 -> 2:05
     */
    private function get capTimeLeft():String
    {
        var secLeft:Number = Math.round(capSecondsLeft);
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