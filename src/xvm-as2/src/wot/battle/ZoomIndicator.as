/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
import com.xvm.*;
import com.xvm.DataTypes.*;
import com.xvm.events.*;
import flash.filters.*;

class wot.battle.ZoomIndicator extends XvmComponent
{
    private var cfg:Object;
    private var zoomIndicator:TextField;

    private var x:Number;
    private var y:Number;
    private var offsetX:Number;
    private var offsetY:Number;

    public function ZoomIndicator()
    {
        try
        {
            cfg = Config.config.battle.camera.sniper.zoomIndicator;
            zoomIndicator = createZoomIndicatorTextField();
            GlobalEventDispatcher.addEventListener(Defines.E_UPDATE_STAGE, this, onBattleStateChanged);
            GlobalEventDispatcher.addEventListener(Events.E_BATTLE_STATE_CHANGED, this, onBattleStateChanged);
            update(false, 0);
        }
        catch (ex:Error)
        {
            Logger.add(ex.message);
        }
    }

    public function update(enable, zoom)
    {
        if (enable)
        {
            zoomIndicator._visible = true;
            Macros.RegisterZoomIndicatorData(zoom);
            updateTextField(zoomIndicator);
        }
        else
        {
            zoomIndicator._visible = false;
        }
    }

    public function onOffsetUpdate(offsetX:Number, offsetY: Number):Void
    {
        this.offsetX = offsetX;
        this.offsetY = offsetY;
        invalidate();
    }

    public function draw():Void
    {
        var value;
        var needAlign:Boolean = false;
        var textField:TextField = zoomIndicator;

        value = offsetX + x;
        if (textField._x != value)
        {
            textField._x = value;
            needAlign = true;
        }

        value = offsetY + y;
        if (textField._y != value)
        {
            textField._y = value;
            needAlign = true;
        }

        if (needAlign)
            alignField(textField);
    }

    public function onBattleStateChanged()
    {
        if (zoomIndicator._visible)
            updateTextField(zoomIndicator);
    }

    // PRIVATE

    private function createZoomIndicatorTextField():TextField
    {
        var width:Number = Macros.FormatGlobalNumberValue(cfg.width);
        var height:Number = Macros.FormatGlobalNumberValue(cfg.height);
        var textField:TextField = _root.createTextField("zoomIndicator", _root.getNextHighestDepth(), 0, 0, width, height);
        textField.antiAliasType = "advanced";
        textField.html = true;
        textField.wordWrap = false;
        textField.multiline = true;
        textField.selectable = false;
        var align:String = cfg.align != null ? cfg.align : "left";
        var valign:String = cfg.valign != null ? cfg.valign : "none";
        textField.setNewTextFormat(new TextFormat("$FieldFont", 12, 0xFFFFFF, false, false, false, "", "", align));
        textField.autoSize = "none";
        textField.verticalAlign = valign;
        textField._alpha = Macros.FormatGlobalNumberValue(cfg.alpha);

        textField.border = cfg.borderColor != null;
        textField.borderColor = Macros.FormatGlobalNumberValue(cfg.borderColor);
        textField.background = cfg.bgColor != null;
        textField.backgroundColor = Macros.FormatGlobalNumberValue(cfg.bgColor);
        if (textField.background && !textField.border)
        {
            cfg.borderColor = cfg.bgColor;
            textField.border = true;
            textField.borderColor = textField.backgroundColor;
        }

        var shadow:Object = cfg.shadow;
        if (shadow && shadow.alpha && shadow.strength && shadow.blur)
        {
            var blur:Number = Macros.FormatGlobalNumberValue(shadow.blur);
            textField.filters = [
                new DropShadowFilter(
                    Macros.FormatGlobalNumberValue(shadow.distance),
                    Macros.FormatGlobalNumberValue(shadow.angle),
                    Macros.FormatGlobalNumberValue(shadow.color),
                    Macros.FormatGlobalNumberValue(shadow.alpha) / 100.0,
                    blur,
                    blur,
                    Macros.FormatGlobalNumberValue(shadow.strength))
            ];
        }

        cleanupFormat(textField);
        alignField(textField);

        return textField;
    }

    // cleanup formats without macros to remove extra checks
    private function cleanupFormat(field)
    {
        if (cfg.width != null && (typeof cfg.width != "string" || cfg.width.indexOf("{{") < 0))
            delete cfg.width;
        if (cfg.height != null && (typeof cfg.height != "string" || cfg.height.indexOf("{{") < 0))
            delete cfg.height;
        if (cfg.alpha != null && (typeof cfg.alpha != "string" || cfg.alpha.indexOf("{{") < 0))
            delete cfg.alpha;
        if (cfg.borderColor != null && (typeof cfg.borderColor != "string" || cfg.borderColor.indexOf("{{") < 0))
            delete cfg.borderColor;
        if (cfg.bgColor != null && (typeof cfg.bgColor != "string" || cfg.bgColor.indexOf("{{") < 0))
            delete cfg.bgColor;
    }

    private function updateTextField(textField:TextField):Void
    {
        var value;
        var needAlign:Boolean = false;

        x = Macros.FormatGlobalNumberValue(cfg.x);
        y = Macros.FormatGlobalNumberValue(cfg.y);
        invalidate();

        if (cfg.width != null)
        {
            value = Macros.FormatGlobalNumberValue(cfg.width);
            if (textField._width != value)
            {
                textField._width = value;
                needAlign = true;
            }
        }

        if (cfg.height != null)
        {
            value = Macros.FormatGlobalNumberValue(cfg.height);
            if (textField._height != value)
            {
                textField._height = value;
                needAlign = true;
            }
        }

        if (needAlign)
            alignField(textField);

        if (cfg.alpha != null)
        {
            value = Macros.FormatGlobalNumberValue(cfg.alpha);
            if (textField._alpha != value)
                textField._alpha = value;
        }

        if (cfg.borderColor != null)
        {
            value = Macros.FormatGlobalNumberValue(cfg.borderColor);
            if (textField.borderColor != value)
                textField.borderColor = value;
        }

        if (cfg.bgColor != null)
        {
            value = Macros.FormatGlobalNumberValue(cfg.bgColor);
            if (textField.backgroundColor != value)
                textField.backgroundColor = value;
        }

        if (cfg.format != null)
        {
            value = Macros.FormatGlobalStringValue(cfg.format);
            //Logger.add(value + " <= " + cfg.format);
            textField.htmlText = value;
        }
    }

    private function alignField(textField:TextField)
    {
        var align:String = cfg.align;
        var valign:String = cfg.valign;
        if (align == "right")
            textField._x -= textField._width;
        else if (align == "center")
            textField._x -= textField._width / 2;
        if (valign == "bottom")
            textField._y -= textField._height;
        else if (valign == "center")
            textField._y -= textField._height / 2;
    }
}
