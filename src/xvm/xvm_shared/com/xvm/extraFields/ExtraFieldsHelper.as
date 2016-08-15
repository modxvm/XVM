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
    import flash.utils.Timer;
    import mx.utils.*;
    import scaleform.gfx.*;

    public class ExtraFieldsHelper
    {
        public static function setupEvents(field:IExtraField):void
        {
            if (field.cfg.updateEvent)
            {
                var events:Array = field.cfg.updateEvent.split(",");
                if (events.length)
                {
                    for each (var event:String in events)
                    {
                        switch (StringUtil.trim(event).toUpperCase())
                        {
                            case "ON_BATTLE_STATE_CHANGED":
                                Xvm.addEventListener(PlayerStateEvent.CHANGED, field.updateOnEvent);
                                break;
                            case "ON_PLAYERS_HP_CHANGED":
                                Xvm.addEventListener(PlayerStateEvent.PLAYERS_HP_CHANGED, field.updateOnEvent);
                                break;
                            case "ON_VEHICLE_DESTROYED":
                                Xvm.addEventListener(PlayerStateEvent.VEHICLE_DESTROYED, field.updateOnEvent);
                                break;
                            case "ON_CURRENT_VEHICLE_DESTROYED":
                                Xvm.addEventListener(PlayerStateEvent.CURRENT_VEHICLE_DESTROYED, field.updateOnEvent);
                                break;
                            case "ON_MODULE_DESTROYED":
                                Xvm.addEventListener(PlayerStateEvent.MODULE_DESTROYED, field.updateOnEvent);
                                break;
                            case "ON_MODULE_REPAIRED":
                                Xvm.addEventListener(PlayerStateEvent.MODULE_REPAIRED, field.updateOnEvent);
                                break;
                            case "ON_DAMAGE_CAUSED":
                                Xvm.addEventListener(PlayerStateEvent.DAMAGE_CAUSED, field.updateOnEvent);
                                break;
                            case "ON_TARGET_CHANGED":
                                Xvm.addEventListener(PlayerStateEvent.ON_TARGET_CHANGED, field.updateOnEvent);
                                break;
                            case "ON_PANEL_MODE_CHANGED":
                                Xvm.addEventListener(PlayerStateEvent.ON_PANEL_MODE_CHANGED, field.updateOnEvent);
                                break;
                            case "ON_EVERY_FRAME":
                                Xvm.addEventListener(PlayerStateEvent.ON_EVERY_FRAME, field.updateOnEvent);
                                if (!timerFrame)
                                {
                                    initTimerFrame();
                                }
                                break;
                            case "ON_EVERY_SECOND":
                                Xvm.addEventListener(PlayerStateEvent.ON_EVERY_SECOND, field.updateOnEvent);
                                if (!timerSec)
                                {
                                    initTimerSec();
                                }
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

        // PRIVATE

        private static var timerFrame:Timer = null;
        private static var timerSec:Timer = null;

        private static function initTimerFrame():void
        {
            timerFrame = new Timer(1);
            timerFrame.addEventListener(TimerEvent.TIMER, function():void
            {
                Xvm.dispatchEvent(new PlayerStateEvent(PlayerStateEvent.ON_EVERY_FRAME));
            });
            timerFrame.start();
        }

        private static function initTimerSec():void
        {
            timerSec = new Timer(1000);
            timerSec.addEventListener(TimerEvent.TIMER, function():void
            {
                Xvm.dispatchEvent(new PlayerStateEvent(PlayerStateEvent.ON_EVERY_SECOND));
            });
            timerSec.start();
        }
    }
}
