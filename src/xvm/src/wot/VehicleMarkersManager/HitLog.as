/**
 * ...
 * @author Maxim Schedriviy
 */
import wot.utils.Defines;
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
    private var align:String;
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
        align = cfg.align;
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
        textField.htmlText = "<font face='$FieldFont' size='15' color='#F4EFE8'>" + txt + "</font>";
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
            setText(last + "\n" + historyText.join("\n"));
            historyText.pop();
            historyText.unshift(hist);
        }
        else
        {
            setText(historyText.join("\n") + "\n" + last);
            historyText.shift();
            historyText.push(hist);
        }
    }

    private function createControl()
    {
        //Logger.add("HitLog::createControl()");
        // TODO: x,y < 0
        textField = _root.createTextField("xvmHitLog", _root.getNextHighestDepth(), x, y, w, h);
        textField.antiAliasType = "advanced";
        var textFormat: TextFormat = _root.debugPanel.fgMC.fps.getNewTextFormat();
        textFormat.align = align;
        textField.multiline = true;
        textField.wordWrap = false;
        textField.html = true;
        textField.setNewTextFormat(textFormat);
        textField.filters = [new flash.filters.DropShadowFilter(1, 90, 0, 100, 5, 5, 1.5, 3)];

        var txt = formatText(format, 0, "", "", 0, "");
        if (direction != Defines.DIRECTION_DOWN)
            txt = historyText.join("\n") + "\n" + txt;
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

            format = format.split("{{hit-kind}}").join(damageType); // TODO: Localize

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
