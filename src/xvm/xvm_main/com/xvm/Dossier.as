/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm
{
    import com.xfw.*;
    import com.xvm.types.dossier.*;

    public class Dossier
    {
        // PUBLIC STATIC

        public static function requestAccountDossier(target:Object, callback:Function, battleType:String, playerId:Number = 0):void
        {
            loadDossierInternal(target, callback, battleType, playerId, 0);
        }

        public static function requestVehicleDossier(target:Object, callback:Function, battleType:String, vehCD:Number, playerId:Number = 0):void
        {
            loadDossierInternal(target, callback, battleType, playerId, vehCD);
        }

        public static function getAccountDossier(playerId:int = 0):AccountDossier
        {
            return getDossier(playerId, 0);
        }

        public static function getVehicleDossier(vehCD:int, playerId:int = 0):VehicleDossier
        {
            return getDossier(playerId, vehCD);
        }

        public static function setVehicleDossier(vdossier:VehicleDossier):void
        {
            _setVehicleDossier(vdossier);
        }

        // PRIVATE

        // Private vars
        private static var _initialized:Boolean = false;
        private static var _requests:Object = {};
        private static var _cache:Object = {};

        private static function loadDossierInternal(target:Object, callback:Function, battleType:String, playerId:int, vehCD:int):void
        {
            if (!_initialized)
            {
                _initialized = true;
                Xfw.addCommandListener(XvmCommandsInternal.AS_DOSSIER, dossierLoaded);
            }

            var key:String = playerId + "," + vehCD;
            //Logger.add("loadDossier: " + key);
            if (_requests[key] == null)
                _requests[key] = [];
            if (callback != null)
                _requests[key].push( { target: target, callback: callback } );
            Xfw.cmd(XvmCommandsInternal.REQUEST_DOSSIER, battleType, playerId, vehCD);
        }

        private static function dossierLoaded(playerId:int, vehCD:int, data:Object):Object
        {
            try
            {
                var key:String = playerId + "," + vehCD;
                //Logger.addObject(data, 3, key);

                var dossier:* = (vehCD == 0)
                    ? new AccountDossier(data)
                    : new VehicleDossier(data);

                _cache[key] = dossier;

                if (vehCD != 0)
                {
                    var adossier:AccountDossier = getAccountDossier(playerId);
                    if (adossier != null)
                    {
                        var vehicle:VehicleDossierCut = adossier.vehicles[vehCD];
                        if (vehicle != null)
                            vehicle.update();
                    }
                }

                var targets:Array = _requests[key];
                delete _requests[key];

                if (targets != null)
                {
                    for each (var target:Object in targets)
                        target.callback.call(target.target, dossier);
                }
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }

            return null;
        }

        private static function getDossier(playerId:int, vehCD:int):*
        {
            return _cache[playerId + "," + vehCD];
        }

        private static function _setVehicleDossier(vdossier:VehicleDossier):*
        {
            _cache[vdossier.playerId + "," + vdossier.vehCD] = vdossier;
        }
    }
}
