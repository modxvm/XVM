/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.lobby.hangar
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.types.cfg.*;
    import net.wg.gui.lobby.hangar.interfaces.*;
    import scaleform.clik.data.*;

    public class VehicleParams
    {
        public static function updateVehicleParams(params:IVehicleParameters):void
        {
            //Logger.add("updateVehicleParams");
            //Logger.addObject(Config.config.minimap.circles._internal);

            // TODO:9.15
            /*
            if (params == null)
                return;

            if (!Config.config.minimap.circles._internal.is_full_crew)
                return;

            var list:ScrollingListEx = params.paramsList;
            var dp:DataProvider = list.dataProvider as DataProvider;
            //Logger.addObject(dp, 2);
            var len:Number = dp.length;

            var idx:Number;

            // Reload time
            idx = getIndex(dp, MENU.TANK_PARAMS_RELOADTIME);
            var v_reloadTime:String = App.utils.locale.float(getReloadTime());
            var reloadTimeColor1:String = XfwUtils.toHtmlColor(idx >= 0 && dp[idx].selected ? XfwConst.UICOLOR_TEXT1 : XfwConst.UICOLOR_TEXT2);
            var reloadTimeColor2:String = XfwUtils.toHtmlColor(idx >= 0 && dp[idx].selected ? XfwConst.UICOLOR_TEXT2 : XfwConst.UICOLOR_TEXT3);
            var l_reloadTime:String =
                "<font color='" + reloadTimeColor1 + "'>" + Locale.get("gun_reload_time/actual") + " </font>" +
                "<font color='" + reloadTimeColor2 + "'>" + Locale.get("(sec)") + "</font>";
            if (idx >= 0 && getIndex(dp, "xvm_reloadTime") < 0)
                dp.splice(idx + 1, 0, new HangarParamVO( { text: "xvm_reloadTime", param: v_reloadTime, selected: false } ));

            // View range
            idx = getIndex(dp, MENU.TANK_PARAMS_CIRCULARVISIONRADIUS);
            var vr:Object = getViewRanges();
            var v_viewRange:String = App.utils.locale.integer(vr.view_distance);
            var l_viewRange:String = ": " + Locale.get("view_range/base") + " / " + Locale.get("view_range/actual");
            if (vr.stereoscope_distance > 0)
            {
                v_viewRange += " / " + App.utils.locale.integer(vr.stereoscope_distance);
                l_viewRange += " / " + Locale.get("view_range/stereoscope");
            }
            //dp.splice(idx + 1, 0, new ParamsVO( { text: "xvm_viewRange", param: v_viewRange, selected: true } ));

            // Radio range
            idx = getIndex(dp, MENU.TANK_PARAMS_RADIODISTANCE);
            var v_radioRange:String = App.utils.locale.integer(getRadioRange());
            var l_radioRange:String = ": " + Locale.get("radio_range/base") + " / " + Locale.get("radio_range/actual");
            //dp.splice(idx + 1, 0, new ParamsVO( { text: "xvm_radioRange", param: v_radioRange, selected: true } ));

            // draw
            list.height = 22 * dp.length;
            dp.invalidate();
            list.validateNow();

            // fix text
            var param:TankParam;

            idx = getIndex(dp, "xvm_reloadTime");
            if (idx >= 0)
            {
                (list.getRendererAt(idx) as TankParam).tfField.htmlText = l_reloadTime;
            }

            //(list.getRendererAt(getIndex(dp, "xvm_viewRange")) as TankParam).tfField.htmlText = l_viewRange;

            idx = getIndex(dp, MENU.TANK_PARAMS_CIRCULARVISIONRADIUS);
            if (idx >= 0)
            {
                param = list.getRendererAt(idx) as TankParam;
                param.paramField.htmlText += " / " + v_viewRange;
                //Logger.add(param.tfField.htmlText);
                param.tfField.htmlText = param.tfField.htmlText.split(" </FONT><FONT ").join(l_viewRange + " </FONT><FONT ");
            }

            //(list.getRendererAt(getIndex(dp, "xvm_radioRange")) as TankParam).tfField.htmlText = l_radioRange;

            idx = getIndex(dp, MENU.TANK_PARAMS_RADIODISTANCE);
            if (idx >= 0)
            {
                param = list.getRendererAt(idx) as TankParam;
                param.paramField.htmlText += " / " + v_radioRange;
                //Logger.add(param.tfField.htmlText);
                param.tfField.htmlText = param.tfField.htmlText.split(" </FONT><FONT ").join(l_radioRange + " </FONT><FONT ");
            }
            */
        }

        private static function getIndex(dp:DataProvider, textId:String):Number
        {
            var text:String = App.utils.locale.makeString(textId);
            var len:Number = dp.length;
            for (var i:Number = 0; i < len; ++i)
            {
                if (String(dp[i].text).indexOf(text) >= 0)
                    return i;
            }
            return -1;
        }

        private static function parseNumber(str:String):Number
        {
            str = str.split(" ").join("");
            str = str.split(",").join(".");
            return parseFloat(str);
        }

        private static function getViewRanges():Object
        {
            var ci:CMinimapCirclesInternal = Config.config.minimap.circles._internal;

            // Calculations
            var view_distance_vehicle:Number = ci.view_distance_vehicle;
            var bia:Number = ci.view_brothers_in_arms ? 5 : 0;
            var vent:Number = ci.view_ventilation ? 5 : 0;
            var cons:Number = ci.view_consumable ? 10 : 0;

            var K:Number = ci.base_commander_skill + bia + vent + cons;
            var Kcom:Number = K * 0.1;
            var Kee:Number = ci.view_commander_eagleEye <= 0 ? 0 : ci.view_commander_eagleEye + bia + vent + cons;
            var Krf:Number = ci.view_radioman_finder <= 0 ? 0 : ci.view_radioman_finder + bia + vent + cons + (ci.base_radioman_skill > 0 ? Kcom : 0);

            var Kn1:Number = 1;
            var Kn2:Number = 1;

            var view_distance:Number = view_distance_vehicle * (K * 0.0043 + 0.57) * (1 + Kn1 * 0.0002 * Kee) * (1 + 0.0003 * Krf) * Kn2;
            var stereoscope_distance:Number = view_distance * 1.25;
            if (ci.view_coated_optics == true)
                view_distance = view_distance * 1.1

            return {
                view_distance: view_distance,
                stereoscope_distance: ci.view_stereoscope ? stereoscope_distance : 0
            };
        }

        // https://kr.cm/f/t/15831/
        private static function getReloadTime():Number
        {
            var ci:CMinimapCirclesInternal = Config.config.minimap.circles._internal;

            var bia:Number = ci.view_brothers_in_arms ? 5 : 0;
            var vent:Number = ci.view_ventilation ? 5 : 0;
            var cons:Number = ci.view_consumable ? 10 : 0;

            var skill:Number = ci.base_loaders_skill > 0 ? ci.base_loaders_skill : ci.base_commander_skill;
            var cmd:Number = ci.base_loaders_skill > 0 ? (ci.base_commander_skill + bia + vent + cons) * 0.1 : 0;

            var K:Number = (skill + cmd + bia + vent + cons) / 100.0;
            var Kram:Number = ci.view_rammer ? 0.9 : 1.0;

            return Kram * ci.base_gun_reload_time / (0.57 + 0.43 * K);
        }

        // https://kr.cm/f/t/15831/
        private static function getRadioRange():Number
        {
            var ci:CMinimapCirclesInternal = Config.config.minimap.circles._internal;

            var bia:Number = ci.view_brothers_in_arms ? 5 : 0;
            var vent:Number = ci.view_ventilation ? 5 : 0;
            var cons:Number = ci.view_consumable ? 10 : 0;

            var skill:Number = ci.base_radioman_skill > 0 ? ci.base_radioman_skill : ci.base_commander_skill;
            var cmd:Number = ci.base_radioman_skill > 0 ? (ci.base_commander_skill + bia + vent + cons) * 0.1 : 0;

            var K:Number = (skill + cmd + bia + vent + cons) / 100.0;
            var Kinv:Number = 1 + ci.view_radioman_inventor * 0.002;

            return ci.base_radio_distance * (0.57 + 0.43 * K) * Kinv;
        }
    }

}
