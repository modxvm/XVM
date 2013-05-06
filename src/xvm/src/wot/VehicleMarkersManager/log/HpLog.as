/**
 * @author ilitvinov87@gmail.com
 */
import com.xvm.Logger;

class wot.VehicleMarkersManager.log.HpLog
{
    private var cfg:Object;
    private var model:Array = [];
    
    public function HpLog(cfg:Object) 
    {
        this.cfg = cfg;
    }
    
    public function onNewMarkerCreated(vClass:String, vIconSource:String, vType:String,
                                       vLevel:Number, pFullName:String,
                                       curHealth:Number, maxHealth:Number):Void
    {
        var playerObject:Object = {
            vClass: vClass, vIconSource: vIconSource, vType: vType, vLevel: vLevel,
            pFullName: pFullName, curHealth: curHealth, maxHealth: maxHealth }
            
        var loggedPlayer:Object = getLoggedPlayer(pFullName);
        if (loggedPlayer == null)
        {
            /** Append new player to logging */
            model.push(playerObject);
            redrawList();
        }
        else
        {
            /** Check if player health changed since last encounter */
            if (loggedPlayer.curHealth != playerObject.curHealth)
            {
                loggedPlayer.curHealth = playerObject.curHealth;
                redrawList();
            }
        }
    }
   
    public function onHealthUpdate(pFullName:String, curHealthAbsolute:Number):Void
    {
        if (curHealthAbsolute != 0)
        {
            var loggedPlayer:Object = getLoggedPlayer(pFullName);
            loggedPlayer.curHealth = curHealthAbsolute;
            redrawList();
        }
        else
        {
            onEnemyDied(pFullName);
        }
    }
    
    public function onEnemyDied():Void
    {
        // remove from model
        redrawList();
    }
    
    // -- Private
    
    private function redrawList():Void
    {
        
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
