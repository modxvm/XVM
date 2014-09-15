package com.xvm.types.dossier
{
    import com.xvm.*;
    import com.xvm.types.veh.*;
    import net.wg.data.daapi.base.DAAPIDataClass;

    public class VehicleDossierCut extends DAAPIDataClass
    {
        public function VehicleDossierCut(vehId:int, data:Object)
        {
            super(data);
            var vdata:VehicleData = VehicleInfo.get(vehId);
            if (vdata != null)
            {
                name = vdata.localizedName;
                sysname = vdata.key.replace(":", "-");
                shortname = vdata.shortName;
                type = vdata.vtype;
                level = vdata.level;
                rlevel = Defines.ROMAN_LEVEL[vdata.level - 1];
                nation = vdata.nation;
                premium = vdata.premium ? "premium" : "";
                battletiermin = vdata.tierLo;
                battletiermax = vdata.tierHi;
                shootRange = NaN; //TODO: vdata.artyRadius || vdata.firingRadius;
                viewRange = NaN; //TODO: vdata.visRadius;
            }
        }

        public var vehId:int;
        public var battles:int;
        public var wins:int;
        public var mastery:int;
        public var xp:int;

        // from vehicleData
        public var name:String;
        public var sysname:String;
        public var shortname:String;
        public var type:String;
        public var level:int;
        public var rlevel:String;
        public var nation:String;
        public var premium:String;
        public var battletiermin:int;
        public var battletiermax:int;
        public var shootRange:Number;
        public var viewRange:Number;
    }
}
