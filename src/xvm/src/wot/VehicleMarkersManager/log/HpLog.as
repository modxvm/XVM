/**
 * @author ilitvinov87@gmail.com
 */
import com.xvm.Logger;
import wot.VehicleMarkersManager.log.HpLogView;

class wot.VehicleMarkersManager.log.HpLog
{
    private var cfg:Object;
    private var model:Array = [];
    private var view:HpLogView;
    
    public function HpLog(cfg:Object) 
    {
        this.view = HpLogView(cfg);
    }
    
    public function onNewMarkerCreated(vClass:String, vIconSource:String, vType:String,
                                       vLevel:Number, pFullName:String,
                                       curHealth:Number, maxHealth:Number):Void
    {
        var player:Object = {
            vClass: vClass, vIconSource: vIconSource, vType: vType, vLevel: vLevel,
            pFullName: pFullName, curHealth: curHealth, maxHealth: maxHealth }
        
        var loggerPlayer:Object = getLoggedPlayer(pFullName);
        if (loggerPlayer == null)
        {
            /** Append new player to logging */
            model.push(player);
            redrawLog();
        }
        else if (loggerPlayer.curHealth != curHealth)
        {
            /** Enemy health can actually have been changed while he was out of sight */
            onHealthUpdate(pFullName, curHealth);
        }
    }
    
    public function onHealthUpdate(pFullName:String, curHealth:Number):Void
    {
        var player:Object = getLoggedPlayer(pFullName);
        player.curHealth = curHealth;
        
        redrawLog();
    }
    
    // -- Private
    
    private function redrawLog():Void
    {
        view.update(model);
    }
    
    private function getLoggedPlayer(pFullName):Object
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
