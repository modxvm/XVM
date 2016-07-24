/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.battle.hitlog
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.battle.vo.*;
    import com.xvm.types.cfg.*;
    import flash.events.*;
    import net.wg.infrastructure.interfaces.entity.*;

    public class Hitlog implements IDisposable
    {
        private var cfg:CHitlog;

        public function Hitlog()
        {
            registerHitlogMacros();
            Xvm.addEventListener(Defines.XVM_EVENT_CONFIG_LOADED, onConfigLoaded);
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
            cfg = Config.config.hitLog;
        }

        private function getHeader():String
        {
            return "header";
        }

        private function getBody():String
        {
            return "body";
        }
    }
}
