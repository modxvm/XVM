package xvm.hangar.components.Profile
{
    import com.xvm.*;
    import com.xvm.l10n.Locale;
    import com.xvm.types.stat.StatData;
    import com.xvm.vehinfo.*;
    import com.xvm.utils.*;
    import flash.events.*;
    import flash.text.*;
    import flash.utils.*;
    import net.wg.data.gui_items.dossier.*;
    import net.wg.gui.lobby.profile.components.*;
    import net.wg.gui.lobby.profile.pages.technique.*;
    import xvm.*;

    public class TechniqueStatisticTab
    {
        private static const DL_WIDTH:int = 200;
        private var proxy:net.wg.gui.lobby.profile.pages.technique.TechniqueStatisticTab;

        private var playerName:String;
        private var _data:VehicleDossier;

        private var cache:Dictionary;
        private var controlsMap:Dictionary;
        private var controls:Array;
        private var ratingTF:TextField;
        private var specificDamage:DashLineTextItem;
        private var avgCaptureDL:DashLineTextItem;
        private var avgDefenceDL:DashLineTextItem;

        // ENTRY POINTS

        public function TechniqueStatisticTab(proxy:net.wg.gui.lobby.profile.pages.technique.TechniqueStatisticTab)
        {
            try
            {
                this.proxy = proxy;
                cache = new Dictionary();
                controlsMap = new Dictionary(true);
                createControls();
                controls = [
                    { y: 65, width: DL_WIDTH, control: proxy.battlesDL },
                    { y: 82, width: DL_WIDTH, control: proxy.winsDL },
                    { y: 99, width: DL_WIDTH, control: proxy.defeatsDL },
                    { y: 116, width: DL_WIDTH, control: proxy.surviveDL },
                    { y: 133, width: DL_WIDTH + 15, control: proxy.accuracyDL },
                    { y: 153, control: proxy.efficiencyTF },
                    { y: 173, width: DL_WIDTH, control: proxy.maxExpDL },
                    { y: 190, width: DL_WIDTH, control: proxy.maxKillDL },
                    { y: 213, width: DL_WIDTH, control: proxy.totalKillDL },
                    { y: 230, width: DL_WIDTH, control: proxy.totalDeadDL },
                    { y: 247, width: DL_WIDTH, control: proxy.killRatioDL },
                    { y: 270, width: DL_WIDTH, control: proxy.dealtDmgDL },
                    { y: 287, width: DL_WIDTH, control: proxy.receivedDmgDL },
                    { y: 304, width: DL_WIDTH, control: proxy.dmgRatioDL },
                    { y: 324, control: proxy.avgResultsTF },
                    { y: 344, width: DL_WIDTH, control: proxy.avgExpDL },
                    { y: 361, width: DL_WIDTH, control: proxy.avgDmgDealtDL },
                    { y: 378, width: DL_WIDTH, control: proxy.avgDmgReceivedDL },
                    { y: 395, width: DL_WIDTH, control: proxy.avgKillsDL },
                    { y: 412, width: DL_WIDTH, control: proxy.avgDetectedDL },
                    { y: 429, width: DL_WIDTH, control: specificDamage },
                    { y: 446, width: DL_WIDTH, control: avgCaptureDL },
                    { y: 463, width: DL_WIDTH, control: avgDefenceDL }
                    //{ y: 463, width: DL_WIDTH, control: proxy.avgScoutingDmgDL }
                ];

                setupControls();
                createTextFields();
                updateCommonData(new Data());
            }
            catch (ex:Error)
            {
                Logger.add(ex.getStackTrace());
            }
        }

        public function configUI():void
        {
            try
            {
                setupControls();
                updateCommonData(new Data());
            }
            catch (ex:Error)
            {
                Logger.add(ex.getStackTrace());
            }
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

                var vid:int = page.listComponent.selectedItem.id;
                if (vid != 0)
                    ratingTF.htmlText = "";

                //Logger.add("vid: " + vid + ", data.id:" + data.id[0])
                if (vid != data.id[0])
                    return;

                _data = data;

                if (data.id[0] == 0)
                {
                    playerName = data.id[1];
                    if (playerName == null)
                        playerName = XvmHangar.Globals[XvmHangar.G_NAME];
                    updateSummaryData();
                }
                else
                {
                    updateVehicleData();
                }
            }
            catch (ex:Error)
            {
                Logger.add(ex.getStackTrace());
            }
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

        private function setupControls():void
        {
            for each (var c:Object in controls)
            {
                if (c.hasOwnProperty("y"))
                    c.control.y = c.y;
                if (c.hasOwnProperty("width"))
                    c.control.width = c.width;
            }
        }

        private function createControls():void
        {
            ratingTF = Utils.cloneTextField(proxy.efficiencyTF);
            ratingTF.antiAliasType = AntiAliasType.ADVANCED;
            ratingTF.multiline = true;
            ratingTF.wordWrap = false;
            ratingTF.x = proxy.efficiencyTF.x + 18;
            ratingTF.y = proxy.battlesDL.y - 50;
            ratingTF.width = 400;
            ratingTF.height = 80;
            var tf:TextFormat = proxy.efficiencyTF.defaultTextFormat;
            tf.size = 14;
            tf.bold = false;
            tf.color = Defines.UICOLOR_DEFAULT2;
            ratingTF.styleSheet = Utils.createTextStyleSheet("txt", tf);
            proxy.addChild(ratingTF);

            specificDamage = Utils.cloneDashLineTextItem(proxy.avgDmgReceivedDL);
            specificDamage.label = Locale.get("Damage / HP");
            specificDamage.y += 17;
            specificDamage.visible = false;
            proxy.addChild(specificDamage);

            avgCaptureDL = Utils.cloneDashLineTextItem(specificDamage);
            avgCaptureDL.label = Locale.get("Capture points");
            avgCaptureDL.y += 17;
            avgCaptureDL.visible = false;
            proxy.addChild(avgCaptureDL);

            avgDefenceDL = Utils.cloneDashLineTextItem(avgCaptureDL);
            avgDefenceDL.label = Locale.get("Defence points");
            avgDefenceDL.y += 17;
            avgDefenceDL.visible = false;
            proxy.addChild(avgDefenceDL);
        }

        private function createTextFields():void
        {
            for each (var c:* in controls)
            {
                var dl:DashLineTextItem = c.control as DashLineTextItem;
                if (dl == null)
                    continue;
                var tf:TextField = new TextField();
                tf.selectable = false;
                tf.antiAliasType = AntiAliasType.ADVANCED;
                tf.styleSheet = Utils.createTextStyleSheet("txt", dl.valueTextField.getTextFormat());
                tf.x = dl.x + c.width + 5;
                tf.y = dl.y;
                tf.width = 220;
                controlsMap[dl] = tf;
                proxy.addChild(tf);
            }
        }

        private function updateCommonData(data:Data):void
        {
            TF(proxy.battlesDL).htmlText = formatHtmlText(data.winsToNextPercentStr, Defines.UICOLOR_GOLD);

            var ratingColor:int = MacrosUtil.GetDynamicColorValueInt(Defines.DYNAMIC_COLOR_RATING, data.winsEfficiency * 100);
            proxy.winsDL.value = color(App.utils.locale.integer(data.winsCount));
            TF(proxy.winsDL).htmlText = formatHtmlText(App.utils.locale.numberWithoutZeros(data.winsEfficiency * 100) + "%", ratingColor);

            proxy.defeatsDL.value = color(App.utils.locale.integer(data.lossesCount));
            TF(proxy.defeatsDL).htmlText = formatHtmlText(App.utils.locale.numberWithoutZeros(data.lossesEfficiency * 100) + "%", Defines.UICOLOR_GOLD);

            proxy.surviveDL.value = color(App.utils.locale.integer(data.survivalCount));
            TF(proxy.surviveDL).htmlText = formatHtmlText(App.utils.locale.numberWithoutZeros(data.survivalEfficiency * 100) + "%", Defines.UICOLOR_GOLD);

            proxy.accuracyDL.value = convertPercentValue(data.hitsEfficiency);

            proxy.maxExpDL.value = color(App.utils.locale.integer(data.maxXP));
            TF(proxy.maxExpDL).htmlText = formatHtmlText(data.maxXPVehicleName, Defines.UICOLOR_GOLD);

            proxy.maxKillDL.value = color(App.utils.locale.integer(data.maxFrags));
            TF(proxy.maxKillDL).htmlText = formatHtmlText(data.maxFragsVehicleName, Defines.UICOLOR_GOLD);

            proxy.totalKillDL.value = color(App.utils.locale.integer(data.fragsCount));

            proxy.totalDeadDL.value = color(App.utils.locale.integer(data.deathsCount));

            proxy.killRatioDL.value = color(App.utils.locale.numberWithoutZeros(data.fragsEfficiency), 13348216);

            proxy.dealtDmgDL.value = color(App.utils.locale.integer(data.damageDealt));

            proxy.receivedDmgDL.value = color(App.utils.locale.integer(data.damageReceived));

            proxy.dmgRatioDL.value = color(App.utils.locale.numberWithoutZeros(data.damageEfficiency), 13348216);

            proxy.avgExpDL.value = color(App.utils.locale.numberWithoutZeros(data.avgXP));
            proxy.avgDmgReceivedDL.value = color(App.utils.locale.numberWithoutZeros(data.avgDamageReceived));

            // stat

            TF(proxy.avgDmgDealtDL).htmlText = "";
            TF(proxy.avgKillsDL).htmlText = "";
            TF(proxy.avgDetectedDL).htmlText = "";
            specificDamage.value = "";
            TF(specificDamage).htmlText = "";
        }

        private function updateSummaryData():void
        {
            var data:Data = prepareData(page.currentDossier);
            updateCommonData(data);

            var battlesColor:int = MacrosUtil.GetDynamicColorValueInt(Defines.DYNAMIC_COLOR_KB, data.battlesCount / 1000);
            proxy.battlesDL.value = color(App.utils.locale.integer(data.battlesCount), battlesColor);

            proxy.avgKillsDL.value = color(App.utils.locale.numberWithoutZeros(data.avgFrags));
            proxy.avgDetectedDL.value = color(App.utils.locale.numberWithoutZeros(data.avgEnemiesSpotted));
            proxy.avgDmgDealtDL.value = color(App.utils.locale.numberWithoutZeros(data.avgDamageDealt));

            specificDamage.visible = false;

            // stat
            var s:String = "";
            if (data.stat == null)
                ratingTF.htmlText = "";
            else
            {
                s += Locale.get("Avg level") + ": " + (!data.stat.lvl ? "-" :
                    color(App.utils.locale.numberWithoutZeros(data.stat.lvl), MacrosUtil.GetDynamicColorValueInt(Defines.DYNAMIC_COLOR_AVGLVL, data.stat.lvl))) + " ";
                s += Locale.get("WN6") + ": " + (!data.stat.wn ? "-- (-)" :
                    color((data.stat.xwn == 100 ? "XX" : (data.stat.xwn < 10 ? "0" : "") + data.stat.xwn), MacrosUtil.GetDynamicColorValueInt(Defines.DYNAMIC_COLOR_X, data.stat.xwn)) + " (" +
                    color(App.utils.locale.integer(data.stat.wn), MacrosUtil.GetDynamicColorValueInt(Defines.DYNAMIC_COLOR_WN, data.stat.wn)) + ")") + " ";
                s += Locale.get("EFF") + ": " + (!data.stat.e ? "-- (-)" :
                    color((data.stat.xeff == 100 ? "XX" : (data.stat.xeff < 10 ? "0" : "") + data.stat.xeff), MacrosUtil.GetDynamicColorValueInt(Defines.DYNAMIC_COLOR_X, data.stat.xeff)) + " (" +
                    color(App.utils.locale.integer(data.stat.e), MacrosUtil.GetDynamicColorValueInt(Defines.DYNAMIC_COLOR_EFF, data.stat.e)) + ")") + "<br>";
                s += "<tab><tab><tab><tab><tab>" + size(Locale.get("updated") + ":", 11) + " " + size(color(data.stat.dt.substr(0, 10), 0xCCCCCC), 12);
                ratingTF.htmlText = "<textformat leading='-2'>" + formatHtmlText(s) + "</textformat>";
            }

            avgCaptureDL.visible = data.stat != null;
            avgDefenceDL.visible = data.stat != null;
            if (data.stat != null)
            {
                avgCaptureDL.value = color(size(App.utils.locale.numberWithoutZeros(data.stat.cap / data.stat.b), 12));
                avgDefenceDL.value = color(size(App.utils.locale.numberWithoutZeros(data.stat.def / data.stat.b), 12));
            }
        }

        private function updateVehicleData():void
        {
            var data:Data = prepareData(_data);
            updateCommonData(data);

            var battlesColor:int = MacrosUtil.GetDynamicColorValueInt(Defines.DYNAMIC_COLOR_TBATTLES, data.battlesCount);
            proxy.battlesDL.value = color(App.utils.locale.integer(data.battlesCount), battlesColor);

            proxy.avgKillsDL.value = color(App.utils.locale.numberWithoutZeros(data.avgFrags),
                MacrosUtil.GetDynamicColorValueInt(Defines.DYNAMIC_COLOR_TFB, data.avgFrags));
            proxy.avgDetectedDL.value = color(App.utils.locale.numberWithoutZeros(data.avgEnemiesSpotted),
                MacrosUtil.GetDynamicColorValueInt(Defines.DYNAMIC_COLOR_TSB, data.avgEnemiesSpotted));
            proxy.avgDmgDealtDL.value = color(App.utils.locale.numberWithoutZeros(data.avgDamageDealt),
                MacrosUtil.GetDynamicColorValueInt(Defines.DYNAMIC_COLOR_TDB, data.avgDamageDealt));

            ratingTF.htmlText = "";

            var vi:Object = VehicleInfo.getInfo2ByVid(_data.id[0]);
            if (vi == null)
                return;
            //Logger.addObject(vi, "", 2);

            var colorAvg:int;
            var colorTop:int;

            // wins
            if (vi.avg.R)
            {
                colorAvg = MacrosUtil.GetDynamicColorValueInt(Defines.DYNAMIC_COLOR_RATING, vi.avg.R * 100);
                colorTop = MacrosUtil.GetDynamicColorValueInt(Defines.DYNAMIC_COLOR_RATING, vi.top.R * 100);
                TF(proxy.winsDL).htmlText += formatHtmlText(
                    " " + Locale.get("avg") + ": " + color(App.utils.locale.numberWithoutZeros(vi.avg.R * 100), colorAvg) +
                    " " + Locale.get("top") + ": " + color(App.utils.locale.numberWithoutZeros(vi.top.R * 100), colorTop),
                    Defines.UICOLOR_GOLD);
            }

            // survival
            if (vi.avg.U)
            {
                TF(proxy.surviveDL).htmlText += formatHtmlText(
                    " " + Locale.get("avg") + ": " + App.utils.locale.numberWithoutZeros(vi.avg.U * 100) +
                    " " + Locale.get("top") + ": " + App.utils.locale.numberWithoutZeros(vi.top.U * 100),
                    Defines.UICOLOR_GOLD);
            }

            // dmg
            if (vi.avg.D)
            {
                colorAvg = MacrosUtil.GetDynamicColorValueInt(Defines.DYNAMIC_COLOR_TDB, vi.avg.D);
                colorTop = MacrosUtil.GetDynamicColorValueInt(Defines.DYNAMIC_COLOR_TDB, vi.top.D);
                TF(proxy.avgDmgDealtDL).htmlText = formatHtmlText(
                    Locale.get("avg") + ": " + color(App.utils.locale.numberWithoutZeros(vi.avg.D), colorAvg) +
                    " " + Locale.get("top") + ": " + color(App.utils.locale.numberWithoutZeros(vi.top.D), colorTop),
                    Defines.UICOLOR_GOLD);
            }

            // frags
            if (vi.avg.F)
            {
                colorAvg = MacrosUtil.GetDynamicColorValueInt(Defines.DYNAMIC_COLOR_TFB, vi.avg.F);
                colorTop = MacrosUtil.GetDynamicColorValueInt(Defines.DYNAMIC_COLOR_TFB, vi.top.F);
                TF(proxy.avgKillsDL).htmlText = formatHtmlText(
                    Locale.get("avg") + ": " + color(App.utils.locale.numberWithoutZeros(vi.avg.F), colorAvg) +
                    " " + Locale.get("top") + ": " + color(App.utils.locale.numberWithoutZeros(vi.top.F), colorTop),
                    Defines.UICOLOR_GOLD);
            }

            // spotted
            if (vi.avg.S)
            {
                colorAvg = MacrosUtil.GetDynamicColorValueInt(Defines.DYNAMIC_COLOR_TSB, vi.avg.S);
                colorTop = MacrosUtil.GetDynamicColorValueInt(Defines.DYNAMIC_COLOR_TSB, vi.top.S);
                TF(proxy.avgDetectedDL).htmlText = formatHtmlText(
                    Locale.get("avg") + ": " + color(App.utils.locale.numberWithoutZeros(vi.avg.S), colorAvg) +
                    " " + Locale.get("top") + ": " + color(App.utils.locale.numberWithoutZeros(vi.top.S), colorTop),
                    Defines.UICOLOR_GOLD);
            }

            // specific damage
            var specDmg:Number = data.avgDamageDealt / vi.hptop;
            specificDamage.visible = true;
            specificDamage.value = color(size(App.utils.locale.numberWithoutZeros(specDmg), 12),
                MacrosUtil.GetDynamicColorValueInt(Defines.DYNAMIC_COLOR_TDV, specDmg));

            if (vi.avg.E)
            {
                colorAvg = MacrosUtil.GetDynamicColorValueInt(Defines.DYNAMIC_COLOR_TDV, vi.avg.E);
                colorTop = MacrosUtil.GetDynamicColorValueInt(Defines.DYNAMIC_COLOR_TDV, vi.top.E);
                TF(specificDamage).htmlText = formatHtmlText(size(
                    Locale.get("avg") + ": " + color(App.utils.locale.numberWithoutZeros(vi.avg.E), colorAvg) +
                    " " + Locale.get("top") + ": " + color(App.utils.locale.numberWithoutZeros(vi.top.E), colorTop),
                    12), Defines.UICOLOR_GOLD);
            }
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
                if (data.stat == null)
                    setStatData(data);
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

        private function setStatData(data:Data):void
        {
            var stat:StatData = Stat.getUserDataByName(playerName);
            if (stat == null)
                return;
            data.stat = stat;
        }

        private function pb(value:Number, battles:Number):Number
        {
            return battles <= 0 ? 0 : value / battles;
        }

        private function formatHtmlText(txt:String, color:uint=1):String
        {
            return "<span class='txt'>" + (color == 1 ? txt : this.color(txt, color)) + "</span>";
        }

        private function size(txt:String, sz:uint=14):String
        {
            return "<font size='" + sz.toString() + "'>" + txt + "</font>";
        }

        private function color(txt:String, color:uint=0xFDF4CE):String
        {
            return "<font color='#" + color.toString(16) + "'>" + txt + "</font>";
        }

        // from WG

        internal function convertPercentValue(arg1:Number):String
        {
            var loc1:*=App.utils.locale;
            var loc2:*=loc1.numberWithoutZeros(arg1 * 100);
            return color(loc2) + color(" %", 6513507);
        }
    }
}
import com.xvm.types.stat.StatData;

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

    // stat
    public var stat:StatData = null;
}
