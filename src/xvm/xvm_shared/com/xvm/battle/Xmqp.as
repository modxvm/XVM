/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.battle
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.battle.events.*;
    import flash.utils.*;
    import scaleform.clik.constants.*;

    public class Xmqp
    {
        public static function init():void
        {
            Xfw.addCommandListener(BattleCommands.AS_XMQP_EVENT, onXmqpEvent);
        }

        private static function onXmqpEvent(accountDBID:Number, eventName:String, data:Object):void
        {
            Logger.add(eventName + " " + accountDBID + " " + JSONx.stringify(data));
            switch (eventName)
            {
                case XmqpEvent.XMQP_HOLA:
                    onHolaEvent(accountDBID, data);
                    break;
                case XmqpEvent.XMQP_FIRE:
                    onFireEvent(accountDBID, data);
                    break;
                case XmqpEvent.XMQP_VEHICLE_TIMER:
                    onVehicleTimerEvent(accountDBID, data);
                    break;
                case XmqpEvent.XMQP_SPOTTED:
                    onSpottedEvent(accountDBID);
                    break;
                case XmqpEvent.XMQP_MINIMAP_CLICK:
                    Xvm.dispatchEvent(new XmqpEvent(eventName, accountDBID, data));
                    break;
                case XmqpEvent.XMQP_DEATH_ZONE_TIMER:
                    onDeathZoneTimerEvent(accountDBID, data);
                    break;
                default:
                    Logger.add("WARNING: unknown xmqp event: " + eventName);
                    break;
            }
        }

        // xmqp events

        // {{x-enabled}}
        // {{x-sense-on}}

        private static function onHolaEvent(accountDBID:Number, data:Object):void
        {
            var updated:Boolean = BattleState.get(BattleState.getVehicleIDByAccountDBID(accountDBID)).update({
                xmqpData: {
                    x_enabled: true,
                    x_sense_on: Boolean(data.sixthSense)
                }
            });
            if (updated)
            {
                BattleState.instance.invalidate(InvalidationType.STATE);
                Xvm.dispatchEvent(new XmqpEvent(XmqpEvent.XMQP_HOLA, accountDBID));
            }
        }

        // {{x-fire}}

        private static function onFireEvent(accountDBID:Number, data:Object):void
        {
            var updated:Boolean = BattleState.get(BattleState.getVehicleIDByAccountDBID(accountDBID)).update( {
                xmqpData: {
                    x_fire: data.enable
                }
            });
            if (updated)
            {
                BattleState.instance.invalidate(InvalidationType.STATE);
                Xvm.dispatchEvent(new XmqpEvent(XmqpEvent.XMQP_FIRE, accountDBID));
            }
        }

        // {{x-overturned}}
        // {{x-drowning}}

        private static function onVehicleTimerEvent(accountDBID:Number, data:Object):void
        {
            // TODO
            /*
            var updated:Boolean = false;
            switch (data.code)
            {
                case Defines.VEHICLE_MISC_STATUS_VEHICLE_IS_OVERTURNED:
                    updated = BattleState.get(BattleState.getVehicleIDByAccountDBID(accountDBID)).update({
                        xmqpData: {
                            x_overturned: data.enable
                        }
                    });
                    break;

                case Defines.VEHICLE_MISC_STATUS_VEHICLE_DROWN_WARNING:
                    updated = BattleState.get(BattleState.getVehicleIDByAccountDBID(accountDBID)).update({
                        xmqpData: {
                            x_drowning: data.enable
                        }
                    });
                    break;

                case Defines.VEHICLE_MISC_STATUS_ALL:
                    updated = BattleState.get(BattleState.getVehicleIDByAccountDBID(accountDBID)).update({
                        xmqpData: {
                            x_overturned: data.enable
                        }
                    });
                    updated = BattleState.get(BattleState.getVehicleIDByAccountDBID(accountDBID)).update({
                        xmqpData: {
                            x_drowning: data.enable
                        }
                    }) || updated;
                    break;

                default:
                    Logger.add("WARNING: unknown vehicle timer code: " + data.code);
            }

            if (updated)
            {
                BattleState.instance.invalidate(InvalidationType.STATE);
                Xvm.dispatchEvent(new XmqpEvent(XmqpEvent.XMQP_VEHICLE_TIMER, accountDBID));
            }
            */
        }

        // {{x-spotted}}

        private static var _sixSenseIndicatorTimeoutIds:Object = {};

        private static function onSpottedEvent(accountDBID:Number):void
        {
            var updated:Boolean = BattleState.get(BattleState.getVehicleIDByAccountDBID(accountDBID)).update({
                xmqpData: {
                    x_spotted: true
                }
            });
            if (updated)
            {
                BattleState.instance.invalidate(InvalidationType.STATE);
                Xvm.dispatchEvent(new XmqpEvent(XmqpEvent.XMQP_SPOTTED, accountDBID));
            }
            if (_sixSenseIndicatorTimeoutIds[accountDBID])
            {
                clearTimeout(_sixSenseIndicatorTimeoutIds[accountDBID]);
            }
            _sixSenseIndicatorTimeoutIds[accountDBID] = setTimeout(function():void { onSpottedEventDone(accountDBID); }, Config.config.xmqp.spottedTime * 1000);
        }

        private static function onSpottedEventDone(accountDBID:Number):void
        {
            delete _sixSenseIndicatorTimeoutIds[accountDBID];
            var updated:Boolean = BattleState.get(BattleState.getVehicleIDByAccountDBID(accountDBID)).update({
                xmqpData: {
                    x_spotted: false
                }
            });
            if (updated)
            {
                BattleState.instance.invalidate(InvalidationType.STATE);
                Xvm.dispatchEvent(new XmqpEvent(XmqpEvent.XMQP_SPOTTED, accountDBID));
            }
        }

        // TODO {{x-deathzone}}

        private static function onDeathZoneTimerEvent(accountDBID:Number, data:Object):void
        {
            // TODO
        }
    }
}
