/**
 * @author ilitvinov
 */

import flash.filters.DropShadowFilter;
import wot.TeamBasesPanel.CapBarModel.CapSpeed;
import wot.TeamBasesPanel.Macro;
import wot.TeamBasesPanel.CapConfig;
import wot.utils.Logger;

/**
 * Capture progress bar.
 * 
 * Extra features implemented:
 * ) Time left to capture point
 * ) Number of capturibg tanks
 * 
 * TODO:
 * ) Separate lines for each capturer.
 */

class wot.TeamBasesPanel.CaptureBar extends net.wargaming.ingame.CaptureBar
{
    private var m_capSpeed:CapSpeed;
    private var m_macro:Macro;
    
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
        
        m_macro.update(isExtraDefined, capTimeLeft, capturersNum, newPointsVal);
        
        m_titleTF.htmlText = m_macro.getPrimaryText();
        m_timerTF.htmlText = m_macro.getSecondaryText();
        
        if (newPointsVal == 100)
        {
            m_titleTF.htmlText = m_macro.getCaptureDoneText();
            m_timerTF.htmlText = "";
        }
        
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
    public function start(startingPoints:Number):Void
    {
        m_titleTF.filters = getShadowFilter();
        m_timerTF.filters = getShadowFilter();
        
       /**
        * autoSize extends field vertically
        * so lower font parts are not being cut
        * when font size does not fit field height.
        */ 
        m_titleTF.autoSize = "center";
        m_timerTF.autoSize = "center";
        
       /**
        * Adjust distance from primary upper field so
        * no overlapping occurs when font size is high.
        */
        m_titleTF._y -= CapConfig.primaryTitleOffset;
        
        m_capSpeed = new CapSpeed();
        
        m_macro = new Macro(startingPoints);
        
       /**
        * Redraw fields.
        * At this moment TeamBasesPanel called "add"
        * and new style and macro alredy should be defined.
        */
        m_titleTF.htmlText = m_macro.getPrimaryText();
        m_timerTF.htmlText = m_macro.getSecondaryText();
        Logger.add("CaptureBar: start: m_timerTF.htmlText = " + m_timerTF.htmlText);
    }
    
    // -- Private
    
    private function getShadowFilter():Array
    {
        return [new DropShadowFilter(
                0, // distance
                0, // angle
                CapConfig.shadowColor,
                // DropShadowFilter accepts alpha be from 0 to 1.
                // 90 at default config.
                CapConfig.shadowAlpha / 100, 
                CapConfig.shadowBlur,
                CapConfig.shadowBlur,
                CapConfig.shadowStrength,
                3 // quality
            )];
    }
    
    private function get isExtraDefined():Boolean
    {
        return (m_capSpeed.getSpeed() > 0 && capturersNum != undefined);
    }
        
    private function get capturersNum():Number
    {
        return Math.round(m_capSpeed.getSpeed() / m_capSpeed.getOneTankSpeed());
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
