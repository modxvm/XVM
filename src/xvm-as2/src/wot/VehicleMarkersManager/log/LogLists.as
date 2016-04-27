import com.xvm.*;
import wot.VehicleMarkersManager.*;
import wot.VehicleMarkersManager.log.*;

/**
 * @author ilitvinov87@gmail.com
 */
class wot.VehicleMarkersManager.log.LogLists
{
    private var cfg:Object;
    private var hitLog:HitLog;
    private var hpLeft:HpLeft;
    private var hpLeftEnabled:Boolean;

    private var altPressed:Boolean = false;

    public function LogLists(cfg:Object)
    {
        this.cfg = cfg;

        // Delayed initialization
        var $this = this;
        _global.setTimeout(function() { $this._initialize(); }, 1);
    }

    private function _initialize()
    {
        if (Macros.FormatGlobalBooleanValue(cfg.visible))
        {
            hitLog = new HitLog(cfg);
        }
        hpLeftEnabled = Macros.FormatGlobalBooleanValue(cfg.hpLeft.enabled);
        if (hpLeftEnabled)
        {
            hpLeft = new HpLeft(cfg);	/** hpleft also has to respect direction, so cannot simply pass in cfg.hpleft */
        }
        updateText();
        GlobalEventDispatcher.addEventListener(VMMEvent.ALT_STATE_INFORM, this, onAltStateInform);
    }

    /** Invoked by VMM */
    public function onNewMarkerCreated(vClass, vIconSource, vType, vLevel, pFullName, pName, pClan, pRegion, curHealth, maxHealth):Void
    {
        var player:Object = {
            vClass: vClass,
            vIconSource: vIconSource,
            vType: vType,
            vLevel: vLevel,
            pFullName: pFullName,
            pName: pName,
            pClan: pClan,
            pRegion: pRegion,
            curHealth: curHealth,
            maxHealth: maxHealth
        };

        if (hpLeft)
            hpLeft.onNewMarkerCreated(player);

        updateText();
    }

    /** Invoked by VMM */
    public function onHpUpdate(flag:Number, delta:Number, curHealth:Number, vehicleName:String, icon:String, playerName:String,
        level:Number, damageType:String, vtype:String, vtypeColor:String, dead:Boolean, curAbsoluteHealth:Number)
    {
        if (!hitLog)
            return;

        /** Update Hitlog */
        if (flag == Defines.FROM_PLAYER)
        {
            if (!Utils.isArenaGuiTypeWithPlayerPanels() || !UnitDestroyedAccounting.instance.diedSomeTimeAgo(playerName))
            {
                hitLog.update(delta, curHealth, vehicleName, icon, playerName, level, damageType, vtype, vtypeColor, dead);
            }
        }

        /** Update HP log */
        if (hpLeft)
            hpLeft.onHealthUpdate(playerName, curAbsoluteHealth);

        updateText();
    }

    /** Show prepared Hitlog or HP log text depending on cfg and Alt button */
    private function updateText():Void
    {
        if (!hitLog)
            return;

        if (altPressed && hpLeftEnabled)
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
        var eventAltPressed:Boolean = Boolean(event.value);
        if (altPressed != eventAltPressed)
        {
            altPressed = eventAltPressed;
            updateText();
        }
    }
}
