/**
 * @author ilitvinov
 */
import flash.filters.DropShadowFilter;
import wot.TeamBasesPanel.CapBarModel.CapSpeed;
import wot.TeamBasesPanel.Macro;
import wot.TeamBasesPanel.CapConfig;

/**
 * Capture progress bar
 * 
 * Extra features implemented:
 * ) Time left to capture point
 * ) Number of capturing tanks
 * ) Style customization
 * 
 * Features are based on
 * time passed between updates and number of captured points.
 * 
 * possible todo:
 * ) Fix 2->3 caps breaks cycle transion. Remove quick fix.
 * ) Check if 1->2 caps breaks cycle transion.
 * ) Split ally\enemy bar configs
 * ) Separate capture line for each capturer
 */

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

class wot.TeamBasesPanel.CaptureBar extends net.wargaming.ingame.CaptureBar
{
    private var m_capSpeed:CapSpeed; // calculates capture speed
    private var m_macro:Macro;       // defines user presentable html text
    private var m_capColor:String;
    
   /**
    * CaptureBar() constructor is called once per battle.
    * Not once per capture bar creation on stage.
    * See this.start()
    */
    public function CaptureBar()
    {
        super();
    }
    
   /**
    * Cant be inserted to constructor easily.
    * Cant be passed as argument externally easily.
    * Thus called straight by extended TeamBasesPanel class.
    */ 
    public function start(startingPoints:Number, capColor:String):Void
    {
        m_capColor = capColor;
        // colorFeature respects color blind
        
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
        
        m_macro = new Macro(startingPoints, m_capColor);
        
       /**
        * At this moment TeamBasesPanel called "add".
        * Shadow style and new macro should be defined already.
        * If not, than original WG data will be displayed to user before first update tick.
        */
        m_titleTF.filters = getShadowFilter(capColor);
        m_timerTF.filters = getShadowFilter(capColor);
        m_titleTF.htmlText = m_macro.getPrimaryText();
        m_timerTF.htmlText = m_macro.getSecondaryText();
    }
    
   /**
    * Called by TeamBasesPanel original WG class
    */ 
    public function updateProgress(newPointsVal:Number):Void
    {
        if (newPointsVal == 100)
        {
           /**
            * Full capture reached.
            *
            * "TeamBasesPanel.setCaptured(id, title)" function
            * is overriden with empty behavior to concentrate macro modding at CaptureBar.
            */
            m_titleTF.htmlText = m_macro.getCaptureDoneText();
            m_timerTF.htmlText = "";
            return;
        }
        
        m_capSpeed.calculate(newPointsVal, m_points);

        super.updateProgress(newPointsVal); // modifies m_point;
        
        //prepare text strings
        m_macro.update(isSituationNormal, capSecondsLeft, timeLeftMinSec, capturersNum, newPointsVal);
        
        m_titleTF.htmlText = m_macro.getPrimaryText();   // Upper text field relative to capture bar
        m_timerTF.htmlText = m_macro.getSecondaryText(); // Lower text field relative to capture bar
    }
    
    // -- Private
    
    private function getShadowFilter():Array
    {
        return [new DropShadowFilter(
                0, // distance
                0, // angle
                CapConfig.shadowColor(m_capColor),
                // DropShadowFilter accepts alpha be from 0 to 1.
                // 90 at default config.
                CapConfig.shadowAlpha(m_capColor) / 100, 
                CapConfig.shadowBlur(m_capColor),
                CapConfig.shadowBlur(m_capColor),
                CapConfig.shadowStrength(m_capColor),
                3 // quality
            )];
    }

   /**
    * Check if situation is complicated with extremal conditions.
    * Extremal values should not be presented to user.
    */
    private function get isSituationNormal():Boolean
    {
        return (m_capSpeed.getSpeed() > 0 && capturersNum > 0);
    }
        
    private function get capturersNum():Number
    {
        var caps:Number = Math.round(m_capSpeed.getSpeed() / m_capSpeed.getOneTankSpeed());
        
       /**
        * Quick fix.
        * 
        * When number of capturers increase from 2 to 3
        * cycles somehow conflict.
        * 
        * Tested for encounter battle type.
        * See cap_encounter.wotreplay.
        */
        if (caps == 4)
            caps = 3;
            
        return caps;
    }
    
    /**
     * Time format
     * 125 -> 2:05
     */
    private function get timeLeftMinSec():String
    {
        var min:Number=Math.floor((capSecondsLeft%3600)/60);
        var sec:Number=Math.floor((capSecondsLeft%3600)%60);
        return min.toString() + ":" +
        (sec < 10 ? "0" + sec.toString() : sec.toString());
    }
    
    private function get capSecondsLeft():Number
    {
        return Math.round(capPointsLeft / m_capSpeed.getSpeed());
    }
    
    private function get capPointsLeft():Number
    {
        return 100 - m_points;
    }
}
