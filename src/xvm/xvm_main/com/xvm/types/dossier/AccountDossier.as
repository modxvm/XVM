/**
 * XFW
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.types.dossier
{
    import com.xfw.*;
    import net.wg.data.constants.*;

    public class AccountDossier extends DossierBase
    {
        public function AccountDossier(data:Object)
        {
            var vehiclesData:Object = data.vehicles;
            delete data.vehicles;

            super(data);

            if (data.maxXPVehId)
                _maxXPVehicleName = VehicleInfo.get(maxXPVehId).localizedFullName;
            if (data.maxFragsVehId)
                _maxFragsVehicleName = VehicleInfo.get(maxFragsVehId).localizedFullName;
            if (data.maxDamageVehId)
                _maxDamageVehicleName = VehicleInfo.get(maxDamageVehId).localizedFullName;

            //vehicles = {};
            //for (var vehId:String in vehiclesData)
            //    vehicles[vehId] = new VehicleDossierCut(parseInt(vehId), vehiclesData[vehId]);
        }

        public var maxXPVehId:int;
        public var maxFragsVehId:int;
        public var maxDamageVehId:int;

        public var creationTime:uint;
        public var lastBattleTime:uint;
        public var lastBattleTimeStr:String = Values.EMPTY_STR;

        public var vehicles:Object;

        // Calculated
        private var _maxXPVehicleName:String = '';
        public function get maxXPVehicleName():String
        {
            return _maxXPVehicleName;
        }

        private var _maxFragsVehicleName:String = '';
        public function get maxFragsVehicleName():String
        {
            return _maxFragsVehicleName;
        }

        private var _maxDamageVehicleName:String = '';
        public function get maxDamageVehicleName():String
        {
            return _maxDamageVehicleName;
        }
    }
}
