/**
 * @author ilitvinov
 */
import flash.filters.DropShadowFilter;
import wot.TeamBasesPanel.CapBarModel.CapSpeed;
import wot.TeamBasesPanel.Macro;
import wot.TeamBasesPanel.CapConfig;
import wot.TeamBasesPanel.CapBarModel.OneTankSpeed;

/**
 * Capture progress bar
 * 
 * Extra features implemented:
 * ) Time left to capture point
 * ) Number of capturing tanks
 * ) Style customization
 * 
 * Features are based on
 * time passed and number of captured points between updates.
 * 
 * possible todo:
 * ) Separate capture line for each capturer. Hard.
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
    private var m_oneTankSpeed:OneTankSpeed; // define cap min cap speed based on map type
    private var m_macro:Macro;       // defines user presentable html text
    private var m_capColor:String;
    
    /** Ugly hack to allow one tick earlier speed calculation */
    private var m_startPoints:Number
    
   /**
    * CaptureBar() constructor is called once per battle.
    * Not once per capture bar creation on stage.
    * See this.start()
    */
    public function CaptureBar()
    {
        m_oneTankSpeed = new OneTankSpeed();
        super();
    }
    
   /**
    * Cant be inserted to constructor easily.
    * Cant be passed as argument externally easily.
    * Thus called straight by extended TeamBasesPanel class.
    */
    public function start(startPoints:Number, capColor:String):Void
    {
        /** Ugly hack to allow one tick earlier speed calculation */
        m_startPoints = startPoints;
        
       /** colorFeature respects color blind */
        m_capColor = capColor;
       
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
        
        /** Calculates capture speed */
        m_capSpeed = new CapSpeed();
        
        /** Substitutes macro text like {{speed}} with corresponding value to present at user interface */
        m_macro = new Macro(startPoints, m_capColor);
        
       /**
        * At this moment TeamBasesPanel called "add" method.
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
        if (!CapConfig.enabled)
        {
            super.updateProgress(newPointsVal);
            return;
        }
        
        if (newPointsVal == 100)
        {
           /**
            * Full capture reached.
            *
            * "TeamBasesPanel.setCaptured(id, title)" function
            * is overriden with empty behavior to concentrate macro modding at CaptureBar.
            */
           
            /** Called so cap bar is filled completely to 100% */
            super.updateProgress(newPointsVal);
            
            m_titleTF.htmlText = m_macro.getCaptureDoneText();
            m_timerTF.htmlText = "";
            
            return;
        }
        
        m_capSpeed.calculate(newPointsVal, m_points || m_startPoints);

        super.updateProgress(newPointsVal); // modifies m_point;
        
        //prepare text strings
        m_macro.update(isSituationNormal, capSecondsLeft, timeLeftMinSec, capturersNum, newPointsVal, m_capSpeed.getSpeed());
        
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
        var caps:Number = Math.round(m_capSpeed.getSpeed() / m_oneTankSpeed.getSpeed());
        
       /**
        * Maximum capturers number at standart battle type is 3.
        * Calculating more than 3 caps at encounter battle type is complicated.
        */
        if (caps > 3)
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
