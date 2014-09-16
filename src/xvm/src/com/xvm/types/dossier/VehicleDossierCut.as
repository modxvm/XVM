package com.xvm.types.dossier
{
    import com.xvm.*;
    import com.xvm.utils.*;
    import com.xvm.types.veh.*;
    import net.wg.data.daapi.base.DAAPIDataClass;

    public class VehicleDossierCut extends DAAPIDataClass
    {
        public function VehicleDossierCut(vehId:int, data:Object)
        {
            super(data);

            // Vehicle Data
            var vdata:VehicleData = VehicleInfo.get(vehId);
            if (vdata != null)
            {
                name = vdata.localizedName;
                sysname = vdata.key.replace(":", "-");
                shortname = vdata.shortName;
                type = VehicleInfo.getVTypeText(vdata.vtype);
                c_type = MacrosUtil.GetVClassColorValue(vdata);
                level = vdata.level;
                rlevel = Defines.ROMAN_LEVEL[vdata.level - 1];
                nation = vdata.nation;
                premium = vdata.premium ? "premium" : "";
                battletiermin = vdata.tierLo;
                battletiermax = vdata.tierHi;
                shootRange = NaN; //TODO: vdata.artyRadius || vdata.firingRadius;
                viewRange = NaN; //TODO: vdata.visRadius;
            }

            // Calculations
            c_battles = MacrosUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_TBATTLES, battles, "#");
            winrate = (isNaN(battles) || battles <= 0) ? NaN : (wins / battles) * 100;
            c_winrate = MacrosUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_RATING, winrate, "#");
        }

        public var vehId:int;
        public var battles:Number = NaN;
        public var wins:Number = NaN;
        public var mastery:Number = NaN;
        public var xp:Number = NaN;

        // from vehicleData
        public var name:String;
        public var sysname:String;
        public var shortname:String;
        public var type:String;
        public var c_type:String;
        public var level:int;
        public var rlevel:String;
        public var nation:String;
        public var premium:String;
        public var battletiermin:int;
        public var battletiermax:int;
        public var shootRange:Number;
        public var viewRange:Number;

        // calculated
        public var c_battles:String;
        public var winrate:Number;
        public var c_winrate:String;
    }
}
