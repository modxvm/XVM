import wot.VehicleMarkersManager.log.HitLog;
import wot.VehicleMarkersManager.log.HpLog;
import com.xvm.Logger;

/**
 * @author ilitvinov87@gmail.com
 */
class wot.VehicleMarkersManager.log.LogLists
{
    private var cfg:Object;
    private var hitLog:HitLog;
    private var hpLog:HpLog;
    
    public function LogLists(cfg:Object) 
    {
        this.cfg = cfg;
        if (cfg.visible)
        {
            hitLog = new HitLog(cfg);
        }
        if (cfg.hpLeft)
        {
            hpLog = new HpLog(cfg);
        }
        hitLog.setHitText(); // updateText();
    }
    
    public function onNewMarkerCreated(vClass, vIconSource, vType, vLevel, pFullName, curHealth, maxHealth):Void
    {
        var player:Object = {
            vClass: vClass, vIconSource: vIconSource, vType: vType, vLevel: vLevel,
            pFullName: pFullName, curHealth: curHealth, maxHealth: maxHealth };
        hpLog.onNewMarkerCreated(player);
        
        updateText();
    }
    
    public function updateHealth(delta:Number, curHealth:Number, vehicleName:String, icon:String, playerName:String,
        level:Number, damageType:String, vtype:String, vtypeColor:String, dead:Boolean, curAbsoluteHealth:Number)
    {
        hitLog.update(delta, curHealth, vehicleName, icon, playerName,
        level, damageType, vtype, vtypeColor, dead);
        hpLog.onHealthUpdate(playerName, curAbsoluteHealth);
        
        updateText();
    }
    
    private function updateText():Void
    {
        //Logger.add("hpLog.getText() " + hpLog.getText());
        //hitLog.setHpText(hpLog.getText());
        hitLog.setHitText();
    }
}
