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

        if (!Config.config.captureBar.enabled)
        {
            wrapper.m_playersTF._x -= 50;
            wrapper.m_playersTF._width += 50;
            wrapper.m_timerTF._x -= 20;
            wrapper.m_timerTF._width += 50;
        }
        else
        {
            // align: center
            wrapper.m_titleTF._x -= 300;
            wrapper.m_titleTF._width += 600;
            wrapper.m_titleTF._height = 600;
            setupTextField(wrapper.m_titleTF, "title");

            // align: right
            wrapper.m_playersTF._x -= 200;
            wrapper.m_playersTF._width += 200;
            wrapper.m_playersTF._height = 600;
            setupTextField(wrapper.m_playersTF, "players");

            // align: left
            wrapper.m_timerTF._x -= 20;
            wrapper.m_timerTF._width += 200;
            wrapper.m_timerTF._height = 600;
            setupTextField(wrapper.m_timerTF, "timer");

            // align: center
            wrapper.m_pointsTF._x -= 300;
            wrapper.m_pointsTF._width += 600;
            wrapper.m_pointsTF._height = 600;
            setupTextField(wrapper.m_pointsTF, "points");
        }
    }

    // override
    public function configUIImpl()
    {
        //Logger.add("CaptureBar.configUI");

        base.configUI();

        if (!Config.config.captureBar.enabled)
        {
            wrapper.m_playersTF.htmlText = "<font size='15' face='xvm'>&#x113;</font>  " + wrapper.m_vehiclesCount;
            wrapper.m_timerTF.htmlText = "<font size='15' face='xvm'>&#x114;</font>  " + wrapper.m_timeLeft;
        }
        else
        {
            m_baseNumText = DAAPI.py_xvm_captureBarGetBaseNumText(wrapper.id);
            updateTextFields();
        }
    }

    // override
    public function updateCaptureDataImpl(points, rate, timeLeft, vehiclesCount)
    {
        //Logger.add("CaptureBar.updateCaptureData: " + arguments);

        base.updateCaptureData(points, rate, timeLeft, vehiclesCount);

        if (!Config.config.captureBar.enabled)
        {
            wrapper.m_playersTF.htmlText = "<font size='15' face='xvm'>&#x113;</font>  " + wrapper.m_vehiclesCount;
            wrapper.m_timerTF.htmlText = "<font size='15' face='xvm'>&#x114;</font>  " + wrapper.m_timeLeft;
        }
        else
        {
            updateTextFields();
        }
    }

    // override
    public function updateTitleImpl()
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
        tf._x += Macros.FormatGlobalNumberValue(c.x, 0);
        tf._y += Macros.FormatGlobalNumberValue(c.y, 0);
        tf.filters = [new DropShadowFilter(
            0, // distance
            0, // angle
            Macros.FormatGlobalNumberValue(c.shadow.color, 0x000000),
            Macros.FormatGlobalNumberValue(c.shadow.alpha, 100) / 100.0,
            Macros.FormatGlobalNumberValue(c.shadow.blur, 1),
            Macros.FormatGlobalNumberValue(c.shadow.blur, 1),
            Macros.FormatGlobalNumberValue(c.shadow.strength, 1))];
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
