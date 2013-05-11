import wot.VehicleMarkersManager.log.HitLog;
import wot.VehicleMarkersManager.log.HpLeft;
import com.xvm.Logger;
import com.xvm.Defines;
import com.xvm.GlobalEventDispatcher;
import wot.VehicleMarkersManager.VMMEvent;

/**
 * @author ilitvinov87@gmail.com
 */
class wot.VehicleMarkersManager.log.LogLists
{
    private var cfg:Object;
    private var hitLog:HitLog;
    private var hpLeft:HpLeft;
    
    private var altPressed:Boolean = false;
    
    public function LogLists(cfg:Object) 
    {
        this.cfg = cfg;
        if (cfg.visible)
        {
            hitLog = new HitLog(cfg);
        }
        if (cfg.hpLeft)
        {
            hpLeft = new HpLeft();
        }
        updateText();
        GlobalEventDispatcher.addEventListener(VMMEvent.ALT_STATE_INFORM, this, onAltStateInform);
    }
    
    /** Invoked by VMM */
    public function onNewMarkerCreated(vClass, vIconSource, vType, vLevel, pFullName, curHealth, maxHealth):Void
    {
        var player:Object = {
            vClass: vClass, vIconSource: vIconSource, vType: vType, vLevel: vLevel,
            pFullName: pFullName, curHealth: curHealth, maxHealth: maxHealth };
        hpLeft.onNewMarkerCreated(player);
        
        updateText();
    }
    
    /** Invoked by VMM */
    public function onHpUpdate(flag:Number, delta:Number, curHealth:Number, vehicleName:String, icon:String, playerName:String,
        level:Number, damageType:String, vtype:String, vtypeColor:String, dead:Boolean, curAbsoluteHealth:Number)
    {
        /** Update Hitlog */
        if (flag == Defines.FROM_PLAYER)
        {
            hitLog.update(delta, curHealth, vehicleName, icon, playerName,
            level, damageType, vtype, vtypeColor, dead);
        }
        
        /** Update HP log */
        hpLeft.onHealthUpdate(playerName, curAbsoluteHealth);
        
        updateText();
    }
    
    /** Show prepared Hitlog or HP log text depending on cfg and Alt button */
    private function updateText():Void
    {
        if (altPressed && cfg.hpLeft)
        {
            hitLog.setHpText(hpLeft.getText());
        }
        else
        {
            hitLog.setHitText();
        }
    }
    
    /** Catches Alt press event from VMM */
    private function onAltStateInform(event:VMMEvent):Void
    {
        var eventAltPressed:Boolean = Boolean(event.payload);
        if (altPressed != eventAltPressed)
        {
            altPressed = eventAltPressed;
            updateText();
        }
    }
}
