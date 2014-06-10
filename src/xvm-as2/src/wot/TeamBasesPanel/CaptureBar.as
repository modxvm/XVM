/**
 * @author ilitvinov
 */
import com.xvm.*;
import flash.filters.*;
import wot.TeamBasesPanel.CapBarModel.*;
import wot.TeamBasesPanel.*;

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

class wot.TeamBasesPanel.CaptureBar
{
    /////////////////////////////////////////////////////////////////
    // wrapped methods

    private var wrapper:net.wargaming.ingame.CaptureBar;
    private var base:net.wargaming.ingame.CaptureBar;

    public function CaptureBar(wrapper:net.wargaming.ingame.CaptureBar, base:net.wargaming.ingame.CaptureBar)
    {
        this.wrapper = wrapper;
        this.base = base;
        wrapper.xvm_worker = this;
        CaptureBarCtor();
    }

    function updateProgress()
    {
        return this.updateProgressImpl.apply(this, arguments);
    }

    function updateTitle()
    {
        return this.updateTitleImpl.apply(this, arguments);
    }

    function configUI()
    {
        return this.configUIImpl.apply(this, arguments);
    }

    // wrapped methods
    /////////////////////////////////////////////////////////////////

    private var m_capSpeed:CapSpeed; // calculates capture speed
    private var m_oneTankSpeed:OneTankSpeed; // define cap min cap speed based on map type
    private var m_macro:Macro;       // defines user presentable html text
    private var m_capColor:String;
    private var m_captured:Boolean;

    /** Ugly hack to allow one tick earlier speed calculation */
    private var m_startPoints:Number

   /**
    * CaptureBar() constructor is called once per battle.
    * Not once per capture bar creation on stage.
    * See this.start()
    */
    public function CaptureBarCtor()
    {
        Utils.TraceXvmModule("TeamBasesPanel");

        m_oneTankSpeed = new OneTankSpeed();
        m_captured = false;

        // Colorize capture bar
        var type = wrapper.m_colorFeature == "green" ? "ally" : "enemy";
        var color = Config.config.markers.useStandardMarkers
            ? net.wargaming.managers.ColorSchemeManager.instance.getRGB("vm_" + type)
            : ColorsManager.getSystemColor(type, false);

        GraphicsUtil.colorize(wrapper.m_bgMC, color, 1);
        GraphicsUtil.colorize(wrapper.captureProgress.m_barMC, color, 1);
    }

   /**
    * Cant be inserted to constructor easily.
    * Cant be passed as argument externally easily.
    * Thus called straight by extended TeamBasesPanel class.
    */
    public function start(startPoints:Number, capColor:String):Void
    {
        //Logger.addObject(wrapper, 2);

        /** Ugly hack to allow one tick earlier speed calculation */
        m_startPoints = startPoints;

       /** colorFeature respects color blind */
        m_capColor = capColor;

       /**
        * autoSize extends field vertically
        * so lower font parts are not being cut
        * when font size does not fit field height.
        */
        wrapper.m_titleTF.autoSize = "center";
        wrapper.m_timerTF.autoSize = "center";

       /**
        * Adjust distance from primary upper field so
        * no overlapping occurs when font size is high.
        */
        wrapper.m_titleTF._y -= CapConfig.primaryTitleOffset;

        /** Calculates capture speed */
        m_capSpeed = new CapSpeed();

        /** Substitutes macro text like {{speed}} with corresponding value to present at user interface */
        m_macro = new Macro(startPoints, m_capColor);

       /**
        * At this moment TeamBasesPanel called "add" method.
        * Shadow style and new macro should be defined already.
        * If not, than original WG data will be displayed to user before first update tick.
        */
        wrapper.m_titleTF.filters = getShadowFilter(capColor);
        wrapper.m_timerTF.filters = getShadowFilter(capColor);
        wrapper.m_titleTF.htmlText = m_macro.getPrimaryText();
        wrapper.m_timerTF.htmlText = m_macro.getSecondaryText();
    }

   /**
    * Called by TeamBasesPanel original WG class
    */
    public function updateProgressImpl(newPointsVal:Number):Void
    {
        if (!CapConfig.enabled)
        {
            base.updateProgress(newPointsVal);
            return;
        }

        if (m_captured)
            return;

        m_capSpeed.calculate(newPointsVal, wrapper.m_points || m_startPoints);

        base.updateProgress(newPointsVal); // modifies m_point;

        //prepare text strings
        m_macro.update(isSituationNormal, capSecondsLeft, timeLeftMinSec, capturersNum, newPointsVal, m_capSpeed.getSpeed());

        wrapper.m_titleTF.htmlText = m_macro.getPrimaryText();   // Upper text field relative to capture bar
        wrapper.m_timerTF.htmlText = m_macro.getSecondaryText(); // Lower text field relative to capture bar
    }

    /**
     * OVERRIDE
     * Called from TeamBasesPanel.setCaptured, when point becomes fully captured (3-5 seconds after 100 percent).
     * @param value
     */
    function updateTitleImpl(value)
    {
        if (!CapConfig.enabled)
        {
            base.updateTitle(value);
            return;
        }

        m_captured = true;

        wrapper.m_titleTF.htmlText = m_macro.getCaptureDoneText();
        wrapper.m_timerTF.htmlText = "";
    }

    /**
     * OVERRIDE
     */
    function configUIImpl()
    {
        base.configUI();
        updateProgressImpl(wrapper.m_points);
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
        * Calculating more than 3 caps at encounter battle type is too complicated.
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
        return 100 - wrapper.m_points;
    }
}
