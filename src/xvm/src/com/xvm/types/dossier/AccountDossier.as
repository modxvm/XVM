package com.xvm.types.dossier
{
    import com.xvm.*;
    import com.xvm.misc.*;
    import com.xvm.types.veh.*;
    import net.wg.data.daapi.base.DAAPIDataClass;

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

            vehicles = {};
            for (var vehId:String in vehiclesData)
            {
                vehicles[vehId] = new VehicleDossierCut(vehiclesData[vehId]);
                vehicles[vehId].vehId = vehId;
            }
        }

        public var maxXPVehId:int;
        public var maxFragsVehId:int;
        public var maxDamageVehId:int;

        public var creationTime:uint;
        public var lastBattleTime:uint;
        public var lastBattleTimeStr:String;

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
