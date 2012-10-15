/**
 * ...
 * @author Maxim Schedriviy
 */
import wot.utils.Config;
import wot.utils.Defines;
import wot.utils.GraphicsUtil;
import wot.utils.Locale;
import wot.utils.Logger;
import wot.utils.Utils;
import wot.VehicleMarkersManager.XvmHelper;

class wot.VehicleMarkersManager.HitLog
{
    // dummy var to avoid import warning
    private static var __dummy = Logger.dummy;

    private var x:Number;
    private var y:Number;
    private var w:Number;
    private var h:Number;
    private var lines:Number;
    private var direction:Number;
    private var format:String;
    private var formatHistory:String;

    private var nHits:Number;
    private var total:Number;
    private var fire_total:Number;
    private var fire_hist:String;
    private var historyText:Array;
    
    private var textField:TextField;

    public function HitLog(cfg:Object)
    {
        x = cfg.x;
        y = cfg.y;
        w = cfg.w;
        h = cfg.h;
        lines = Math.min(100, Math.max(1, cfg.lines));
        direction = cfg.direction.toUpperCase() == "UP" ? Defines.DIRECTION_UP : Defines.DIRECTION_DOWN;
        format = cfg.format;
        formatHistory = cfg.formatHistory;

        nHits = 0;
        total = 0;
        fire_total = 0;
        fire_hist = "";
        if (lines > 1)
        {
            historyText = [];
            for (var i = 0; i < lines - 1; ++i)
                historyText.push("");
        }

        createControl();
    }

    function setText(txt)
    {
        textField.htmlText = "<span class='xvm_hitlog'>" + txt + "</span>";
        //Logger.add(textField.htmlText);
    }

    public function update(delta:Number, vehicleName:String, playerName:String, level:Number, damageType:String, vtypeColor:String)
    {
        if (damageType != "fire" || fire_total == 0)
            nHits++;
        total += delta;
        fire_total = damageType == "fire" ? fire_total + delta : 0;
        //wot.utils.Logger.add(delta + " " + vehicleName + " " + playerName + " " + level);

        var last:String = formatText(format, damageType == "fire" ? fire_total : delta, vehicleName, playerName, level,
            damageType, vtypeColor);
        if (lines <= 1)
        {
            setText(last);
            return;
        }

        var hist:String = formatText(formatHistory || format, damageType == "fire" ? fire_total : delta,
            vehicleName, playerName, level, damageType, vtypeColor);
        if (direction == Defines.DIRECTION_DOWN)
        {
            if (damageType == "fire")
                fire_hist = hist;
            else if (fire_hist != "")
            {
                historyText.unshift(fire_hist);
                fire_hist = "";
            }

            setText(last + "<br/>" + historyText.join("<br/>"));
            if (damageType != "fire")
            {
                historyText.pop();
                historyText.unshift(hist);
            }
        }
        else
        {
            if (damageType == "fire")
                fire_hist = hist;
            else if (fire_hist != "")
            {
                historyText.push(fire_hist);
                fire_hist = "";
            }
            setText(historyText.join("<br/>") + "<br/>" + last);
            if (damageType != "fire")
            {
                historyText.shift();
                historyText.push(hist);
            }
        }
    }

    private function createControl()
    {
        //Logger.add("HitLog::createControl()");
        var x = this.x >= 0 ? this.x : Config.s_vars.window_size[0] + this.x;
        var y = this.y >= 0 ? this.y : Config.s_vars.window_size[1] + this.y;

        textField = _root.createTextField("xvmHitLog", _root.getNextHighestDepth(), x, y, w, h);
        //textField.border = true;
        //textField.borderColor = 0xFFFFFF;
        textField.verticalAlign = (direction == Defines.DIRECTION_DOWN) ? "top" : "bottom";
        textField.antiAliasType = "advanced";
        textField.multiline = true;
        textField.wordWrap = false;
        textField.filters = [new flash.filters.DropShadowFilter(1, 90, 0, 100, 5, 5, 1.5, 3)];

        textField.html = true;
        var style:TextField.StyleSheet = new TextField.StyleSheet();
        style.parseCSS(".xvm_hitlog {font-family:$FieldFont; font-size:15px; color:#F4EFE8;}");
        textField.styleSheet = style;

        var txt = formatText(format, 0, "", "", 0, "");
        if (direction != Defines.DIRECTION_DOWN)
            txt = historyText.join("<br/>") + "<br/>" + txt;
        setText(txt);
    }

    private function formatText(format:String,
        delta:Number, vehicleName:String, playerName:String, level:Number, damageType:String, vtypeColor:String):String
    {
        try
        {
            var formatArr:Array;
            formatArr = format.split("{{n}}");
            if (formatArr.length > 1)
                format = formatArr.join(String(nHits));
            formatArr = format.split("{{dmg}}");
            if (formatArr.length > 1)
                format = formatArr.join(String(delta));
            formatArr = format.split("{{dmg-total}}");
            if (formatArr.length > 1)
                format = formatArr.join(String(total));
            formatArr = format.split("{{nick}}");
            if (formatArr.length > 1)
                format = formatArr.join(playerName);
            formatArr = format.split("{{vehicle}}");
            if (formatArr.length > 1)
                format = formatArr.join(vehicleName);
            formatArr = format.split("{{level}}");
            if (formatArr.length > 1)
                format = formatArr.join(String(level));
            formatArr = format.split("{{rlevel}}");
            if (formatArr.length > 1)
                format = formatArr.join(XvmHelper.rlevel[level - 1]);
            formatArr = format.split("{{dmg-kind}}");
            if (formatArr.length > 1)
                format = formatArr.join(Locale.get(damageType));
            formatArr = format.split("{{c:dmg-kind}}");
            if (formatArr.length > 1)
                format = formatArr.join(delta ? GraphicsUtil.GetDmgKindValue(damageType) : "")
            formatArr = format.split("{{c:dmg_kind}}");
            if (formatArr.length > 1)
                format = formatArr.join(delta ? GraphicsUtil.GetDmgKindValue(damageType) : "")
            formatArr = format.split("{{c:vtype}}");
            if (formatArr.length > 1)
                format = formatArr.join(vtypeColor);

            format = Utils.trim(format);
        }
        catch (e)
        {
            format = "Error: " + String(e);
        }

        return format + '</font>';
    }
}
