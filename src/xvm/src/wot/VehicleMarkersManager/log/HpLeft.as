/**
 * @author ilitvinov87@gmail.com
 */
import com.xvm.Logger;
import wot.VehicleMarkersManager.log.HitLog;

class wot.VehicleMarkersManager.log.HpLeft
{
    private var model:Array = [];
   
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
        for (var i in model)
        {
            var player = model[i];
            if (player.curHealth == 0)
            {
                /**
                 * The only way to keep track of dead is to check markers health.
                 * Markers draw distance is restriction.
                 * VehicleMarkersManagers sandbox does not
                 * know when someone dies out of sight.
                 */
                continue;
            }
            text += "<font color='#FFFFFF'>" + player.vType + "</font>";
            text += "   <font color='#FF9999'>" + player.curHealth + "</font>";
            text += "    <font color='#BBBBBB'>" + player.pFullName + "</font>";
            text += "<br/>";
        }
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
