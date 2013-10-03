package xvm.hangar.components.Profile
{
    import com.xvm.*;
    import com.xvm.l10n.Locale;
    import com.xvm.utils.*;
    import flash.events.*;
    import flash.text.*;
    import flash.utils.*;
    import net.wg.data.gui_items.dossier.*;
    import net.wg.gui.lobby.profile.components.*;
    import net.wg.gui.lobby.profile.pages.technique.*;

    public class TechniqueStatisticTab
    {
        private var proxy:net.wg.gui.lobby.profile.pages.technique.TechniqueStatisticTab;

        //private var playerName:String;
        private var _data:VehicleDossier;

        private var cache:Dictionary;
        private var controlsMap:Dictionary;
        private var controls:Array;
        private var ratingTF:TextField;

        // ENTRY POINTS

        public function TechniqueStatisticTab(proxy:net.wg.gui.lobby.profile.pages.technique.TechniqueStatisticTab)
        {
            try
            {
                this.proxy = proxy;
                cache = new Dictionary();
                controlsMap = new Dictionary(true);
                controls = [
                    { width: 250, control: proxy.efficiencyTF },
                    { width: 250, control: proxy.avgResultsTF },
                    { width: 250, control: proxy.battlesDL },
                    { width: 250, control: proxy.winsDL },
                    { width: 250, control: proxy.defeatsDL },
                    { width: 250, control: proxy.surviveDL },
                    { width: 265, control: proxy.accuracyDL },
                    { width: 250, control: proxy.maxExpDL },
                    { width: 250, control: proxy.maxKillDL },
                    { width: 250, control: proxy.totalKillDL },
                    { width: 250, control: proxy.totalDeadDL },
                    { width: 250, control: proxy.killRatioDL },
                    { width: 250, control: proxy.dealtDmgDL },
                    { width: 250, control: proxy.receivedDmgDL },
                    { width: 250, control: proxy.dmgRatioDL },
                    { width: 250, control: proxy.avgKillsDL },
                    { width: 250, control: proxy.avgDetectedDL },
                    { width: 250, control: proxy.avgDmgDealtDL },
                    { width: 250, control: proxy.avgDmgReceivedDL },
                    { width: 250, control: proxy.avgScoutingDmgDL },
                    { width: 250, control: proxy.avgExpDL }
                ];

                createTextFields();
                createControls();
            }
            catch (ex:Error)
            {
                Logger.add(ex.getStackTrace())
            };
        }

        public function configUI():void
        {
            for each (var c:Object in controls)
                c.control.width = c.width;
        }

        public function update(data:VehicleDossier):void
        {
            //Logger.addObject(data);
            try
            {
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
            catch (ex:Error)
            {
                Logger.add(ex.getStackTrace())
            };
        }

        // PRIVATE

        private function get page():ProfileTechnique
        {
            return proxy.parent.parent.parent.parent as ProfileTechnique;
        }

        private function TF(dl:DashLineTextItem):TextField
        {
            return controlsMap[dl];
        }

        private function createControls():void
        {
            ratingTF = Utils.cloneTextField(proxy.efficiencyTF);
            ratingTF.y = proxy.battlesDL.y - 20;
            proxy.addChild(ratingTF);
            ratingTF.styleSheet = Utils.createTextStyleSheet("txt", proxy.efficiencyTF.getTextFormat());
        }

        private function createTextFields():void
        {
            for each (var c:* in controls)
            {
                var dl:DashLineTextItem = c.control as DashLineTextItem;
                if (dl == null)
                    continue;
                var tf:TextField = new TextField();
                tf.styleSheet = Utils.createTextStyleSheet("txt", dl.valueTextField.getTextFormat());
                tf.x = dl.x + c.width + 5;
                tf.y = dl.y;
                tf.width = 200;
                controlsMap[dl] = tf;
                proxy.addChild(tf);
            }
        }

        private function updateCommonData(data:Data):void
        {
            ratingTF.htmlText = formatHtmlText(Locale.get("Ratings") + ": ");

            proxy.battlesDL.value = colorText(App.utils.locale.integer(data.battlesCount));
            TF(proxy.battlesDL).htmlText = formatHtmlText(data.winsToNextPercentStr, Defines.UICOLOR_GOLD);

            proxy.winsDL.value = colorText(App.utils.locale.integer(data.winsCount));
            TF(proxy.winsDL).htmlText = formatHtmlText(App.utils.locale.numberWithoutZeros(data.winsEfficiency * 100) + "%", Defines.UICOLOR_GOLD);

            proxy.defeatsDL.value = colorText(App.utils.locale.integer(data.lossesCount));
            TF(proxy.defeatsDL).htmlText = formatHtmlText(App.utils.locale.numberWithoutZeros(data.lossesEfficiency * 100) + "%", Defines.UICOLOR_GOLD);

            proxy.surviveDL.value = colorText(App.utils.locale.integer(data.survivalCount));
            TF(proxy.surviveDL).htmlText = formatHtmlText(App.utils.locale.numberWithoutZeros(data.survivalEfficiency * 100) + "%", Defines.UICOLOR_GOLD);

            proxy.accuracyDL.value = convertPercentValue(data.hitsEfficiency);

            proxy.maxExpDL.value = colorText(App.utils.locale.integer(data.maxXP));
            TF(proxy.maxExpDL).htmlText = formatHtmlText(data.maxXPVehicleName, Defines.UICOLOR_GOLD);

            proxy.maxKillDL.value = colorText(App.utils.locale.integer(data.maxFrags));
            TF(proxy.maxKillDL).htmlText = formatHtmlText(data.maxFragsVehicleName, Defines.UICOLOR_GOLD);

            proxy.totalKillDL.value = colorText(App.utils.locale.integer(data.fragsCount));

            proxy.totalDeadDL.value = colorText(App.utils.locale.integer(data.deathsCount));

            proxy.killRatioDL.value = colorText(App.utils.locale.numberWithoutZeros(data.fragsEfficiency), 13348216);

            proxy.dealtDmgDL.value = colorText(App.utils.locale.integer(data.damageDealt));

            proxy.receivedDmgDL.value = colorText(App.utils.locale.integer(data.damageReceived));

            proxy.dmgRatioDL.value = colorText(App.utils.locale.numberWithoutZeros(data.damageEfficiency), 13348216);

            proxy.avgExpDL.value = colorText(App.utils.locale.numberWithoutZeros(data.avgXP));
            proxy.avgKillsDL.value = colorText(App.utils.locale.numberWithoutZeros(data.avgFrags));
            proxy.avgDetectedDL.value = colorText(App.utils.locale.numberWithoutZeros(data.avgEnemiesSpotted));
            proxy.avgDmgDealtDL.value = colorText(App.utils.locale.numberWithoutZeros(data.avgDamageDealt));
            proxy.avgDmgReceivedDL.value = colorText(App.utils.locale.numberWithoutZeros(data.avgDamageReceived));
        }

        private function updateSummaryData():void
        {
            var data:Data = prepareData(page.currentDossier);
            updateCommonData(data);
        }

        private function updateVehicleData():void
        {
            var data:Data = prepareData(_data);
            updateCommonData(data);
        }

        private function prepareData(dossier:Dossier):Data
        {
            try
            {
                // skip empty result - data is not loaded yet
                if (dossier.getBattlesCount() == 0)
                    return new Data();

                var key:String = dossier.id == null ? "0" : dossier.id.toString(); // "vId,playerName" or "vid," for self
                var data:Data = cache[key];
                if (data == null)
                {
                    data = extractData(dossier);
                    calculateData(data);
                    cache[key] = data;
                }
                return data;
            }
            catch (ex:Error)
            {
                Logger.add(ex.getStackTrace());
            }
            return new Data();
        }

        private function extractData(dossier:Dossier):Data
        {
            var data:Data = new Data();
            data.battlesCount = dossier.getBattlesCount();
            data.winsCount = dossier.getWinsCount();
            data.winsEfficiency = dossier.getWinsEfficiency();
            data.lossesCount = data.battlesCount - data.winsCount;
            data.lossesEfficiency = dossier.getLossesEfficiency();
            data.survivalCount = data.battlesCount - dossier.getDeathsCount();
            data.survivalEfficiency = dossier.getSurvivalEfficiency();
            data.hitsEfficiency = dossier.getHitsEfficiency();

            data.maxXP = (dossier is VehicleDossier) ? dossier.getMaxVehicleXP() : dossier.getMaxVehicleXP();
            data.maxFrags = (dossier is VehicleDossier) ? dossier.getMaxVehicleFrags() : dossier.getMaxVehicleFrags();
            data.fragsCount = dossier.getFragsCount();
            data.deathsCount = dossier.getDeathsCount();
            data.fragsEfficiency = dossier.getFragsEfficiency();
            data.damageDealt = dossier.getDamageDealt();
            data.damageReceived = dossier.getDamageReceived();
            data.damageEfficiency = dossier.getDamageEfficiency();
            data.avgXP = dossier.getAvgXP();
            data.avgFrags = dossier.getAvgFrags();
            data.avgEnemiesSpotted = dossier.getAvgEnemiesSpotted();
            data.avgDamageDealt = dossier.getAvgDamageDealt();
            data.avgDamageReceived = dossier.getAvgDamageReceived();
            return data;
        }

        private function calculateData(data:Data):void
        {
            // GWR
            data.globalWinRatio = pb(data.winsCount, data.battlesCount) * 100;

            // Wins to next percent
            if (data.globalWinRatio > 0 && data.globalWinRatio < 100)
            {
                var r1:Number = Math.round(data.globalWinRatio) / 100 + 0.005;
                var r2:Number = int(data.globalWinRatio) / 100 + 0.01;
                var b1:Number = (data.battlesCount * r1 - data.winsCount) / (1 - r1);
                var b2:Number = (data.battlesCount * r2 - data.winsCount) / (1 - r2);
                b1 = Math.max(0, b1 % 1 == 0 ? b1 : (int(b1) + 1));
                b2 = Math.max(0, b2 % 1 == 0 ? b2 : (int(b2) + 1));
                data.winsToNextPercentStr = (b2 > b1)
                    ? App.utils.locale.integer(b1) + Locale.get(" to ") + App.utils.locale.numberWithoutZeros((r2 * 100 - 0.5).toFixed(1)) + "% / " +
                        App.utils.locale.integer(b2) + Locale.get(" to ") + App.utils.locale.numberWithoutZeros((r2 * 100).toFixed(1)) + "%"
                    : App.utils.locale.integer(b2) + Locale.get(" to ") + App.utils.locale.numberWithoutZeros((r2 * 100).toFixed(1)) + "% / " +
                        App.utils.locale.integer(b1) + Locale.get(" to ") + App.utils.locale.numberWithoutZeros((r2 * 100 + 0.5).toFixed(1)) + "%";
            }
        }

        private function pb(value:Number, battles:Number):Number
        {
            return battles <= 0 ? 0 : value / battles;
        }

        private function formatHtmlText(txt:String, color:uint=1):String
        {
            return "<span class='txt'>" + (color == 1 ? txt : colorText(txt, color)) + "</span>";
        }

        // from WG

        internal static function colorText(arg1:String, arg2:uint=0xFDF4CE):String
        {
            return "<font color=\'#" + arg2.toString(16) + "\'>" + arg1 + "</font>";
        }

        internal static function convertPercentValue(arg1:Number):String
        {
            var loc1:*=App.utils.locale;
            var loc2:*=loc1.numberWithoutZeros(arg1 * 100);
            return colorText(loc2) + colorText(" %", 6513507);
        }
    }
}

class Data
{
    public var battlesCount:Number = 0;
    public var winsCount:Number = 0;
    public var winsEfficiency:Number = 0;
    public var lossesCount:Number = 0;
    public var lossesEfficiency:Number = 0;
    public var survivalCount:Number = 0;
    public var survivalEfficiency:Number = 0;
    public var hitsEfficiency:Number = 0;
    public var maxXP:Number = 0;
    public var maxXPVehicleName:String = "";
    public var maxFrags:Number = 0;
    public var maxFragsVehicleName:String = "";
    public var fragsCount:Number = 0;
    public var deathsCount:Number = 0;
    public var fragsEfficiency:Number = 0;
    public var damageDealt:Number = 0;
    public var damageReceived:Number = 0;
    public var damageEfficiency:Number = 0;
    public var avgXP:Number = 0;
    public var avgFrags:Number = 0;
    public var avgEnemiesSpotted:Number = 0;
    public var avgDamageDealt:Number = 0;
    public var avgDamageReceived:Number = 0;

    // calculated
    public var globalWinRatio:Number = 0;
    public var winsToNextPercentStr:String = "";
}
