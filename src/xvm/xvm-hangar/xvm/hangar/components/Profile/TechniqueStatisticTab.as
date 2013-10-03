package xvm.hangar.components.Profile
{
    import com.xvm.*;
    import flash.text.*;
    import net.wg.data.gui_items.dossier.*;
    import net.wg.gui.lobby.profile.pages.technique.*;

    public class TechniqueStatisticTab
    {
        private var proxy:net.wg.gui.lobby.profile.pages.technique.TechniqueStatisticTab;

        private var effField:TextField;
        private var playerName:String;
        private var _data:VehicleDossier;

        private var controls:Array;

        public function TechniqueStatisticTab(proxy:net.wg.gui.lobby.profile.pages.technique.TechniqueStatisticTab)
        {
            this.proxy = proxy;
            controls = [
                { width: 270, obj: proxy.efficiencyTF },
                { width: 270, obj: proxy.avgResultsTF },
                { width: 270, obj: proxy.battlesDL },
                { width: 285, obj: proxy.winsDL },
                { width: 285, obj: proxy.defeatsDL },
                { width: 285, obj: proxy.surviveDL },
                { width: 285, obj: proxy.accuracyDL },
                { width: 270, obj: proxy.maxExpDL },
                { width: 270, obj: proxy.maxKillDL },
                { width: 270, obj: proxy.totalKillDL },
                { width: 270, obj: proxy.totalDeadDL },
                { width: 270, obj: proxy.killRatioDL },
                { width: 270, obj: proxy.dealtDmgDL },
                { width: 270, obj: proxy.receivedDmgDL },
                { width: 270, obj: proxy.dmgRatioDL },
                { width: 270, obj: proxy.avgKillsDL },
                { width: 270, obj: proxy.avgDetectedDL },
                { width: 270, obj: proxy.avgDmgDealtDL },
                { width: 270, obj: proxy.avgDmgReceivedDL },
                { width: 270, obj: proxy.avgScoutingDmgDL },
                { width: 270, obj: proxy.avgExpDL }
            ];
        }

        private function get page():ProfileTechnique
        {
            return proxy.parent.parent.parent.parent as ProfileTechnique;
        }

        public function configUI():void
        {
            for each (var c:* in controls)
                c.obj.width = c.width;
        }

        public function update(data:VehicleDossier):void
        {
            //Logger.addObject(data);
            if (_data == data)
                return;

            if (!data)
            {
                _data = null;
                return;
            }

            _data = data;
            if (data.id[0] == 0)
                updateSummaryData();
            else
                updateVehicleData();
        }

        private function updateSummaryData():void
        {
            var data:Data = getValue(page.currentDossier);
            proxy.battlesDL.value = makeHtmlText(data.battlesCountStr);
            proxy.winsDL.value = convertPercentValue(data.winsEfficiency);
            proxy.defeatsDL.value = convertPercentValue(data.lossesEfficiency);
            proxy.surviveDL.value = convertPercentValue(data.survivalEfficiency);
            proxy.accuracyDL.value = convertPercentValue(data.hitsEfficiency);
            proxy.maxExpDL.value = makeHtmlText(data.maxVehicleXPStr);
            proxy.maxKillDL.value = makeHtmlText(data.maxVehicleFragsStr);
            proxy.totalKillDL.value = makeHtmlText(data.fragsCountStr);
            proxy.totalDeadDL.value = makeHtmlText(data.deathsCountStr);
            proxy.killRatioDL.value = makeHtmlText(data.fragsEfficiencyStr, 13348216);
            proxy.dealtDmgDL.value = makeHtmlText(data.damageDealtStr);
            proxy.receivedDmgDL.value = makeHtmlText(data.damageReceivedStr);
            proxy.dmgRatioDL.value = makeHtmlText(data.damageEfficiencyStr, 13348216);
            proxy.avgExpDL.value = makeHtmlText(data.avgXPStr);
            proxy.avgKillsDL.value = makeHtmlText(data.avgFragsStr);
            proxy.avgDetectedDL.value = makeHtmlText(data.avgEnemiesSpottedStr);
            proxy.avgDmgDealtDL.value = makeHtmlText(data.avgDamageDealtStr);
            proxy.avgDmgReceivedDL.value = makeHtmlText(data.avgDamageReceivedStr);
            proxy.avgScoutingDmgDL.value = "Will be implemented...";
        }

        private function updateVehicleData():void
        {
            var data:Data = getValue(_data);
            proxy.battlesDL.value = makeHtmlText(data.battlesCountStr);
            proxy.winsDL.value = convertPercentValue(data.winsEfficiency);
            proxy.defeatsDL.value = convertPercentValue(data.lossesEfficiency);
            proxy.surviveDL.value = convertPercentValue(data.survivalEfficiency);
            proxy.accuracyDL.value = convertPercentValue(data.hitsEfficiency);
            proxy.maxExpDL.value = makeHtmlText(data.maxVehicleXPStr);
            proxy.maxKillDL.value = makeHtmlText(data.maxVehicleFragsStr);
            proxy.totalKillDL.value = makeHtmlText(data.fragsCountStr);
            proxy.totalDeadDL.value = makeHtmlText(data.deathsCountStr);
            proxy.killRatioDL.value = makeHtmlText(data.fragsEfficiencyStr, 13348216);
            proxy.dealtDmgDL.value = makeHtmlText(data.damageDealtStr);
            proxy.receivedDmgDL.value = makeHtmlText(data.damageReceivedStr);
            proxy.dmgRatioDL.value = makeHtmlText(data.damageEfficiencyStr, 13348216);
            proxy.avgExpDL.value = makeHtmlText(data.avgXPStr);
            proxy.avgKillsDL.value = makeHtmlText(data.avgFragsStr);
            proxy.avgDetectedDL.value = makeHtmlText(data.avgEnemiesSpottedStr);
            proxy.avgDmgDealtDL.value = makeHtmlText(data.avgDamageDealtStr);
            proxy.avgDmgReceivedDL.value = makeHtmlText(data.avgDamageReceivedStr);
        }

        internal static function makeHtmlText(arg1:String, arg2:uint=16643278):String
        {
            return "<font color=\'#" + arg2.toString(16) + "\'>" + arg1 + "</font>";
        }

        internal static function convertPercentValue(arg1:Number):String
        {
            var loc1:*=App.utils.locale;
            var loc2:*=loc1.numberWithoutZeros(arg1 * 100);
            return makeHtmlText(loc2) + makeHtmlText(" %", 6513507);
        }

        private function getValue(data:Dossier):Data
        {
            try
            {
                var item:Data = new Data();
                item.battlesCount = data.getBattlesCount();
                item.battlesCountStr = data.getBattlesCountStr();
                item.winsCount = data.getWinsCount();
                item.winsEfficiency = data.getWinsEfficiency();
                item.lossesEfficiency = data.getLossesEfficiency();
                item.survivalEfficiency = data.getSurvivalEfficiency();
                item.hitsEfficiency = data.getHitsEfficiency();
                item.maxVehicleXPStr = data.getMaxVehicleXPStr();
                item.maxVehicleFragsStr = data.getMaxVehicleFragsStr();
                item.fragsCountStr = data.getFragsCountStr();
                item.deathsCountStr = data.getDeathsCountStr();
                item.fragsEfficiencyStr = data.getFragsEfficiencyStr();
                item.damageDealtStr = data.getDamageDealtStr();
                item.damageReceivedStr = data.getDamageReceivedStr();
                item.damageEfficiencyStr = data.getDamageEfficiencyStr();
                item.avgXPStr = data.getAvgXPStr();
                item.avgFragsStr = data.getAvgFragsStr();
                item.avgEnemiesSpottedStr = data.getAvgEnemiesSpottedStr();
                item.avgDamageDealtStr = data.getAvgDamageDealtStr();
                item.avgDamageReceivedStr = data.getAvgDamageReceivedStr();
                return item;
            }
            catch (ex:Error)
            {
                Logger.add(ex.getStackTrace());
            }
            return new Data();
        }

        // PRIVATE
    }

}

class Data
{
    public var battlesCount:Number;
    public var battlesCountStr:String;
    public var winsCount:Number;
    public var winsEfficiency:Number;
    public var lossesEfficiency:Number;
    public var survivalEfficiency:Number;
    public var hitsEfficiency:Number;
    public var maxVehicleXPStr:String;
    public var maxVehicleFragsStr:String;
    public var fragsCountStr:String;
    public var deathsCountStr:String;
    public var fragsEfficiencyStr:String;
    public var damageDealtStr:String;
    public var damageReceivedStr:String;
    public var damageEfficiencyStr:String;
    public var avgXPStr:String;
    public var avgFragsStr:String;
    public var avgEnemiesSpottedStr:String;
    public var avgDamageDealtStr:String;
    public var avgDamageReceivedStr:String;
}
