/**
 * @author ilitvinov87@gmail.com
 */
import com.xvm.*;
import com.xvm.DataTypes.VehicleData;
import wot.VehicleMarkersManager.log.HitLog;

class wot.VehicleMarkersManager.log.HpLeft
{
    private var model:Array = [];
    private var format:String;
    private var header:String;
    private var direction:Number;

    public function HpLeft(cfg:Object)
    {
        format = Locale.get(cfg.hpLeft.format);
        header = Locale.get(cfg.hpLeft.header);
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

            //Logger.addObject(player);
            entries += (entries == "" ? "" : "<br/>") + Macros.Format(player.pFullName, format, player);
        }

        text += (direction == Defines.DIRECTION_DOWN) ? header + "<br/>" + entries : entries + "<br/>" + header;
        text += "</span>";
        return text;
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
