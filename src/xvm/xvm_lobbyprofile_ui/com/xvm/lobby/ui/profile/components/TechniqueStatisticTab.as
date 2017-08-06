/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * http://www.modxvm.com/
 */
package com.xvm.lobby.ui.profile.components
{
    import com.xfw.*;
    import com.xfw.events.*;
    import com.xvm.*;
    import com.xvm.lobby.ui.profile.*;
    import com.xvm.types.dossier.*;
    import com.xvm.types.stat.*;
    import flash.display.*;
    import flash.text.*;
    import net.wg.gui.lobby.profile.pages.technique.*;
    import net.wg.gui.lobby.profile.pages.technique.data.*;
    import scaleform.gfx.*;

    public class TechniqueStatisticTab
    {
        private var proxy:UI_TechniqueStatisticTab;

        private var _raw_data:ProfileVehicleDossierVO;

        public var ratingTF:TextField;
        public var winsToPercentGlobalTF:TextField;
        public var winsToPercentTF:TextField;

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
                tech.addEventListener(Technique.EVENT_VEHICLE_DOSSIER_LOADED, onVehicleDossierLoaded, false, 0, true);
                createControls();
                updateGlobalWinsToPercent();
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        public function onDispose():void
        {
            if (tech)
            {
                tech.removeEventListener(Technique.EVENT_VEHICLE_DOSSIER_LOADED, onVehicleDossierLoaded);
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
            return page.getChildByName("xvm_extension") as Technique;
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

        // create controls

        private function _createTextField(x:Number, y:Number, width:Number, height:Number, fontSize:Number):TextField
        {
            var tf:TextField = new TextField();
            tf.mouseEnabled = false;
            tf.selectable = false;
            TextFieldEx.setNoTranslate(tf, true);
            tf.antiAliasType = AntiAliasType.ADVANCED;
            tf.multiline = true;
            tf.wordWrap = false;
            tf.x = x;
            tf.y = y;
            tf.width = width;
            tf.height = height;
            tf.styleSheet = XfwUtils.createTextStyleSheet("txt", new TextFormat("$FieldFont", fontSize, XfwConst.UICOLOR_LABEL));
            return tf;
        }

        private function createControls():void
        {
            // rating
            ratingTF = _createTextField(220, -50, 400, 200, 14);
            proxy.addChild(ratingTF);

            proxy.scrollPane.y += 10;
            proxy.scrollPane.height -= 10;
            proxy.scrollBar.y += 10;
            proxy.scrollBar.height -= 10;

            winsToPercentGlobalTF = _createTextField(130, -1, 271, 25, 14);
            proxy.addChild(winsToPercentGlobalTF);

            winsToPercentTF = _createTextField(120, 65, 200, 25, 14);
            Sprite(proxy.scrollPane.target).addChild(winsToPercentTF);
        }

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
                    if (stat)
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
            {
                ratingTF.htmlText = "";
            }
            else
            {
                var dt:String = isNaN(data.stat.ts) ? Locale.get("unknown") : XfwUtils.FormatDate("Y-m-d", new Date(data.stat.ts));

                s += size(Locale.get("General stats") + " (" + color(dt, 0xCCCCCC) + ")", 13) + "\n";

                s += Locale.get("WN8") + ": " + (!data.stat.wn8 ? "-- (-)" :
                    color((data.stat.xwn8 == 100 ? "XX" : (data.stat.xwn8 < 10 ? "0" : "") + data.stat.xwn8), MacrosUtils.getDynamicColorValueInt(Defines.DYNAMIC_COLOR_X, data.stat.xwn8)) + " (" +
                    color(App.utils.locale.integer(data.stat.wn8), MacrosUtils.getDynamicColorValueInt(Defines.DYNAMIC_COLOR_WN8, data.stat.wn8)) + ")") + " ";
                s += Locale.get("EFF") + ": " + (!data.stat.eff ? "-- (-)" :
                    color((data.stat.xeff == 100 ? "XX" : (data.stat.xeff < 10 ? "0" : "") + data.stat.xeff), MacrosUtils.getDynamicColorValueInt(Defines.DYNAMIC_COLOR_X, data.stat.xeff)) + " (" +
                    color(App.utils.locale.integer(data.stat.eff), MacrosUtils.getDynamicColorValueInt(Defines.DYNAMIC_COLOR_EFF, data.stat.eff)) + ")") + "\n";

                s += Locale.get("Avg level") + ": " + (!data.stat.lvl ? "-" :
                    color(App.utils.locale.numberWithoutZeros(data.stat.lvl), MacrosUtils.getDynamicColorValueInt(Defines.DYNAMIC_COLOR_AVGLVL, data.stat.lvl))) + "\n";

                ratingTF.htmlText = "<textformat leading='-2'>" + formatHtmlText(s) + "</textformat>";
            }
        }

        private function updateGlobalWinsToPercent():void
        {
            if (tech.accountDBID == 0)
            {
                var adata:AccountDossier = tech.accountDossier;
                var ratingColor:int = MacrosUtils.getDynamicColorValueInt(Defines.DYNAMIC_COLOR_WINRATE, Math.round(adata.winPercent));
                winsToPercentGlobalTF.htmlText = "<p align='right'>" + formatHtmlText(
                    size(Locale.get("Wins"), 13) + ": " + formatHtmlText(size(App.utils.locale.float(adata.winPercent) + "%", 13), ratingColor) + "  " +
                    formatHtmlText(size(getWinsToNextPercentStr(adata), 13), XfwConst.UICOLOR_LABEL)) + "</p>";
            }
        }

        private function onVehicleDossierLoaded(e:ObjectEvent):void
        {
            if (proxy.baseDisposed)
                return;

            var dossier:VehicleDossier = e.result as VehicleDossier;
            //Logger.addObject(dossier);

            prepareData(dossier);

            updateGlobalRatings(dossier);

            winsToPercentTF.htmlText = "<p align='right'>" + formatHtmlText(size(getWinsToNextPercentStr(dossier)), XfwConst.UICOLOR_LABEL) + "</p>";
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
                    ? color(App.utils.locale.integer(b1), XfwConst.UICOLOR_GOLD) + Locale.get("toWithSpaces") +
                        color(App.utils.locale.numberWithoutZeros((r2 * 100 - 0.5).toFixed(1)) + "%", XfwConst.UICOLOR_GOLD)
                    : color(App.utils.locale.integer(b2), XfwConst.UICOLOR_GOLD) + Locale.get("toWithSpaces") +
                        color(App.utils.locale.numberWithoutZeros((r2 * 100).toFixed(1)) + "%", XfwConst.UICOLOR_GOLD);

            if (page is ProfileTechniquePage)
            {
                // full
                info += " / " + ((b2 > b1)
                    ? color(App.utils.locale.integer(b2), XfwConst.UICOLOR_GOLD) + Locale.get("toWithSpaces") +
                        color(App.utils.locale.numberWithoutZeros((r2 * 100).toFixed(1)) + "%", XfwConst.UICOLOR_GOLD)
                    : color(App.utils.locale.integer(b1), XfwConst.UICOLOR_GOLD) + Locale.get("toWithSpaces") +
                        color(App.utils.locale.numberWithoutZeros((r2 * 100 + 0.5).toFixed(1)) + "%", XfwConst.UICOLOR_GOLD));
            }

            return info;
        }
    }
}
