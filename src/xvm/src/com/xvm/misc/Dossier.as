/**
 * XVM
 * @author Maxim Schedriviy <m.schedriviy@gmail.com>
 */
package com.xvm.misc
{
    import com.xvm.*;
    import com.xvm.io.*;
    import com.xvm.types.dossier.*;
    import flash.external.*;
    import net.wg.gui.lobby.profile.pages.technique.data.*;

    public class Dossier
    {
        private static var _initialized:Boolean = false;

        private static var _requests:Object = {};

        private static var _cache:Object = {};

        public static function get(playerId:int = 0):AccountDossier
        {
            return _cache[playerId];
        }

        private static function init():void
        {
            if (_initialized)
                return;

            _initialized = true;

            ExternalInterface.addCallback(Cmd.RESPOND_DOSSIER, dossierLoaded);
        }

        public static function loadDossier(target:Object, callback:Function, playerId:* = null):void
        {
            init();
            var key:int = int(playerId || 0);
            if (_requests[key] == null)
                _requests[key] = [];
            _requests[key].push( { target: target, callback: callback } );
            Cmd.getDossier(playerId);
        }

        private static function dossierLoaded(playerId:int, str:String):void
        {
            try
            {
                var acc:AccountDossier = new AccountDossier(JSONx.parse(str));
                _cache[playerId] = acc;
                var targets:Array = _requests[playerId];
                delete _requests[playerId];
                if (targets != null)
                {
                    for each (var target:Object in targets)
                        target.callback.call(target.target, acc);
                }
            }
            catch (e:Error)
            {
                Logger.add(e.getStackTrace());
            }
        }
    }
}
