/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.extraFields
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.battle.*;
    import com.xvm.battle.events.*;
    import com.xvm.battle.vo.VOPlayerState;
    import com.xvm.types.cfg.*;
    import com.xvm.vo.*;
    import flash.events.*;
    import flash.text.*;
    import flash.geom.*;
    import mx.utils.*;
    import scaleform.gfx.*;

    public class ExtraFieldsHelper
    {
        public static function setupEvents(field:IExtraField):void
        {
            if (field.cfg.updateEvent != null && field.cfg.updateEvent.length > 0)
            {
                var events:Array = field.cfg.updateEvent.split(",");
                if (events.length > 0)
                {
                    for each (var event:String in events)
                    {
                        switch (StringUtil.trim(event).toUpperCase())
                        {
                            case "ON_BATTLE_STATE_CHANGED":
                                Xvm.addEventListener(PlayerStateEvent.CHANGED, field.updateOnEvent);
                                break;
                            case "ON_PLAYERS_HP_CHANGED":
                                Xvm.addEventListener(PlayerStateEvent.HP_CHANGED, field.updateOnEvent);
                                break;
                            case "ON_VEHICLE_DESTROYED":
                                Xvm.addEventListener(PlayerStateEvent.DEAD, field.updateOnEvent);
                                break;
                            case "ON_CURRENT_VEHICLE_DESTROYED":
                                Xvm.addEventListener(PlayerStateEvent.SELF_DEAD, field.updateOnEvent);
                                break;
                            case "ON_MODULE_DESTROYED":
                                Xvm.addEventListener(PlayerStateEvent.MODULE_DESTROYED, field.updateOnEvent);
                                break;
                            case "ON_MODULE_REPAIRED":
                                Xvm.addEventListener(PlayerStateEvent.MODULE_REPAIRED, field.updateOnEvent);
                                break;
                        }
                    }
                }
            }

            if (field.cfg.hotKeyCode != null)
            {
                Xfw.addCommandListener(XvmCommands.AS_ON_KEY_EVENT, field.onKeyEvent);
                field.visible = !field.cfg.visibleOnHotKey;
            }
        }
    }
}
