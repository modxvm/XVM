/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm
{
    import com.xfw.*;
    import com.xvm.types.dossier.*;

    public class Dossier
    {
        // PUBLIC STATIC

        public static function requestAccountDossier(target:Object, callback:Function, battleType:String, accountDBID:Number = 0):void
        {
            loadDossierInternal(target, callback, battleType, accountDBID, 0);
        }

        public static function requestVehicleDossier(target:Object, callback:Function, battleType:String, vehCD:Number, accountDBID:Number = 0):void
        {
            loadDossierInternal(target, callback, battleType, accountDBID, vehCD);
        }

        public static function getAccountDossier(accountDBID:int = 0):AccountDossier
        {
            //Logger.add("getAccountDossier: accountDBID=" + accountDBID);
            return getDossier(accountDBID, 0);
        }

        public static function getVehicleDossier(vehCD:int, accountDBID:int = 0):VehicleDossier
        {
            //Logger.add("getVehicleDossier: vehCD=" + vehCD + ", accountDBID=" + accountDBID);
            return vehCD != 0 ? getDossier(accountDBID, vehCD) : null;
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

        private static function loadDossierInternal(target:Object, callback:Function, battleType:String, accountDBID:int, vehCD:int):void
        {
            if (!_initialized)
            {
                _initialized = true;
                Xfw.addCommandListener(XvmCommandsInternal.AS_DOSSIER, dossierLoaded);
            }

            var key:String = accountDBID + "," + vehCD;
            //Logger.add("loadDossier: " + key);
            if (_requests[key] == null)
                _requests[key] = [];
            if (callback != null)
                _requests[key].push( { target: target, callback: callback } );
            Xfw.cmd(XvmCommandsInternal.REQUEST_DOSSIER, battleType, accountDBID, vehCD);
        }

        private static function dossierLoaded(accountDBID:int, vehCD:int, data:Object):Object
        {
            try
            {
                var key:String = accountDBID + "," + vehCD;
                //Logger.addObject(data, 3, key);

                var dossier:* = (vehCD == 0)
                    ? new AccountDossier(data)
                    : new VehicleDossier(data);

                _cache[key] = dossier;

                if (vehCD != 0)
                {
                    var adossier:AccountDossier = getAccountDossier(accountDBID);
                    if (adossier)
                    {
                        var vehicle:VehicleDossierCut = adossier.vehicles[vehCD];
                        if (vehicle)
                            vehicle.update();
                    }
                }

                var targets:Array = _requests[key];
                delete _requests[key];

                if (targets)
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

        private static function getDossier(accountDBID:int, vehCD:int):*
        {
            return _cache[accountDBID + "," + vehCD];
        }

        private static function _setVehicleDossier(vdossier:VehicleDossier):*
        {
            _cache[vdossier.accountDBID + "," + vdossier.vehCD] = vdossier;
        }
    }
}
