/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * http://www.modxvm.com/
 */
package com.xvm.types.dossier
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.vo.*;
    import net.wg.data.daapi.base.*;

    public class VehicleDossierCut extends DAAPIDataClass
    {
        public function VehicleDossierCut(vehCD:int, data:Object)
        {
            super(data);

            this.vehCD  = vehCD;

            this.xp /= battles;

            update();
        }

        public function update():void
        {
            // Vehicle Data
            var vdata:VOVehicleData = VehicleInfo.get(vehCD);
            if (vdata)
            {
                fullname = vdata.localizedFullName;
                name = vdata.localizedName;
                sysname = vdata.key.replace(":", "-");
                shortname = vdata.shortName;
                type = VehicleInfo.getVTypeText(vdata.vtype);
                c_type = MacrosUtils.getVClassColorValue(vdata);
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
                c_battles = MacrosUtils.getDynamicColorValue(Defines.DYNAMIC_COLOR_TBATTLES, battles, "#");
                winrate = wins / battles * 100;
                c_winrate = MacrosUtils.getDynamicColorValue(Defines.DYNAMIC_COLOR_WINRATE, winrate, "#");

                var vdossier:VehicleDossier = Dossier.getVehicleDossier(vehCD);
                if (vdossier)
                {
                    hitsRatio = vdossier.hitsRatio * 100;
                    c_hitsRatio = MacrosUtils.getDynamicColorValue(Defines.DYNAMIC_COLOR_HITSRATIO, hitsRatio, "#");
                    tdb = vdossier.avgDamageDealt;
                    c_tdb = MacrosUtils.getDynamicColorValue(Defines.DYNAMIC_COLOR_TDB, tdb, "#");
                    if (!isNaN(vdossier.xtdb) && vdossier.xtdb > 0)
                    {
                        xtdb = vdossier.xtdb == 100 ? "XX" : (vdossier.xtdb < 10 ? "0" : "") + vdossier.xtdb;
                        c_xtdb = MacrosUtils.getDynamicColorValue(Defines.DYNAMIC_COLOR_X, vdossier.xtdb, "#");
                    }
                    tdv = vdossier.damageDealt / (battles * maxHP);
                    c_tdv = MacrosUtils.getDynamicColorValue(Defines.DYNAMIC_COLOR_TDV, tdv, "#");
                    tfb = vdossier.avgFrags;
                    c_tfb = MacrosUtils.getDynamicColorValue(Defines.DYNAMIC_COLOR_TFB, tfb, "#");
                    tsb = vdossier.avgSpotted;
                    c_tsb = MacrosUtils.getDynamicColorValue(Defines.DYNAMIC_COLOR_TSB, tsb, "#");
                    if (wn8expd > 0)
                    {
                        wn8effd = tdb / wn8expd;
                        c_wn8effd = MacrosUtils.getDynamicColorValue(Defines.DYNAMIC_COLOR_WN8EFFD, wn8effd, "#");
                    }

                    if (!isNaN(vdossier.xte) && vdossier.xte > 0)
                    {
                        xte = vdossier.xte == 100 ? "XX" : (vdossier.xte < 10 ? "0" : "") + vdossier.xte;
                        c_xte = MacrosUtils.getDynamicColorValue(Defines.DYNAMIC_COLOR_X, vdossier.xte, "#");
                    }

                    earnedXP = isNaN(vdossier.earnedXP) || vdossier.earnedXP == 0 ? NaN : vdossier.earnedXP;
                    freeXP = isNaN(vdossier.freeXP) || vdossier.freeXP == 0 ? NaN : vdossier.freeXP;
                    xpToElite = isNaN(vdossier.xpToElite) || vdossier.xpToElite == 0 ? NaN : vdossier.xpToElite;
                    var earnedXPint:int = isNaN(earnedXP) ? 0 : earnedXP;
                    xpToEliteLeft = xpToElite - earnedXPint <= 0 ? NaN : xpToElite - earnedXPint;
                    marksOnGun = isNaN(vdossier.marksOnGun) || level < 5 ? null : Utils.getMarksOnGunText(vdossier.marksOnGun);
                    damageRating = level < 5 ? NaN : vdossier.damageRating;
                    c_damageRating = MacrosUtils.getDynamicColorValue(Defines.DYNAMIC_COLOR_DAMAGERATING, damageRating, "#");
                    rankCount = isNaN(vdossier.rankCount) || vdossier.rankCount == 0 ? NaN : vdossier.rankCount;
                    rankSteps = isNaN(vdossier.rankSteps) || vdossier.rankSteps == 0 ? NaN : vdossier.rankSteps;
                    rankStepsTotal = isNaN(vdossier.rankStepsTotal) || vdossier.rankStepsTotal == 0 ? NaN : vdossier.rankStepsTotal;
                }
            }
        }

        public var vehCD:int;
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
        public var c_hitsRatio:String;
        public var tdb:Number;
        public var c_tdb:String;
        public var xtdb:String;
        public var c_xtdb:String;
        public var tdv:Number;
        public var c_tdv:String;
        public var tfb:Number;
        public var c_tfb:String;
        public var tsb:Number;
        public var c_tsb:String;
        public var wn8expd:Number;
        public var wn8effd:Number;
        public var c_wn8effd:String;
        public var xte:String;
        public var c_xte:String;
        public var earnedXP:Number;
        public var freeXP:Number;
        public var xpToElite:Number;
        public var xpToEliteLeft:Number;
        public var marksOnGun:String;
        public var damageRating:Number;
        public var c_damageRating:String;
        public var rankCount:Number;
        public var rankSteps:Number;
        public var rankStepsTotal:Number;

        // extra
        public var elite:String;
        public var selected:String;
    }
}
