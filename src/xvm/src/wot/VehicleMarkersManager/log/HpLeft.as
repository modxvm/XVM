/**
 * @author ilitvinov87@gmail.com
 */
import com.xvm.Defines;
import com.xvm.GraphicsUtil;
import com.xvm.Locale;
import com.xvm.Utils;
import com.xvm.VehicleInfo;
import wot.VehicleMarkersManager.log.HitLog;


class wot.VehicleMarkersManager.log.HpLeft
{
    private var model:Array = [];
    private var format:String;
    private var header:String;
    private var direction:Number;

    public function HpLeft(cfg:Object)
    {
        format = Locale.formatMacros(cfg.hpLeft.format);
        header = Locale.formatMacros(cfg.hpLeft.header);
        direction = cfg.direction.toLowerCase() == "up" ? Defines.DIRECTION_UP : Defines.DIRECTION_DOWN;
    }

    public function onNewMarkerCreated(player:Object):Void
    {
        var loggerPlayer:Object = getLoggedPlayer(player.pFullName);
        if (loggerPlayer == null)
        {
            /** Append new player to HP logging model */
            model.push(player);
        }
        else if (loggerPlayer.curHealth != player.curHealth)
        {
            /** Enemy health can actually have been changed while he was out of sight */
            onHealthUpdate(player.pFullName, player.curHealth);
        }
    }

    public function onHealthUpdate(pFullName:String, curHealth:Number):Void
    {
        var player:Object = getLoggedPlayer(pFullName);
        player.curHealth = curHealth;
    }

    // -- Private

    public function getText():String
    {
        var text:String = "<span class='" + HitLog.STYLE_NAME + "'>";
        var entries:String = "";

        for (var i in model)
        {
            var player = model[i];
            if (player.curHealth <= 0)
            {
                /**
                 * The only way to keep track of dead is to check markers health.
                 * Markers draw distance is restriction.
                 * VehicleMarkersManagers sandbox does not
                 * know when someone dies out of sight.
                 */
                continue;
            }

            entries += (entries == "" ? "" : "<br/>") + formatText(format, player);
        }

        text += (direction == Defines.DIRECTION_DOWN) ? header + "<br/>" + entries : entries + "<br/>" + header;
        text += "</span>";
        return text;
    }

    private function formatText(format:String, player:Object):String
    {
        // mostly copied 1:1 from HitLog.as, HitLog.formatText
        // TODO: Macros optimization - use com.xvm.Macros class

        if (format.indexOf("{{") == -1)
            return Utils.fixImgTag(format);

        try
        {
            // available fields on "player": vClass, vIconSource, vType, vLevel, pFullName, curHealth, maxHealth

            var formatArr:Array;
            formatArr = format.split("{{nick}}");
            if (formatArr.length > 1)
                format = formatArr.join(player.pFullName);
            formatArr = format.split("{{name}}");
            if (formatArr.length > 1)
                format = formatArr.join(Utils.GetPlayerName(player.pFullName));
            formatArr = format.split("{{clan}}");
            if (formatArr.length > 1)
                format = formatArr.join(Utils.GetClanNameWithBrackets(player.pFullName));
            formatArr = format.split("{{clannb}}");
            if (formatArr.length > 1)
                format = formatArr.join(Utils.GetClanName(player.pFullName));

            formatArr = format.split("{{vehicle}}");
            if (formatArr.length > 1)
                format = formatArr.join(player.vType);
            formatArr = format.split("{{vehiclename}}");
            if (formatArr.length > 1)
                format = formatArr.join(VehicleInfo.getVehicleName(player.vIconSource));
            formatArr = format.split("{{vtype}}");
            if (formatArr.length > 1)
                format = formatArr.join(Locale.get(VehicleInfo.GetVTypeValue(player.vIconSource)));
            formatArr = format.split("{{c:vtype}}");
            if (formatArr.length > 1)
                format = formatArr.join(GraphicsUtil.GetVTypeColorValue(player.vIconSource, VehicleInfo.GetVTypeValue(player.vIconSource)));
            formatArr = format.split("{{level}}");
            if (formatArr.length > 1)
                format = formatArr.join(player.vLevel);
            formatArr = format.split("{{rlevel}}");
            if (formatArr.length > 1)
                format = formatArr.join(Defines.ROMAN_LEVEL[player.vLevel - 1]);


            formatArr = format.split("{{hp}}");
            if (formatArr.length > 1)
                format = formatArr.join(player.curHealth);
            formatArr = format.split("{{c:hp}}");
            if (formatArr.length > 1)
                format = formatArr.join(GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_HP, player.curHealth));
            formatArr = format.split("{{a:hp}}");
            if (formatArr.length > 1)
                format = formatArr.join(GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_ALPHA_HP, player.curHealth));
            formatArr = format.split("{{hp-max}}");
            if (formatArr.length > 1)
                format = formatArr.join(player.maxHealth);
            formatArr = format.split("{{hp-ratio}}");
            if (formatArr.length > 1)
                format = formatArr.join(Math.round(player.curHealth / player.maxHealth * 100).toString());
            formatArr = format.split("{{c:hp-ratio}}");
            if (formatArr.length > 1)
                format = formatArr.join(GraphicsUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_HP_RATIO, player.curHealth / player.maxHealth * 100));
            formatArr = format.split("{{a:hp-ratio}}");
            if (formatArr.length > 1)
                format = formatArr.join(GraphicsUtil.GetDynamicAlphaValue(Defines.DYNAMIC_ALPHA_HP_RATIO,
                                        Math.round(player.curHealth / player.maxHealth * 100)).toString());

            //format = Utils.trim(format);
        }
        catch (e)
        {
            format = "Error: " + String(e);
        }

        return Utils.fixImgTag(format);
    }

    private function getLoggedPlayer(pFullName:String):Object
    {
        for (var i in model)
        {
            if (model[i].pFullName == pFullName)
            {
                return model[i];
            }
        }

        return null;
    }
}
