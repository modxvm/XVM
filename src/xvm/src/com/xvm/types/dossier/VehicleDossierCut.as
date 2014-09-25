package com.xvm.types.dossier
{
    import com.xvm.*;
    import com.xvm.misc.*;
    import com.xvm.types.veh.*;
    import com.xvm.utils.*;
    import net.wg.data.daapi.base.DAAPIDataClass;

    public class VehicleDossierCut extends DAAPIDataClass
    {
        public function VehicleDossierCut(vehId:int, data:Object)
        {
            super(data);

            this.vehId  = vehId;

            this.xp /= battles;

            update();
        }

        public function update():void
        {
            // Vehicle Data
            var vdata:VehicleData = VehicleInfo.get(vehId);
            if (vdata != null)
            {
                fullname = vdata.localizedFullName;
                name = vdata.localizedName;
                sysname = vdata.key.replace(":", "-");
                shortname = vdata.shortName;
                type = VehicleInfo.getVTypeText(vdata.vtype);
                c_type = MacrosUtil.GetVClassColorValue(vdata);
                level = vdata.level;
                rlevel = Defines.ROMAN_LEVEL[vdata.level - 1];
                nation = vdata.nation;
                premium = vdata.premium ? "premium" : null;
                maxHP = vdata.hpTop;
                battletiermin = vdata.tierLo;
                battletiermax = vdata.tierHi;
                shootRange = NaN; //TODO: vdata.artyRadius || vdata.firingRadius;
                viewRange = NaN; //TODO: vdata.visRadius;
                wn8expd = vdata.wn8expDamage;
            }

            // Calculations
            if (battles > 0)
            {
                kb = battles / 1000.0;
                hb = battles / 100.0;
                c_battles = MacrosUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_TBATTLES, battles, "#");
                winrate = wins / battles * 100;
                c_winrate = MacrosUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_RATING, winrate, "#");

                var vdossier:VehicleDossier = Dossier.getVehicleDossier(vehId);
                if (vdossier != null)
                {
                    hitsRatio = vdossier.hitsRatio * 100;
                    tdb = vdossier.avgDamageDealt;
                    c_tdb = MacrosUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_TDB, tdb, "#");
                    tdv = vdossier.damageDealt / (battles * maxHP);
                    c_tdv = MacrosUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_TDV, tdv, "#");
                    tfb = vdossier.avgFrags;
                    c_tfb = MacrosUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_TFB, tfb, "#");
                    tsb = vdossier.avgSpotted;
                    c_tsb = MacrosUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_TSB, tsb, "#");
                    //teff =
                    //e =
                    //c_e =
                    if (wn8expd > 0)
                    {
                        wn8effd = tdb / wn8expd;
                        c_wn8effd = MacrosUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_WN8EFFD, wn8effd, "#");
                    }

                    marksOnGun = isNaN(vdossier.marksOnGun) || level < 5 ? null : Utils.getMarksOnGunText(vdossier.marksOnGun);
                    damageRating = vdossier.damageRating;
                    c_damageRating = MacrosUtil.GetDynamicColorValue(Defines.DYNAMIC_COLOR_DAMAGERATING, damageRating, "#");
                }
            }
        }

        public var vehId:int;
        public var battles:Number = NaN;
        public var kb:Number = NaN;
        public var hb:Number = NaN;
        public var wins:Number = NaN;
        public var mastery:Number = NaN;
        public var xp:Number = NaN;

        // from vehicleData
        public var fullname:String;
        public var name:String;
        public var sysname:String;
        public var shortname:String;
        public var type:String;
        public var c_type:String;
        public var level:int;
        public var rlevel:String;
        public var nation:String;
        public var premium:String;
        public var maxHP:Number;
        public var battletiermin:int;
        public var battletiermax:int;
        public var shootRange:Number;
        public var viewRange:Number;

        // calculated
        public var c_battles:String;
        public var winrate:Number;
        public var c_winrate:String;
        public var hitsRatio:Number;
        public var tdb:Number;
        public var c_tdb:String;
        public var tdv:Number;
        public var c_tdv:String;
        public var tfb:Number;
        public var c_tfb:String;
        public var tsb:Number;
        public var c_tsb:String;
        public var teff:Number;
        public var e:Number;
        public var c_e:String;
        public var wn8expd:Number;
        public var wn8effd:Number;
        public var c_wn8effd:String;
        public var marksOnGun:String;
        public var damageRating:Number;
        public var c_damageRating:String;

        // extra
        public var elite:String;
    }
}
