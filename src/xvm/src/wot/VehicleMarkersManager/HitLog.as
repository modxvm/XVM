/**
 * ...
 * @author Maxim Schedriviy
 */
import wot.utils.Config;
import wot.utils.Defines;
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

    public function update(delta:Number, vehicleName:String, playerName:String, level:Number, damageType:String)
    {
        nHits++;
        total += delta;
        //wot.utils.Logger.add(delta + " " + vehicleName + " " + playerName + " " + level);

        var last:String = formatText(format, delta, vehicleName, playerName, level, damageType);
        if (lines <= 1)
        {
            setText(last);
            return;
        }

        var hist:String = formatText(formatHistory || format, delta, vehicleName, playerName, level, damageType);
        if (direction == Defines.DIRECTION_DOWN)
        {
            setText(last + "<br/>" + historyText.join("<br/>"));
            historyText.pop();
            historyText.unshift(hist);
        }
        else
        {
            setText(historyText.join("<br/>") + "<br/>" + last);
            historyText.shift();
            historyText.push(hist);
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
        delta:Number, vehicleName:String, playerName:String, level:Number, damageType:String):String
    {
        try
        {
            format = format.split("{{n}}").join(String(nHits));
            format = format.split("{{dmg}}").join(String(delta));
            format = format.split("{{dmg-total}}").join(String(total));

            format = format.split("{{nick}}").join(playerName);
            format = format.split("{{vehicle}}").join(vehicleName);
            format = format.split("{{level}}").join(String(level));
            format = format.split("{{rlevel}}").join(XvmHelper.rlevel[level - 1]);

            format = format.split("{{dmg-kind}}").join(Locale.get(damageType));

            // TODO: Stats macros

            format = Utils.trim(format);
        }
        catch (e)
        {
            format = "Error: " + String(e);
        }

        return format + '</font>';
    }
}
