package xvm.profile.components
{
    import com.xvm.*;
    import com.xvm.l10n.Locale;
    import com.xvm.misc.*;
    import com.xvm.types.dossier.*;
    import com.xvm.types.stat.*;
    import com.xvm.types.veh.*;
    import com.xvm.utils.*;
    import flash.text.*;
    import flash.utils.*;
    import net.wg.gui.lobby.profile.components.*;
    import net.wg.gui.lobby.profile.pages.technique.*;
    import net.wg.gui.lobby.profile.pages.technique.data.*;

    public class TechniqueStatisticTab
    {
        private static const DL_WIDTH:int = 200;
        private var proxy:net.wg.gui.lobby.profile.pages.technique.TechniqueStatisticTab;

        private var _raw_data:ProfileVehicleDossierVO;

        private var cache:Dictionary;
        private var controlsMap:Dictionary;
        private var controls:Array;
        public var ratingTF:TextField;
        public var maxDamageDL:DashLineTextItem;
        public var maxDamageDLLabelTextFormat:TextFormat;
        public var maxDamageDLValueTextFormat:TextFormat;
        public var specDamageDL:DashLineTextItem;
        public var avgCaptureDL:DashLineTextItem;
        public var avgDefenceDL:DashLineTextItem;

        // ENTRY POINTS

        public function TechniqueStatisticTab(proxy:net.wg.gui.lobby.profile.pages.technique.TechniqueStatisticTab)
        {
            //Logger.add("TechniqueStatisticTab::ctor()");
            try
            {
                this.proxy = proxy;
                cache = new Dictionary();
                controlsMap = new Dictionary(true);
                createControls();
                controls = [
                    { y: 60,  width: DL_WIDTH, control: proxy.battlesDL },
                    { y: 77,  width: DL_WIDTH, control: proxy.winsDL },
                    { y: 94,  width: DL_WIDTH, control: proxy.defeatsDL },
                    { y: 111, width: DL_WIDTH, control: proxy.surviveDL },
                    { y: 128, width: DL_WIDTH, control: proxy.accuracyDL },
                    { y: 148, control: proxy.efficiencyTF },
                    { y: 168, width: DL_WIDTH, control: proxy.maxExpDL },
                    { y: 185, width: DL_WIDTH, control: proxy.maxKillDL },
                    { y: 202, width: DL_WIDTH, control: maxDamageDL },
                    { y: 224, width: DL_WIDTH, control: proxy.totalKillDL },
                    { y: 241, width: DL_WIDTH, control: proxy.totalDeadDL },
                    { y: 258, width: DL_WIDTH, control: proxy.killRatioDL },
                    { y: 280, width: DL_WIDTH, control: proxy.dealtDmgDL },
                    { y: 297, width: DL_WIDTH, control: proxy.receivedDmgDL },
                    { y: 314, width: DL_WIDTH, control: proxy.dmgRatioDL },
                    { y: 334, control: proxy.avgResultsTF },
                    { y: 354, width: DL_WIDTH, control: proxy.avgExpDL },
                    { y: 371, width: DL_WIDTH, control: proxy.avgDmgDealtDL },
                    { y: 388, width: DL_WIDTH, control: proxy.avgDmgReceivedDL },
                    { y: 405, width: DL_WIDTH, control: proxy.avgKillsDL },
                    { y: 422, width: DL_WIDTH, control: proxy.avgDetectedDL },
                    { y: 439, width: DL_WIDTH, control: specDamageDL },         // vehicle only
                    { y: 439, width: DL_WIDTH, control: avgCaptureDL },         // summary only
                    { y: 456, width: DL_WIDTH, control: avgDefenceDL }          // summary only
                    //{ y: 463, width: DL_WIDTH, control: proxy.avgScoutingDmgDL }
                ];

                setupControls();
                createTextFields();
                updateCommonData(null);
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
                updateCommonData(null);
            }
            catch (ex:Error)
            {
                Logger.add(ex.getStackTrace());
            }
        }

        public function update(raw_data:ProfileVehicleDossierVO):void
        {
            //Logger.addObject(raw_data);

            try
            {
                if (_raw_data == raw_data)
                    return;
                _raw_data = raw_data;
                if (!raw_data)
                    return;

                var vehId:int = page.listComponent.selectedItem.id;

                //Logger.add("vehId: " + vehId)

                setupControls();

                if (page && page.battlesDropdown && (page.battlesDropdown.selectedItem == PROFILE.PROFILE_DROPDOWN_LABELS_TEAM))
                    return;

                if (vehId == 0)
                {
                    updateSummaryData();
                }
                else
                {
                    updateVehicleData(vehId);
                }
            }
            catch (ex:Error)
            {
                Logger.add(ex.getStackTrace());
            }
        }

        // PUBLIC

        public function get page():ProfileTechnique
        {
            try
            {
                return proxy.parent.parent.parent.parent as ProfileTechnique;
            }
            catch (ex:Error)
            {
            }
            return null;
        }

        // PRIVATE

        private function get tech():Technique
        {
            return page ? page.getChildByName("xvm_extension") as Technique : null;
        }

        private function TF(dl:DashLineTextItem):TextField
        {
            return controlsMap[dl];
        }

        private function setupControls():void
        {
            var team:Boolean = page && page.battlesDropdown && (page.battlesDropdown.selectedItem == PROFILE.PROFILE_DROPDOWN_LABELS_TEAM);

            for each (var c:Object in controls)
            {
                if (c.hasOwnProperty("y"))
                    c.control.y = c.y;
                if (c.hasOwnProperty("width"))
                    c.control.width = c.width;
            }
            proxy.winsPercentSign.x = proxy.winsDL.x + proxy.winsDL.width;
            proxy.winsPercentSign.y = proxy.winsDL.y;
            proxy.winsPercentSign.antiAliasType = AntiAliasType.NORMAL;
            proxy.winsPercentSign.visible = team;
            proxy.defeatsPercentSign.x = proxy.defeatsDL.x + proxy.defeatsDL.width;
            proxy.defeatsPercentSign.y = proxy.defeatsDL.y;
            proxy.defeatsPercentSign.antiAliasType = AntiAliasType.NORMAL;
            proxy.defeatsPercentSign.visible = team;
            proxy.survivePercentSign.x = proxy.surviveDL.x + proxy.surviveDL.width;
            proxy.survivePercentSign.y = proxy.surviveDL.y;
            proxy.survivePercentSign.antiAliasType = AntiAliasType.NORMAL;
            proxy.survivePercentSign.visible = team;
            proxy.accuracyPercentSign.x = proxy.accuracyDL.x + proxy.accuracyDL.width;
            proxy.accuracyPercentSign.y = proxy.accuracyDL.y;
            proxy.accuracyPercentSign.antiAliasType = AntiAliasType.NORMAL;
        }

        private function createControls():void
        {
            ratingTF = new TextField();
            ratingTF.antiAliasType = AntiAliasType.ADVANCED;
            ratingTF.multiline = true;
            ratingTF.wordWrap = false;
            ratingTF.x = proxy.efficiencyTF.x + 170;
            ratingTF.y = proxy.battlesDL.y - 62;
            ratingTF.width = 400;
            ratingTF.height = 80;
            var tf:TextFormat = new TextFormat("$FieldFont", 16, Defines.UICOLOR_LABEL);
            ratingTF.styleSheet = Utils.createTextStyleSheet("txt", tf);
            proxy.addChild(ratingTF);

            maxDamageDL = Utils.cloneDashLineTextItem(proxy.battlesDL);
            maxDamageDL.label = Locale.get("Maximum damage") + " (0.8.8+)";
            proxy.addChild(maxDamageDL);

            specDamageDL = Utils.cloneDashLineTextItem(proxy.battlesDL);
            specDamageDL.label = Locale.get("Specific damage (Avg dmg / HP)");
            specDamageDL.visible = false;
            proxy.addChild(specDamageDL);

            avgCaptureDL = Utils.cloneDashLineTextItem(proxy.battlesDL);
            avgCaptureDL.label = Locale.get("Capture points");
            avgCaptureDL.visible = false;
            proxy.addChild(avgCaptureDL);

            avgDefenceDL = Utils.cloneDashLineTextItem(proxy.battlesDL);
            avgDefenceDL.label = Locale.get("Defence points");
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

        public function clearTextFields():void
        {
            for each (var c:* in controls)
            {
                var dl:DashLineTextItem = c.control as DashLineTextItem;
                if (dl != null)
                    TF(dl).htmlText = "";
            }
        }

        private function updateGlobalRatings(data:DossierBase):void
        {
            var s:String = "";
            if (data.stat == null)
                ratingTF.htmlText = "";
            else
            {
                s += size(Locale.get("General stats") + " (" + color(data.stat.dt.substr(0, 10), 0xCCCCCC) + ")", 14) + "\n";

                s += Locale.get("WN6") + ": " + (!data.stat.wn ? "-- (-)" :
                    color((data.stat.xwn == 100 ? "XX" : (data.stat.xwn < 10 ? "0" : "") + data.stat.xwn), MacrosUtil.GetDynamicColorValueInt(Defines.DYNAMIC_COLOR_X, data.stat.xwn)) + " (" +
                    color(App.utils.locale.integer(data.stat.wn), MacrosUtil.GetDynamicColorValueInt(Defines.DYNAMIC_COLOR_WN, data.stat.wn)) + ")") + " ";
                s += Locale.get("EFF") + ": " + (!data.stat.e ? "-- (-)" :
                    color((data.stat.xeff == 100 ? "XX" : (data.stat.xeff < 10 ? "0" : "") + data.stat.xeff), MacrosUtil.GetDynamicColorValueInt(Defines.DYNAMIC_COLOR_X, data.stat.xeff)) + " (" +
                    color(App.utils.locale.integer(data.stat.e), MacrosUtil.GetDynamicColorValueInt(Defines.DYNAMIC_COLOR_EFF, data.stat.e)) + ")") + "\n";

                s += Locale.get("Avg level") + ": " + (!data.stat.lvl ? "-" :
                    color(App.utils.locale.numberWithoutZeros(data.stat.lvl), MacrosUtil.GetDynamicColorValueInt(Defines.DYNAMIC_COLOR_AVGLVL, data.stat.lvl))) + " ";

                ratingTF.htmlText = "<textformat leading='-2'>" + formatHtmlText(s) + "</textformat>";
            }
        }

        private function updateCommonData(data:DossierBase):void
        {
            clearTextFields();

            if (data == null)
                data = new DossierBase({});

            proxy.battlesDL.value = color(App.utils.locale.integer(data.battles));
            //TF(proxy.battlesDL).htmlText = formatHtmlText(getWinsToNextPercentStr(data), Defines.UICOLOR_LABEL);

            var ratingColor:int = MacrosUtil.GetDynamicColorValueInt(Defines.DYNAMIC_COLOR_RATING, Math.round(data.winPercent));
            proxy.winsDL.value = color(App.utils.locale.integer(data.wins));
            TF(proxy.winsDL).htmlText = formatHtmlText(App.utils.locale.float(data.winPercent) + "%", ratingColor) + "  " +
                formatHtmlText(getWinsToNextPercentStr(data), Defines.UICOLOR_LABEL);

            proxy.defeatsDL.value = color(App.utils.locale.integer(data.losses));
            TF(proxy.defeatsDL).htmlText = formatHtmlText(
                color(App.utils.locale.float(data.lossPercent) + "%", Defines.UICOLOR_GOLD) +
                "  " + Locale.get("draws") + ": " + color(App.utils.locale.integer(data.draws), Defines.UICOLOR_GOLD) +
                " (" + color(App.utils.locale.float(data.drawsPercent) + "%", Defines.UICOLOR_GOLD) + ")",
                Defines.UICOLOR_LABEL);

            proxy.surviveDL.value = color(App.utils.locale.integer(data.survived));
            TF(proxy.surviveDL).htmlText = formatHtmlText(App.utils.locale.float(data.survivePercent) + "%", Defines.UICOLOR_GOLD);

            proxy.accuracyDL.value = color(App.utils.locale.float(data.hitsRatio * 100));

            proxy.maxExpDL.value = color(App.utils.locale.integer(data.maxXP));
            proxy.maxKillDL.value = color(App.utils.locale.integer(data.maxFrags));
            maxDamageDL.value = data.maxDamage <= 0 ? color(size("--", 12), Defines.UICOLOR_GOLD2)
                : color(size(App.utils.locale.integer(data.maxDamage), 12));

            proxy.totalKillDL.value = color(App.utils.locale.integer(data.frags));
            proxy.totalDeadDL.value = color(App.utils.locale.integer(data.deaths));

            var ratio:String;

            proxy.killRatioDL.enabled = true;
            ratio = data.deaths <= 0 ? "--" : App.utils.locale.float(data.frags / data.deaths);
            proxy.killRatioDL.value = color(ratio, Defines.UICOLOR_GOLD2);

            proxy.dealtDmgDL.value = color(App.utils.locale.integer(data.damageDealt));

            proxy.receivedDmgDL.value = color(App.utils.locale.integer(data.damageReceived));

            proxy.dmgRatioDL.enabled = true;
            ratio = data.damageReceived <= 0 ? "--" : App.utils.locale.float(data.damageDealt / data.damageReceived);
            proxy.dmgRatioDL.value = color(ratio, Defines.UICOLOR_GOLD2);

            proxy.avgExpDL.value = color(App.utils.locale.integer(data.avgXP));
            proxy.avgDmgDealtDL.value = color(App.utils.locale.integer(data.avgDamageDealt));
            proxy.avgDmgReceivedDL.value = color(App.utils.locale.integer(data.avgDamageReceived));
            proxy.avgKillsDL.value = color(App.utils.locale.float(data.avgFrags));
            proxy.avgDetectedDL.value = color(App.utils.locale.float(data.avgSpotted));

            // stat

            TF(proxy.avgDmgDealtDL).htmlText = "";
            TF(proxy.avgKillsDL).htmlText = "";
            TF(proxy.avgDetectedDL).htmlText = "";

            //proxy.avgScoutingDmgDL.value = "Will be implemented...";
        }

        private function updateSummaryData():void
        {
            //Logger.addObject(tech.accountDossier, 3, "accountDossier");

            var data:AccountDossier = tech.accountDossier;
            prepareData(data);
            //Logger.addObject(data, 3, "prepared");

            updateGlobalRatings(data);
            updateCommonData(data);

            TF(proxy.maxExpDL).htmlText = formatHtmlText(data.maxXPVehicleName, Defines.UICOLOR_GOLD2);
            TF(proxy.maxKillDL).htmlText = formatHtmlText(data.maxFragsVehicleName, Defines.UICOLOR_GOLD2);
            TF(maxDamageDL).htmlText = formatHtmlText(size(data.maxDamageVehicleName, 12), Defines.UICOLOR_GOLD2);

            specDamageDL.visible = false;
            TF(specDamageDL).htmlText = "";

            avgCaptureDL.visible = data.stat != null;
            avgDefenceDL.visible = data.stat != null;
            if (data.stat != null)
            {
                avgCaptureDL.value = color(size(App.utils.locale.float(data.stat.cap / data.stat.b), 12));
                avgDefenceDL.value = color(size(App.utils.locale.float(data.stat.def / data.stat.b), 12));
            }
        }

        private function updateVehicleData(vehId:uint):void
        {
            Dossier.loadVehicleDossier(this, updateVehicleDataCallback, vehId, tech.playerId);
        }

        private function updateVehicleDataCallback(dossier:VehicleDossier):void
        {
            var data:VehicleDossier = dossier;
            prepareData(data);

            updateGlobalRatings(data);
            updateCommonData(data);

            var vdata:VehicleData = VehicleInfo.get(dossier.vehId);
            if (vdata == null)
                return;
            //Logger.addObject(vdata, 2);

            var colorAvg:int;
            var colorTop:int;

            // wins
            if (vdata.avg.R)
            {
                colorAvg = MacrosUtil.GetDynamicColorValueInt(Defines.DYNAMIC_COLOR_RATING, Math.round(vdata.avg.R * 100));
                colorTop = MacrosUtil.GetDynamicColorValueInt(Defines.DYNAMIC_COLOR_RATING, Math.round(vdata.top.R * 100));
                TF(proxy.winsDL).htmlText += formatHtmlText(
                    " " + Locale.get("avg") + ": " + color(App.utils.locale.float(vdata.avg.R * 100), colorAvg) +
                    " " + Locale.get("top") + ": " + color(App.utils.locale.float(vdata.top.R * 100), colorTop),
                    Defines.UICOLOR_LABEL);
            }

            // survival
            if (vdata.avg.U)
            {
                TF(proxy.surviveDL).htmlText += formatHtmlText(
                    " " + Locale.get("avg") + ": " + color(App.utils.locale.float(vdata.avg.U * 100), Defines.UICOLOR_GOLD) +
                    " " + Locale.get("top") + ": " + color(App.utils.locale.float(vdata.top.U * 100), Defines.UICOLOR_GOLD),
                    Defines.UICOLOR_LABEL);
            }

            // dmg
            if (vdata.avg.D)
            {
                TF(proxy.avgDmgDealtDL).htmlText = formatHtmlText(
                    Locale.get("avg") + ": " + color(App.utils.locale.integer(vdata.avg.D), Defines.UICOLOR_GOLD) +
                    " " + Locale.get("top") + ": " + color(App.utils.locale.integer(vdata.top.D), Defines.UICOLOR_GOLD),
                    Defines.UICOLOR_LABEL);
            }

            // frags
            if (vdata.avg.F)
            {
                TF(proxy.avgKillsDL).htmlText = formatHtmlText(
                    Locale.get("avg") + ": " + color(App.utils.locale.float(vdata.avg.F), Defines.UICOLOR_GOLD) +
                    " " + Locale.get("top") + ": " + color(App.utils.locale.float(vdata.top.F), Defines.UICOLOR_GOLD),
                    Defines.UICOLOR_LABEL);
            }

            // spotted
            if (vdata.avg.S)
            {
                TF(proxy.avgDetectedDL).htmlText = formatHtmlText(
                    Locale.get("avg") + ": " + color(App.utils.locale.float(vdata.avg.S), Defines.UICOLOR_GOLD) +
                    " " + Locale.get("top") + ": " + color(App.utils.locale.float(vdata.top.S), Defines.UICOLOR_GOLD),
                    Defines.UICOLOR_LABEL);
            }

            // specific damage
            var specDmg:Number = data.avgDamageDealt / vdata.hpTop;
            specDamageDL.visible = true;
            specDamageDL.value = color(size(App.utils.locale.float(specDmg), 12));

            if (vdata.avg.E)
            {
                TF(specDamageDL).htmlText = formatHtmlText(size(
                    Locale.get("avg") + ": " + color(App.utils.locale.numberWithoutZeros(vdata.avg.E), Defines.UICOLOR_GOLD) +
                    " " + Locale.get("top") + ": " + color(App.utils.locale.numberWithoutZeros(vdata.top.E), Defines.UICOLOR_GOLD),
                    12), Defines.UICOLOR_LABEL);
            }

            avgCaptureDL.visible = false;
            avgDefenceDL.visible = false;
        }

        private function prepareData(dossier:DossierBase):void
        {
            try
            {
                if (dossier == null)
                    return;

                //Logger.addObject(dossier.getAllVehiclesList());
                // skip empty result - data is not loaded yet
                if (dossier.battles <= 0)
                    return;

                if (dossier.stat == null)
                    setStatData(dossier);

                //Logger.addObject(data);
            }
            catch (ex:Error)
            {
                Logger.add(ex.getStackTrace());
            }
        }

        private function getWinsToNextPercentStr(data:DossierBase):String
        {
            // Wins to next percent
            if (data.winPercent <= 0 || data.winPercent >= 100)
                return "";

            var r1:Number = Math.round(data.winPercent) / 100 + 0.005;
            var r2:Number = int(data.winPercent) / 100 + 0.01;
            var b1:Number = (data.battles * r1 - data.wins) / (1 - r1);
            var b2:Number = (data.battles * r2 - data.wins) / (1 - r2);
            b1 = Math.max(0, b1 % 1 == 0 ? b1 : (int(b1) + 1));
            b2 = Math.max(0, b2 % 1 == 0 ? b2 : (int(b2) + 1));
            // full
            /*
            return (b2 > b1)
                ? color(App.utils.locale.integer(b1), Defines.UICOLOR_GOLD) + Locale.get(" to ") +
                    color(App.utils.locale.float((r2 * 100 - 0.5).toFixed(1)) + "%", Defines.UICOLOR_GOLD) + " / " +
                    color(App.utils.locale.integer(b2), Defines.UICOLOR_GOLD) + Locale.get(" to ") +
                    color(App.utils.locale.float((r2 * 100).toFixed(1)) + "%", Defines.UICOLOR_GOLD)
                : color(App.utils.locale.integer(b2), Defines.UICOLOR_GOLD) + Locale.get(" to ") +
                    color(App.utils.locale.float((r2 * 100).toFixed(1)) + "%", Defines.UICOLOR_GOLD) + " / " +
                    color(App.utils.locale.integer(b1), Defines.UICOLOR_GOLD) + Locale.get(" to ") +
                    color(App.utils.locale.float((r2 * 100 + 0.5).toFixed(1)) + "%", Defines.UICOLOR_GOLD);
            */
            // short
            return (b2 > b1)
                ? color(App.utils.locale.integer(b1), Defines.UICOLOR_GOLD) + Locale.get(" to ") +
                    color(App.utils.locale.float((r2 * 100 - 0.5).toFixed(1)) + "%", Defines.UICOLOR_GOLD)
                : color(App.utils.locale.integer(b2), Defines.UICOLOR_GOLD) + Locale.get(" to ") +
                    color(App.utils.locale.float((r2 * 100).toFixed(1)) + "%", Defines.UICOLOR_GOLD);
        }

        private function setStatData(data:DossierBase):void
        {
            var stat:StatData = Stat.getUserDataByName(tech.playerName);
            if (stat == null)
                return;
            data.stat = stat;
        }

        private function parseNumber(str:String):Number
        {
            var s:String = "";
            var a:Array = str.split('');
            for (var i:int = 0; i < a.length; ++i)
            {
                var x:String = a[i];
                if (x >= '0' && x <= '9')
                    s += x;
            }
            return parseInt(s);
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
    }
}
