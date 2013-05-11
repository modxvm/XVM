/**
 * @author ilitvinov87@gmail.com
 */
import com.greensock.plugins.ColorMatrixFilterPlugin;
import com.xvm.Logger;
import wot.VehicleMarkersManager.log.HpLogView;

class wot.VehicleMarkersManager.log.HpLeft
{
    private var model:Array = [];
   
    public function onNewMarkerCreated(player:Object):Void
    {
        Logger.add("####### onNewMarkerCreated " + player.pFullName + " " + player.curHealth);
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
        Logger.add("####### onHealthUpdate " + curHealth + " " + pFullName);
        var player:Object = getLoggedPlayer(pFullName);
        player.curHealth = curHealth;
    }
    
    // -- Private
    
    public function getText():String
    {
        var text:String = "<span class='xvm_hitlog'>";
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
                break;
            }
            text += /* player.pFullName + */ " " + player.vType + " " + player.curHealth + "<br/>";
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
