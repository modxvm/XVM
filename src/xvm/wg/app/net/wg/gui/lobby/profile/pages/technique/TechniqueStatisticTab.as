package net.wg.gui.lobby.profile.pages.technique 
{
    import __AS3__.vec.*;
    import flash.text.*;
    import net.wg.data.gui_items.dossier.*;
    import net.wg.gui.lobby.profile.components.*;
    import net.wg.utils.*;
    
    public class TechniqueStatisticTab extends net.wg.gui.lobby.profile.components.ResizableContent
    {
        public function TechniqueStatisticTab()
        {
            super();
            this.firstAlignedGroup = Vector.<net.wg.gui.lobby.profile.components.DashLineTextItem>([this.battlesDL, this.maxExpDL, this.maxKillDL, this.totalKillDL, this.totalDeadDL, this.killRatioDL, this.dealtDmgDL, this.receivedDmgDL, this.dmgRatioDL]);
            this.secontAlignedGroup = Vector.<net.wg.gui.lobby.profile.components.DashLineTextItem>([this.winsDL, this.defeatsDL, this.surviveDL, this.accuracyDL]);
            this.thirdAlignedGroup = Vector.<net.wg.gui.lobby.profile.components.DashLineTextItem>([this.avgExpDL, this.avgKillsDL, this.avgDetectedDL, this.avgDmgDealtDL, this.avgDmgReceivedDL, this.avgScoutingDmgDL]);
            return;
        }

        internal static function makeHtmlText(arg1:String, arg2:uint=16643278):String
        {
            return "<font color=\'#" + arg2.toString(16) + "\'>" + arg1 + "</font>";
        }

        public static function roundDecimal(arg1:Number, arg2:int):Number
        {
            var loc1:*=Math.pow(10, arg2);
            return Math.round(loc1 * arg1) / loc1;
        }

        protected override function configUI():void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=null;
            super.configUI();
            var loc4:*=0;
            var loc5:*=this.firstAlignedGroup;
            for each (loc1 in loc5) 
            {
                loc1.width = 350;
            }
            loc4 = 0;
            loc5 = this.secontAlignedGroup;
            for each (loc2 in loc5) 
            {
                loc2.width = 365;
            }
            loc4 = 0;
            loc5 = this.thirdAlignedGroup;
            for each (loc3 in loc5) 
            {
                loc3.width = 350;
            }
            this.setupLabels();
            this.winsDL.value = convertPercentValue(0);
            this.defeatsDL.value = convertPercentValue(0);
            this.surviveDL.value = convertPercentValue(0);
            this.accuracyDL.value = convertPercentValue(0);
            this.avgScoutingDmgDL.visible = false;
            return;
        }

        internal function setupLabels():void
        {
            this.efficiencyTF.text = PROFILE.SECTION_TECHNIQUE_STATISTICS_EFFENCY;
            this.avgResultsTF.text = PROFILE.SECTION_TECHNIQUE_STATISTICS_AVGSTATS;
            this.battlesDL.label = PROFILE.SECTION_TECHNIQUE_STATISTICS_TOTALBATTLES;
            this.winsDL.label = PROFILE.SECTION_TECHNIQUE_STATISTICS_TOTALWINS;
            this.defeatsDL.label = PROFILE.SECTION_TECHNIQUE_STATISTICS_TOTALDEFEATS;
            this.surviveDL.label = PROFILE.SECTION_TECHNIQUE_STATISTICS_SURVIVAL;
            this.accuracyDL.label = PROFILE.SECTION_TECHNIQUE_STATISTICS_ACCURACY;
            this.maxExpDL.label = PROFILE.SECTION_TECHNIQUE_STATISTICS_MAXEXPERIENCE;
            this.maxKillDL.label = PROFILE.SECTION_TECHNIQUE_STATISTICS_MAXDESTROYEDVEHICLES;
            this.totalKillDL.label = PROFILE.SECTION_TECHNIQUE_STATISTICS_KILLED;
            this.totalDeadDL.label = PROFILE.SECTION_TECHNIQUE_STATISTICS_DESTROYED;
            this.killRatioDL.label = PROFILE.SECTION_TECHNIQUE_STATISTICS_DESTRUCTIONCOEFFICIENT;
            this.killRatioDL.tooltip = PROFILE.PROFILE_PARAMS_TOOLTIP_DESTROYCOEFF;
            this.dealtDmgDL.label = PROFILE.SECTION_TECHNIQUE_STATISTICS_DEALOUTDAMAGE;
            this.receivedDmgDL.label = PROFILE.SECTION_TECHNIQUE_STATISTICS_RECEIVEDDAMAGE;
            this.dmgRatioDL.label = PROFILE.SECTION_TECHNIQUE_STATISTICS_DAMAGECOEFFICIENT;
            this.dmgRatioDL.tooltip = PROFILE.PROFILE_PARAMS_TOOLTIP_DAMAGECOEFF;
            this.avgExpDL.label = PROFILE.SECTION_TECHNIQUE_STATISTICS_AVGEXPERIENCE;
            this.avgKillsDL.label = PROFILE.SECTION_TECHNIQUE_STATISTICS_AVGDESTROYEDVEHICLES;
            this.avgDetectedDL.label = PROFILE.SECTION_TECHNIQUE_STATISTICS_AVGDETECTEDENEMIES;
            this.avgDmgDealtDL.label = PROFILE.SECTION_TECHNIQUE_STATISTICS_AVGDAMAGE;
            this.avgDmgReceivedDL.label = PROFILE.SECTION_TECHNIQUE_STATISTICS_AVGRECEIVEDDAMAGE;
            this.avgScoutingDmgDL.label = PROFILE.SECTION_TECHNIQUE_STATISTICS_AVGSCOUTINGDAMAGE;
            return;
        }

        public override function update(arg1:Object):void
        {
            var loc1:*=net.wg.data.gui_items.dossier.VehicleDossier(arg1);
            if (this._data != loc1) 
            {
                this._data = loc1;
                if (loc1) 
                {
                    this.battlesDL.value = makeHtmlText(loc1.getBattlesCountStr());
                    this.winsDL.value = convertPercentValue(loc1.getWinsEfficiency());
                    this.defeatsDL.value = convertPercentValue(loc1.getLossesEfficiency());
                    this.surviveDL.value = convertPercentValue(loc1.getSurvivalEfficiency());
                    this.accuracyDL.value = convertPercentValue(loc1.getHitsEfficiency());
                    this.maxExpDL.value = makeHtmlText(loc1.getMaxVehicleXPStr());
                    this.maxKillDL.value = makeHtmlText(loc1.getMaxVehicleFragsStr());
                    this.totalKillDL.value = makeHtmlText(loc1.getFragsCountStr());
                    this.totalDeadDL.value = makeHtmlText(loc1.getDeathsCountStr());
                    this.killRatioDL.value = makeHtmlText(loc1.getFragsEfficiencyStr(), 13348216);
                    this.dealtDmgDL.value = makeHtmlText(loc1.getDamageDealtStr());
                    this.receivedDmgDL.value = makeHtmlText(loc1.getDamageReceivedStr());
                    this.dmgRatioDL.value = makeHtmlText(loc1.getDamageEfficiencyStr(), 13348216);
                    this.avgExpDL.value = makeHtmlText(loc1.getAvgXPStr());
                    this.avgKillsDL.value = makeHtmlText(loc1.getAvgFragsStr());
                    this.avgDetectedDL.value = makeHtmlText(loc1.getAvgEnemiesSpottedStr());
                    this.avgDmgDealtDL.value = makeHtmlText(loc1.getAvgDamageDealtStr());
                    this.avgDmgReceivedDL.value = makeHtmlText(loc1.getAvgDamageReceivedStr());
                    this.avgScoutingDmgDL.value = "Will be implemented...";
                }
            }
            return;
        }

        public override function dispose():void
        {
            this._data = null;
            if (this.firstAlignedGroup) 
            {
                this.firstAlignedGroup.splice(0, this.firstAlignedGroup.length);
                this.firstAlignedGroup = null;
            }
            if (this.secontAlignedGroup) 
            {
                this.secontAlignedGroup.splice(0, this.secontAlignedGroup.length);
                this.secontAlignedGroup = null;
            }
            if (this.thirdAlignedGroup) 
            {
                this.thirdAlignedGroup.splice(0, this.thirdAlignedGroup.length);
                this.thirdAlignedGroup = null;
            }
            this.efficiencyTF = null;
            this.avgResultsTF = null;
            this.battlesDL.dispose();
            this.winsDL.dispose();
            this.defeatsDL.dispose();
            this.surviveDL.dispose();
            this.accuracyDL.dispose();
            this.maxExpDL.dispose();
            this.maxKillDL.dispose();
            this.totalKillDL.dispose();
            this.totalDeadDL.dispose();
            this.killRatioDL.dispose();
            this.dealtDmgDL.dispose();
            this.receivedDmgDL.dispose();
            this.dmgRatioDL.dispose();
            this.avgExpDL.dispose();
            this.avgKillsDL.dispose();
            this.avgDetectedDL.dispose();
            this.avgDmgDealtDL.dispose();
            this.avgDmgReceivedDL.dispose();
            this.avgScoutingDmgDL.dispose();
            super.dispose();
            return;
        }

        internal static function convertPercentValue(arg1:Number):String
        {
            var loc1:*=App.utils.locale;
            var loc2:*=loc1.numberWithoutZeros(arg1 * 100);
            return makeHtmlText(loc2) + makeHtmlText(" %", 6513507);
        }

        public var efficiencyTF:flash.text.TextField;

        public var avgResultsTF:flash.text.TextField;

        public var battlesDL:net.wg.gui.lobby.profile.components.DashLineTextItem;

        public var winsDL:net.wg.gui.lobby.profile.components.DashLineTextItem;

        public var defeatsDL:net.wg.gui.lobby.profile.components.DashLineTextItem;

        public var surviveDL:net.wg.gui.lobby.profile.components.DashLineTextItem;

        public var accuracyDL:net.wg.gui.lobby.profile.components.DashLineTextItem;

        public var maxExpDL:net.wg.gui.lobby.profile.components.DashLineTextItem;

        public var maxKillDL:net.wg.gui.lobby.profile.components.DashLineTextItem;

        public var totalKillDL:net.wg.gui.lobby.profile.components.DashLineTextItem;

        public var totalDeadDL:net.wg.gui.lobby.profile.components.DashLineTextItem;

        public var killRatioDL:net.wg.gui.lobby.profile.components.DashLineTextItem;

        public var dealtDmgDL:net.wg.gui.lobby.profile.components.DashLineTextItem;

        public var receivedDmgDL:net.wg.gui.lobby.profile.components.DashLineTextItem;

        public var dmgRatioDL:net.wg.gui.lobby.profile.components.DashLineTextItem;

        internal var secontAlignedGroup:__AS3__.vec.Vector.<net.wg.gui.lobby.profile.components.DashLineTextItem>=null;

        internal var thirdAlignedGroup:__AS3__.vec.Vector.<net.wg.gui.lobby.profile.components.DashLineTextItem>=null;

        internal var _data:net.wg.data.gui_items.dossier.VehicleDossier;

        public var avgKillsDL:net.wg.gui.lobby.profile.components.DashLineTextItem;

        public var avgDetectedDL:net.wg.gui.lobby.profile.components.DashLineTextItem;

        public var avgDmgDealtDL:net.wg.gui.lobby.profile.components.DashLineTextItem;

        public var avgDmgReceivedDL:net.wg.gui.lobby.profile.components.DashLineTextItem;

        public var avgScoutingDmgDL:net.wg.gui.lobby.profile.components.DashLineTextItem;

        internal var firstAlignedGroup:__AS3__.vec.Vector.<net.wg.gui.lobby.profile.components.DashLineTextItem>=null;

        public var avgExpDL:net.wg.gui.lobby.profile.components.DashLineTextItem;
    }
}
