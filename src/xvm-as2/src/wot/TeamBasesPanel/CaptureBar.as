/**
 * Capture progress bar
 *
 * @author ilitvinov
 */
import com.xvm.*;
import flash.filters.*;
import flash.geom.Rectangle;

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

    function updateCaptureData()
    {
        return this.updateCaptureDataImpl.apply(this, arguments);
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

    private var cfg:Object;
    private var m_captured:Boolean;
    private var m_baseNumText:String = "";

    public function CaptureBarCtor()
    {
        //Logger.add("CaptureBar");

        cfg = Config.config.captureBar[type];

        // Colorize capture bar
        var color = cfg.color;

        //Logger.add("c: " + color);

        if (color != null && !isNaN(color))
            color = parseInt(color);

        if (color == null || isNaN(color))
        {
            color = Config.config.markers.useStandardMarkers
                ? net.wargaming.managers.ColorSchemeManager.instance.getRGB("vm_" + type)
                : ColorsManager.getSystemColor(type, false);
        }

        GraphicsUtil.colorize(wrapper.m_bgMC, color, 1);
        GraphicsUtil.colorize(wrapper.captureProgress.m_barMC, color, 1);

        if (Config.config.captureBar.enabled)
        {
            //wrapper.scrollRect = new Rectangle(20, 10, 100, 30);

            wrapper.m_titleTF._x -= 100;
            wrapper.m_titleTF._width += 200;
            setupTextField(wrapper.m_titleTF, "title");

            setupTextField(wrapper.m_playersTF, "players");

            setupTextField(wrapper.m_timerTF, "timer");

            wrapper.m_pointsTF._x -= 175;
            wrapper.m_pointsTF._width += 350;
            setupTextField(wrapper.m_pointsTF, "points");
        }
    }

    // override
    function configUIImpl()
    {
        //Logger.add("CaptureBar.configUI");

        base.configUI();

        if (Config.config.captureBar.enabled)
        {
            m_baseNumText = DAAPI.py_xvm_captureBarGetBaseNumText(wrapper.id);
            updateTextFields();
        }
    }

    // override
    public function updateCaptureDataImpl()
    {
        //Logger.add("CaptureBar.updateCaptureData: " + arguments);

        base.updateCaptureData.apply(base, arguments);

        if (Config.config.captureBar.enabled)
        {
            updateTextFields();
        }
    }

    // override
    function updateTitleImpl()
    {
        //Logger.add("CaptureBar.updateTitle: " + arguments);

        base.updateTitle.apply(base, arguments);

        if (Config.config.captureBar.enabled)
        {
            m_captured = true;
            updateTextFields();
        }
    }

    // PRIVATE

    private function get type():String
    {
        return wrapper.m_colorFeature == "green" ? "ally" : "enemy";
    }

    private function setupTextField(tf:TextField, name:String):Void
    {
        var c = cfg[name];
        //tf.border = true; tf.borderColor = 0xFF0000;
        tf.selectable = false;
        tf._x += Macros.FormatGlobalNumberValue(c.x);
        tf._y += Macros.FormatGlobalNumberValue(c.y);
        tf.filters = [new DropShadowFilter(
            0, // distance
            0, // angle
            Macros.FormatGlobalNumberValue(c.shadow.color),
            Macros.FormatGlobalNumberValue(c.shadow.alpha) / 100.0,
            Macros.FormatGlobalNumberValue(c.shadow.blur),
            Macros.FormatGlobalNumberValue(c.shadow.blur),
            Macros.FormatGlobalNumberValue(c.shadow.strength))];
    }

    private function updateTextFields():Void
    {
        var o = {
            points: wrapper.m_points,
            vehiclesCount: wrapper.m_vehiclesCount,
            timeLeft: wrapper.m_timeLeft,
            timeLeftSec: Utils.timeStrToSec(wrapper.m_timeLeft)
        };

        var value:String;
        var name = m_captured ? "done" : "format";

        value = Macros.Format(null, cfg.title[name], o);
        value = Strings.substitute(value, [ m_baseNumText ]);
        wrapper.m_titleTF.htmlText = value;

        value = Macros.Format(null, cfg.players[name], o);
        value = Strings.substitute(value, [ m_baseNumText ]);
        if (value == "")
        {
            // TODO: hide icon
        }
        wrapper.m_playersTF.htmlText = value;

        value = Macros.Format(null, cfg.timer[name], o);
        value = Strings.substitute(value, [ m_baseNumText ]);
        if (value == "")
        {
            // TODO: hide icon
        }
        wrapper.m_timerTF.htmlText = value;

        value = Macros.Format(null, cfg.points[name], o);
        value = Strings.substitute(value, [ m_baseNumText ]);
        wrapper.m_pointsTF.htmlText = value;
    }
}
