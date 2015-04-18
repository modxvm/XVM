/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package xvm.profile.components
{
    import com.xfw.*;
    import com.xfw.events.*;
    import com.xvm.*;
    import com.xvm.types.dossier.*;
    import com.xvm.types.stat.*;
    import com.xvm.utils.*;
    import flash.text.*;
    import net.wg.gui.lobby.profile.components.*;
    import net.wg.gui.lobby.profile.pages.technique.*;
    import net.wg.gui.lobby.profile.pages.technique.data.*;
    import xvm.profile.UI.*;

    public class TechniqueStatisticTab
    {
        private static const COLUMN1_WIDTH:int = 210;
        private var proxy:UI_TechniqueStatisticTab;

        private var _raw_data:ProfileVehicleDossierVO;

        public var lastBattleTimeTF:TextField;
        public var ratingTF:TextField;
        public var xteDL:ProfileDashLineTextItem;

        //public var maxDamageDL:DashLineTextItem;
        //public var maxDamageDLLabelTextFormat:TextFormat;
        //public var maxDamageDLValueTextFormat:TextFormat;
        //public var specDamageDL:DashLineTextItem;
        //public var avgCaptureDL:DashLineTextItem;
        //public var avgDefenceDL:DashLineTextItem;
        //public var bottomTF:TextField;

        //public var extraDataPanel:Sprite;
        //public var extraDataPanelHeader:TextField;
        //public var extraDataPanelLines:Array;

        // ENTRY POINTS

        public function TechniqueStatisticTab(proxy:UI_TechniqueStatisticTab)
        {
            //Logger.add("TechniqueStatisticTab");
            try
            {
                this.proxy = proxy;
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        public function configUI():void
        {
            try
            {
                tech.addEventListener(Technique.EVENT_VEHICLE_DOSSIER_LOADED, onVehicleDossierLoaded);

                createControls();

                //setupControls();
                //createTextFields();
                //updateCommonData(null);
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        public function onDispose():void
        {
            tech.removeEventListener(Technique.EVENT_VEHICLE_DOSSIER_LOADED, onVehicleDossierLoaded);
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

                //setupControls();

                if (vehId == 0)
                {
                    updateSummaryData();
                }
                else
                {
                    lastBattleTimeTF.htmlText = "";
                    //updateVehicleData(vehId);
                }
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        // PRIVATE PROPERTIES

        private function get page():ProfileTechnique
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


        private function get tech():Technique
        {
            return page ? page.getChildByName("xvm_extension") as Technique : null;
        }

        // PRIVATE METHODS

        // helpers

        private static function size(txt:String, sz:uint=12):String
        {
            return "<font size='" + sz.toString() + "'>" + txt + "</font>";
        }

        private static function color(txt:String, color:uint = XfwConst.UICOLOR_LIGHT):String
        {
            return "<font color='#" + color.toString(16) + "'>" + txt + "</font>";
        }

        private static function formatHtmlText(txt:String, color:uint=1):String
        {
            return TechniqueStatisticTab.color(size("<span class='txt'>" + (color == 1 ? txt : TechniqueStatisticTab.color(txt, color)) + "</span>"));
        }

        /*
        private function TF(dl:DashLineTextItem):TextField
        {
            return controlsMap[dl];
        }

        private function XDL(n:int):DashLineTextItem
        {
            return extraDataPanelLines[n];
        }
        */

        // create controls

        private function _createTextField(x:Number, y:Number, width:Number, height:Number, fontSize:Number):TextField
        {
            var tf:TextField = new TextField();
            tf.antiAliasType = AntiAliasType.ADVANCED;
            tf.multiline = true;
            tf.wordWrap = false;
            tf.selectable = false;
            tf.mouseEnabled = false;
            tf.x = x;
            tf.y = y;
            tf.width = width;
            tf.height = height;
            tf.styleSheet = WGUtils.createTextStyleSheet("txt", new TextFormat("$FieldFont", fontSize, XfwConst.UICOLOR_LABEL));
            return tf;
        }

        /*private function _createProfileDashLineTextItem():ProfileDashLineTextItem
        {
            var item:ProfileDashLineTextItem = new UI_DashLineTextItemTechnique();
            item.x = proxy.
            return item;
        }*/

        private function createControls():void
        {
            // last battle time
            lastBattleTimeTF = _createTextField(Config.config.userInfo.showExtraDataInProfile ? 0 : -40, -30, 450, 25, 14);
            proxy.addChild(lastBattleTimeTF);

            // rating
            ratingTF = _createTextField(COLUMN1_WIDTH + 5, 0, 400, 200, 16);
            proxy.addChild(ratingTF);

            // xTE
            //xteDL = _createProfileDashLineTextItem();

            /*
            if (Config.config.userInfo.showExtraDataInProfile)
            {
                for each (var c:Object in controls)
                    c.control.x -= 10;
            }

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

            extraDataPanel = new Sprite();

            if (Config.config.userInfo.showExtraDataInProfile)
            {
                extraDataPanel.visible = true;
                extraDataPanel.x = proxy.battlesDL.x + DL_WIDTH + 5;
                extraDataPanel.y = proxy.totalKillDL.y - 10;
                proxy.addChild(extraDataPanel);

                var extraDataPanelHeader:TextField = new TextField();
                extraDataPanelHeader.selectable = false;
                extraDataPanelHeader.antiAliasType = AntiAliasType.ADVANCED;
                extraDataPanelHeader.styleSheet = Utils.createTextStyleSheet("txt", proxy.efficiencyTF.defaultTextFormat);
                extraDataPanelHeader.x = 0;
                extraDataPanelHeader.y = 0;
                extraDataPanelHeader.width = 220;
                extraDataPanelHeader.height = 30;
                extraDataPanelHeader.htmlText = formatHtmlText(Locale.get("Extra data (WoT 0.8.8+)"));
                extraDataPanel.addChild(extraDataPanelHeader);

                extraDataPanelLines = [];
                for (var i:int = 0, y:int = 20; i < 16; ++i, y += 17)
                {
                    var dl:DashLineTextItem = Utils.cloneDashLineTextItem(proxy.battlesDL);
                    dl.x = 0;
                    dl.y = y;
                    dl.width = 220;
                    extraDataPanelLines.push(dl);
                    extraDataPanel.addChild(dl);
                }
                XDL(0).label = Locale.get("Average battle time");
                XDL(1).label = Locale.get("Average battle time per day");
                XDL(2).label = Locale.get("Battles after 0.8.8");
                XDL(3).label = Locale.get("Average experience");
                XDL(4).label = Locale.get("Average experience without premium");
                XDL(5).label = Locale.get("Average distance driven per battle");
                XDL(6).label = Locale.get("Average woodcuts per battle");
                XDL(7).label = Locale.get("Average damage assisted");
                XDL(8).label = Locale.get("    by tracking");
                XDL(9).label = Locale.get("    by spotting");
                XDL(10).label = Locale.get("Average HE shells fired (splash)");
                XDL(11).label = Locale.get("Average HE shells received (splash)");
                XDL(12).label = Locale.get("Average penetrations per battle");
                XDL(13).label = Locale.get("Average hits received");
                XDL(14).label = Locale.get("Average penetrations received");
                XDL(15).label = Locale.get("Average ricochets received");
            }

            bottomTF = new TextField();
            bottomTF.antiAliasType = AntiAliasType.ADVANCED;
            bottomTF.selectable = false;
            bottomTF.multiline = true;
            bottomTF.wordWrap = false;
            bottomTF.x = avgDefenceDL.x;
            bottomTF.height = 80;
            bottomTF.styleSheet = Utils.createTextStyleSheet("txt", new TextFormat("$FieldFont", 12, Defines.UICOLOR_LABEL));
            proxy.addChild(bottomTF);
            */
        }

        /*
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
        */

        /*
        private function setupControls():void
        {
            var battleType = page && page.battlesDropdown ? page.battlesDropdown.selectedItem : null;

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
        */

        // update data

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
                {
                    var stat:StatData = Stat.getUserDataByName(tech.playerName);
                    if (stat != null)
                        dossier.stat = stat;
                }

                //Logger.addObject(data);
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        private function updateGlobalRatings(data:DossierBase):void
        {
            var s:String = "";
            if (data.stat == null)
                ratingTF.htmlText = "";
            else
            {
                var dt:String = isNaN(data.stat.ts) ? Locale.get("unknown") : XfwUtils.FormatDate("Y-m-d", new Date(data.stat.ts));

                s += size(Locale.get("General stats") + " (" + color(dt, 0xCCCCCC) + ")", 14) + "\n";

                s += Locale.get("WN8") + ": " + (!data.stat.wn8 ? "-- (-)" :
                    color((data.stat.xwn8 == 100 ? "XX" : (data.stat.xwn8 < 10 ? "0" : "") + data.stat.xwn8), MacrosUtils.GetDynamicColorValueInt(Defines.DYNAMIC_COLOR_X, data.stat.xwn8)) + " (" +
                    color(App.utils.locale.integer(data.stat.wn8), MacrosUtils.GetDynamicColorValueInt(Defines.DYNAMIC_COLOR_WN8, data.stat.wn8)) + ")") + " ";
                s += Locale.get("EFF") + ": " + (!data.stat.e ? "-- (-)" :
                    color((data.stat.xeff == 100 ? "XX" : (data.stat.xeff < 10 ? "0" : "") + data.stat.xeff), MacrosUtils.GetDynamicColorValueInt(Defines.DYNAMIC_COLOR_X, data.stat.xeff)) + " (" +
                    color(App.utils.locale.integer(data.stat.e), MacrosUtils.GetDynamicColorValueInt(Defines.DYNAMIC_COLOR_EFF, data.stat.e)) + ")") + "\n";

                s += Locale.get("Avg level") + ": " + (!data.stat.lvl ? "-" :
                    color(App.utils.locale.numberWithoutZeros(data.stat.lvl), MacrosUtils.GetDynamicColorValueInt(Defines.DYNAMIC_COLOR_AVGLVL, data.stat.lvl))) + "\n";

                // TODO: temporary solution
                if (tech.playerId == 0)
                {
                    var adata:AccountDossier = tech.accountDossier;
                    var ratingColor:int = MacrosUtils.GetDynamicColorValueInt(Defines.DYNAMIC_COLOR_WINRATE, Math.round(adata.winPercent));
                    s += size(Locale.get("Wins"), 13) + ": " + formatHtmlText(size(App.utils.locale.float(adata.winPercent) + "%", 13), ratingColor) + "  " +
                    formatHtmlText(size(getWinsToNextPercentStr(adata), 13), XfwConst.UICOLOR_LABEL) + "\n";
                    s += "<font size='7'>\n\n\n</font>\t\t\t\t   " + formatHtmlText(size(getWinsToNextPercentStr(data)), XfwConst.UICOLOR_LABEL);
                }

                ratingTF.htmlText = "<textformat leading='-2'>" + formatHtmlText(s) + "</textformat>";
            }
        }

        /*
        private function updateCommonData(data:DossierBase):void
        {
            clearTextFields();

            if (data == null)
                data = new DossierBase({});

            proxy.battlesDL.value = color(App.utils.locale.integer(data.battles));
            //TF(proxy.battlesDL).htmlText = formatHtmlText(getWinsToNextPercentStr(data), Defines.UICOLOR_LABEL);

            var ratingColor:int = MacrosUtil.GetDynamicColorValueInt(Defines.DYNAMIC_COLOR_WINRATE, Math.round(data.winPercent));
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
            maxDamageDL.value = data.maxDamage <= 0 ? color(size("--"), Defines.UICOLOR_GOLD2)
                : color(size(App.utils.locale.integer(data.maxDamage)));

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

            if (Config.config.userInfo.showExtraDataInProfile)
                showExtraData(data);

            //bottomTF.htmlText = "<textformat leading='-2'>" + formatHtmlText(getBottomText(data)) + "</textformat>";
        }
        */

        private function updateSummaryData():void
        {
            //Logger.addObject(tech.accountDossier, 3, "accountDossier");

            var data:AccountDossier = tech.accountDossier;
            prepareData(data);
            //Logger.addObject(data, 3, "prepared");

            // LastBattleTime
            lastBattleTimeTF.htmlText = "<p class='txt' align='right'>" + data.lastBattleTimeStr + "</p>";

            updateGlobalRatings(data);
            //updateCommonData(data);

            //TF(proxy.maxExpDL).htmlText = formatHtmlText(data.maxXPVehicleName, Defines.UICOLOR_GOLD2);
            //TF(proxy.maxKillDL).htmlText = formatHtmlText(data.maxFragsVehicleName, Defines.UICOLOR_GOLD2);
            //TF(maxDamageDL).htmlText = formatHtmlText(size(data.maxDamageVehicleName), Defines.UICOLOR_GOLD2);

            //specDamageDL.visible = false;
            //TF(specDamageDL).htmlText = "";

            //avgCaptureDL.visible = data.stat != null;
            //avgDefenceDL.visible = data.stat != null;
            //if (data.stat != null)
            //{
            //    avgCaptureDL.value = color(size(App.utils.locale.float(data.stat.cap / data.stat.b)));
            //    avgDefenceDL.value = color(size(App.utils.locale.float(data.stat.def / data.stat.b)));
            //}
        }

        private function onVehicleDossierLoaded(e:ObjectEvent):void
        {
            if (proxy.baseDisposed)
                return;

            var dossier:VehicleDossier = e.result as VehicleDossier;
            //Logger.addObject(dossier);

            prepareData(dossier);

            updateGlobalRatings(dossier);

            /*updateCommonData(dossier);

            var vdata:VehicleData = VehicleInfo.get(dossier.vehId);
            if (vdata == null)
                return;
            //Logger.addObject(vdata, 2);

            var colorAvg:int;
            var colorTop:int;

            // wins
            if (vdata.avg.R)
            {
                colorAvg = MacrosUtil.GetDynamicColorValueInt(Defines.DYNAMIC_COLOR_WINRATE, Math.round(vdata.avg.R * 100));
                colorTop = MacrosUtil.GetDynamicColorValueInt(Defines.DYNAMIC_COLOR_WINRATE, Math.round(vdata.top.R * 100));
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
            var specDmg:Number = dossier.avgDamageDealt / vdata.hpTop;
            specDamageDL.visible = true;
            specDamageDL.value = color(size(App.utils.locale.float(specDmg)));

            if (vdata.avg.E)
            {
                TF(specDamageDL).htmlText = formatHtmlText(size(
                    Locale.get("avg") + ": " + color(App.utils.locale.numberWithoutZeros(vdata.avg.E), Defines.UICOLOR_GOLD) +
                    " " + Locale.get("top") + ": " + color(App.utils.locale.numberWithoutZeros(vdata.top.E), Defines.UICOLOR_GOLD)),
                    Defines.UICOLOR_LABEL);
            }

            avgCaptureDL.visible = false;
            avgDefenceDL.visible = false;
            */
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

            var info:String = (b2 > b1)
                    ? color(App.utils.locale.integer(b1), XfwConst.UICOLOR_GOLD) + Locale.get(" to ") +
                        color(App.utils.locale.numberWithoutZeros((r2 * 100 - 0.5).toFixed(1)) + "%", XfwConst.UICOLOR_GOLD)
                    : color(App.utils.locale.integer(b2), XfwConst.UICOLOR_GOLD) + Locale.get(" to ") +
                        color(App.utils.locale.numberWithoutZeros((r2 * 100).toFixed(1)) + "%", XfwConst.UICOLOR_GOLD);

            if (Config.config.userInfo.showExtraDataInProfile || page is ProfileTechniquePage)
            {
                // full
                info += " / " + ((b2 > b1)
                    ? color(App.utils.locale.integer(b2), XfwConst.UICOLOR_GOLD) + Locale.get(" to ") +
                        color(App.utils.locale.numberWithoutZeros((r2 * 100).toFixed(1)) + "%", XfwConst.UICOLOR_GOLD)
                    : color(App.utils.locale.integer(b1), XfwConst.UICOLOR_GOLD) + Locale.get(" to ") +
                        color(App.utils.locale.numberWithoutZeros((r2 * 100 + 0.5).toFixed(1)) + "%", XfwConst.UICOLOR_GOLD));
            }

            return info;
        }

        /*
        private function showExtraData(data:DossierBase):void
        {
            XDL(0).value = formatHtmlText(Utils.FormatDate("H:i:s", new Date(null, null, null, null, null, data.avgBattleLifeTime)));

            var a:AccountDossier = data as AccountDossier;
            if (a != null)
            {
                XDL(1).value = formatHtmlText(Utils.FormatDate("H:i:s", new Date(null, null, null, null, null,
                    (data.battleLifeTime/((a.lastBattleTime - a.creationTime)/86400)))));
                XDL(1).labelTextField.textColor = Defines.UICOLOR_LABEL;
            }
            else
            {
                XDL(1).value = formatHtmlText("--", Defines.UICOLOR_DISABLED);
                XDL(1).labelTextField.textColor = Defines.UICOLOR_DISABLED;
            }

            XDL(2).value = formatHtmlText(App.utils.locale.integer(data.battlesAfter8_8));
            XDL(3).value = formatHtmlText(App.utils.locale.integer(data.avgXP_8_8))
            XDL(4).value = formatHtmlText(App.utils.locale.integer(data.avgOriginalXP_8_8));
            XDL(5).value = formatHtmlText(App.utils.locale.numberWithoutZeros(data.avgMileage_8_8 / 1000));
            XDL(6).value = formatHtmlText(App.utils.locale.numberWithoutZeros(data.avgTreesCut_8_8));
            XDL(7).value = formatHtmlText(App.utils.locale.integer(data.avgDamageAssistedTrack_8_8 + data.avgDamageAssistedRadio_8_8));
            XDL(8).value = formatHtmlText(App.utils.locale.integer(data.avgDamageAssistedTrack_8_8));
            XDL(9).value = formatHtmlText(App.utils.locale.integer(data.avgDamageAssistedRadio_8_8));
            XDL(10).value = formatHtmlText(App.utils.locale.numberWithoutZeros(data.avgHe_hits_8_8));
            XDL(11).value = formatHtmlText(App.utils.locale.numberWithoutZeros(data.avgHeHitsReceived_8_8));
            XDL(12).value = formatHtmlText(App.utils.locale.numberWithoutZeros(data.avgPierced_8_8));
            XDL(13).value = formatHtmlText(App.utils.locale.numberWithoutZeros(data.avgShotsReceived_8_8));
            XDL(14).value = formatHtmlText(App.utils.locale.numberWithoutZeros(data.avgPiercedReceived_8_8));
            XDL(15).value = formatHtmlText(App.utils.locale.numberWithoutZeros(data.avgNoDamageShotsReceived_8_8));
        }
        */
    }
}
