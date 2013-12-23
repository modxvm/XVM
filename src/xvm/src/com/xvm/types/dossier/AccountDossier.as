package com.xvm.types.dossier
{
    import com.xvm.*;
    import net.wg.data.daapi.base.DAAPIDataClass;

    public class AccountDossier extends DAAPIDataClass
    {
        public function AccountDossier(data:Object)
        {
            var vehiclesData:Object = data.vehicles;
            delete data.vehicles;

            super(data);

            vehicles = {};
            for (var vehId:String in vehiclesData)
            {
                vehicles[vehId] = new VehicleDossierItem(vehiclesData[vehId]);
                vehicles[vehId].vehId = vehId;
            }
        }

        public var playerId:int;
        public var battles:int;
        public var wins:int;
        public var losses:int;
        public var survived:int;
        public var frags:int;
        public var shots:int;
        public var hits:int;
        public var spotted:int;
        public var damageDealt:int;
        public var damageReceived:int;
        public var capture:int;
        public var defence:int;
        public var winAndSurvived:int;
        public var vehicles:Object;
    }
}
