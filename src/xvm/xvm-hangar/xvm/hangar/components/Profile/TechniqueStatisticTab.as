package xvm.hangar.components.Profile
{
    import com.xvm.*;
    import com.xvm.events.ObjectEvent;
    import com.xvm.utils.*;
    import com.xvm.types.stat.*;
    import com.xvm.vehinfo.*;
    import flash.events.*;
    import flash.text.*;
    import flash.utils.*;
    import net.wg.data.gui_items.dossier.*;
    import net.wg.gui.components.controls.*;
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

        public function configUI():void
        {
            for each (var c:* in controls)
                c.obj.width = c.width;
        }

        public function update(data:VehicleDossier):void
        {
            //Logger.addObject(data);
            if (this._data == data)
                return;

            this._data = data;
            if (!data)
                return;

            if (data.id[0] == 0)
                updateSummaryData();
            else
                updateVehicleData();
        }

        private function updateSummaryData():void
        {
            // TODO
            proxy.battlesDL.value = "";
        }

        private function updateVehicleData():void
        {
            proxy.battlesDL.value = makeHtmlText(_data.getBattlesCountStr());
            proxy.winsDL.value = convertPercentValue(_data.getWinsEfficiency());
            proxy.defeatsDL.value = convertPercentValue(_data.getLossesEfficiency());
            proxy.surviveDL.value = convertPercentValue(_data.getSurvivalEfficiency());
            proxy.accuracyDL.value = convertPercentValue(_data.getHitsEfficiency());
            proxy.maxExpDL.value = makeHtmlText(_data.getMaxVehicleXPStr());
            proxy.maxKillDL.value = makeHtmlText(_data.getMaxVehicleFragsStr());
            proxy.totalKillDL.value = makeHtmlText(_data.getFragsCountStr());
            proxy.totalDeadDL.value = makeHtmlText(_data.getDeathsCountStr());
            proxy.killRatioDL.value = makeHtmlText(_data.getFragsEfficiencyStr(), 13348216);
            proxy.dealtDmgDL.value = makeHtmlText(_data.getDamageDealtStr());
            proxy.receivedDmgDL.value = makeHtmlText(_data.getDamageReceivedStr());
            proxy.dmgRatioDL.value = makeHtmlText(_data.getDamageEfficiencyStr(), 13348216);
            proxy.avgExpDL.value = makeHtmlText(_data.getAvgXPStr());
            proxy.avgKillsDL.value = makeHtmlText(_data.getAvgFragsStr());
            proxy.avgDetectedDL.value = makeHtmlText(_data.getAvgEnemiesSpottedStr());
            proxy.avgDmgDealtDL.value = makeHtmlText(_data.getAvgDamageDealtStr());
            proxy.avgDmgReceivedDL.value = makeHtmlText(_data.getAvgDamageReceivedStr());
            proxy.avgScoutingDmgDL.value = "Will be implemented...";
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

        // PRIVATE
    }

}
