/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.types.dossier
{
    import com.xfw.*;
    import com.xvm.*;
    import net.wg.data.constants.*;

    public class AccountDossier extends DossierBase
    {
        public function AccountDossier(data:Object)
        {
            var vehiclesData:Object = data.vehicles;
            delete data.vehicles;

            super(data);

            // https://ci.modxvm.com/sonarqube/coding_rules?open=flex%3AS1447&rule_key=flex%3AS1447
            _init(vehiclesData, data);
        }

        private function _init(vehiclesData:Object, data:Object):void
        {
            if (data.maxXPVehCD)
                _maxXPVehicleName = VehicleInfo.get(maxXPVehCD).localizedFullName;
            if (data.maxFragsVehCD)
                _maxFragsVehicleName = VehicleInfo.get(maxFragsVehCD).localizedFullName;
            if (data.maxDamageVehCD)
                _maxDamageVehicleName = VehicleInfo.get(maxDamageVehCD).localizedFullName;

            vehicles = {};
            for (var vehCD:String in vehiclesData)
                vehicles[vehCD] = new VehicleDossierCut(parseInt(vehCD), vehiclesData[vehCD]);
        }

        public var maxXPVehCD:int;
        public var maxFragsVehCD:int;
        public var maxDamageVehCD:int;

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

        public function getVehicleDossierCut(vehCD:int):VehicleDossierCut
        {
            if (!(vehCD in vehicles))
                vehicles[vehCD] = new VehicleDossierCut(vehCD, { } );
            return vehicles[vehCD];
        }
    }
}
