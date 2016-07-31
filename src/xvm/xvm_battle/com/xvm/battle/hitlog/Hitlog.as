/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.battle.hitlog
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xfw.events.ObjectEvent;
    import com.xvm.battle.*;
    import com.xvm.battle.vo.*;
    import com.xvm.types.cfg.*;
    import flash.events.*;
    import net.wg.infrastructure.interfaces.entity.*;

    public class Hitlog implements IDisposable
    {
        private static const INSERTORDER_BEGIN:String = "begin";
        private static const INSERTORDER_END:String = "end";

        private var cfg:CHitlog;

        private var _lastTotalDamageHeader:int;
        private var _lastTotalDamageBody:int;
        private var _headerText:String;
        private var _bodyText:String;

        public function Hitlog()
        {
            registerHitlogMacros();
            Xvm.addEventListener(Defines.XVM_EVENT_CONFIG_LOADED, onConfigLoaded);
            Xvm.addEventListener(BattleEvents.HITLOG_UPDATED, onHitlogUpdated);
            setup();
        }

        public final function dispose():void
        {
            onDispose();
        }

        protected function onDispose():void
        {
            Xvm.removeEventListener(Defines.XVM_EVENT_CONFIG_LOADED, onConfigLoaded);
        }

        // PRIVATE

        private function registerHitlogMacros():void
        {
            // {{hitlog-header}}
            Macros.Globals["hitlog-header"] = getHeader;
            // {{hitlog-body}}
            Macros.Globals["hitlog-body"] = getBody;
        }

        private function onConfigLoaded(e:Event):void
        {
            setup();
        }

        private function setup():void
        {
            cfg = Config.config.hitLog.clone();
            cfg.defaultHeader = Locale.get(cfg.defaultHeader);
            cfg.formatHeader = Locale.get(cfg.formatHeader);
            cfg.formatHistory = Locale.get(cfg.formatHistory);
            _lastTotalDamageHeader = -1;
            _lastTotalDamageBody = -1;
        }

        private function getHeader(o:VOPlayerState):String
        {
            if (_lastTotalDamageHeader != BattleState.hitlogTotalDamage)
            {
                _lastTotalDamageHeader = BattleState.hitlogTotalDamage;
                _headerText = Macros.Format(BattleState.hitlogHits.length ? cfg.formatHeader : cfg.defaultHeader, o);
            }
            return _headerText;
        }

        private function onHitlogUpdated(e:ObjectEvent):void
        {
            var hist:String = Macros.Format(cfg.formatHistory, e.result as VOPlayerState);
            var hits:Array = BattleState.hitlogHits;
            hits[hits.length - 1].hist = hist;
        }

        private function getBody(o:VOPlayerState):String
        {
            if (_lastTotalDamageBody != BattleState.hitlogTotalDamage)
            {
                _lastTotalDamageBody = BattleState.hitlogTotalDamage;

                var hits:Array = BattleState.hitlogHits;
                if (!hits.length)
                {
                    return null;
                }

                //Logger.addObject(hits, 2);

                var skip:Vector.<Number> = new Vector.<Number>();
                _bodyText = "";
                for (var n:int = hits.length - 1; n >= 0; --n)
                {
                    var hit:VOHit = hits[n];
                    if (cfg.groupHitsByPlayer)
                    {
                        if (skip.indexOf(hit.vehicleID) != -1)
                            continue;
                        skip.push(hit.vehicleID);
                    }
                    var br:String = (_bodyText == "") ? "" : "<br/>";
                    if (cfg.insertOrder.toLowerCase() == INSERTORDER_BEGIN)
                    {
                        _bodyText += br + hit.hist;
                    }
                    else
                    {
                        _bodyText = hit.hist + br + _bodyText;
                    }
                }
            }
            return _bodyText;
        }
    }
}
