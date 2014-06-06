/**
 * @author Maxim Schedriviy "m.schedriviy(at)gmail.com"
 */
package xvm.hangar.components.TankParams
{
    import com.xvm.*;
    import com.xvm.types.cfg.*;
    import net.wg.gui.components.controls.*;
    import net.wg.gui.lobby.hangar.*;
    import scaleform.clik.data.*;

    public class VehicleParams
    {
        public static function updateVehicleParams(params:Params):void
        {
            //Logger.addObject(Config.config.minimap.circles._internal);

            var list:WgScrollingList = params.list;
            var dp:DataProvider = list.dataProvider as DataProvider;
            //Logger.addObject(dp, 2);
            var len:Number = dp.length;

            if (getIndex(dp, "xvm_reloadTime") >= 0)
                return;

            var idx:Number;

            // Reload time
            idx = getIndex(dp, "reloadTime");
            var v_reloadTime:String = App.utils.locale.float(getReloadTime(parseFloat(dp[idx].param)));
            var l_reloadTime:String = "<font color='#B4A983'>" + Locale.get("Actual gun reload time") +
                "</font> <font color='#9F9260'>" + Locale.get("(sec)") + "</font>";
            dp.splice(idx + 1, 0, new ParamsVO( { text: "xvm_reloadTime", param: v_reloadTime, selected: true } ));

            // View range
            idx = getIndex(dp, "circularVisionRadius");
            var vr:Object = getViewRanges();
            var v_viewRange:String = App.utils.locale.integer(vr.view_distance);
            var l_viewRange:String = Locale.get("Actual view distance");
            if (vr.stereoscope_distance > 0)
            {
                v_viewRange += " / " + App.utils.locale.integer(vr.stereoscope_distance);
                l_viewRange += " / " + Locale.get("with stereoscope");
            }
            l_viewRange = "<font color='#B4A983'>" + l_viewRange + "</font> <font color='#9F9260'>" + Locale.get("(m)") + "</font>";
            dp.splice(idx + 1, 0, new ParamsVO( { text: "xvm_viewRange", param: v_viewRange, selected: true } ));

            // Radio range
            idx = getIndex(dp, "radioDistance");
            var v_radioRange:String = App.utils.locale.integer(getRadioRange(parseFloat(dp[idx].param)));
            var l_radioRange:String = "<font color='#B4A983'>" + Locale.get("Actual radio range") +
                "</font> <font color='#9F9260'>" + Locale.get("(m)") + "</font>";
            dp.splice(idx + 1, 0, new ParamsVO( { text: "xvm_radioRange", param: v_radioRange, selected: true } ));

            // draw
            dp.invalidate();
            list.height += 28 * 3;
            list.validateNow();

            // fix text
            (list.getRendererAt(getIndex(dp, "xvm_reloadTime")) as TankParam).tfField.htmlText = l_reloadTime;
            (list.getRendererAt(getIndex(dp, "xvm_viewRange")) as TankParam).tfField.htmlText = l_viewRange;
            (list.getRendererAt(getIndex(dp, "xvm_radioRange")) as TankParam).tfField.htmlText = l_radioRange;
        }

        private static function getIndex(dp:DataProvider, text:String):Number
        {
            var len:Number = dp.length;
            for (var i:Number = 0; i < len; ++i)
            {
                if (dp[i].text == text)
                    return i;
            }
            return -1;
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
            var Kcom:Number = K / 10.0;
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

        // http://www.koreanrandom.com/forum/topic/15831-/
        private static function getReloadTime(base_shoot_rate:Number):Number
        {
            var ci:CMinimapCirclesInternal = Config.config.minimap.circles._internal;

            var skill:Number = ci.base_gunners_skill > 0 ? ci.base_gunners_skill : ci.base_commander_skill;
            var Kcmd:Number = ci.base_gunners_skill > 0 ? ci.base_commander_skill * 0.001 : 0;
            var bia:Number = ci.view_brothers_in_arms ? 0.05 : 0;
            var vent:Number = ci.view_ventilation ? 0.05 : 0;
            var cons:Number = ci.view_consumable ? 0.1 : 0;
            var Keq:Number = bia + vent + cons;
            var Kram:Number = ci.view_rammer ? 0.1 : 0;

            return 60.0 / (base_shoot_rate * skill * (1 + Kcmd) * (1 + Keq) * (1 + Kram) / 100);
        }

        // http://www.koreanrandom.com/forum/topic/15831-/
        private static function getRadioRange(base_radio_range:Number):Number
        {
            var ci:CMinimapCirclesInternal = Config.config.minimap.circles._internal;

            var skill:Number = ci.base_radioman_skill > 0 ? ci.base_radioman_skill : ci.base_commander_skill;
            var Kcmd:Number = ci.base_radioman_skill > 0 ? ci.base_commander_skill * 0.001 : 0;
            var bia:Number = ci.view_brothers_in_arms ? 0.05 : 0;
            var vent:Number = ci.view_ventilation ? 0.05 : 0;
            var cons:Number = ci.view_consumable ? 0.1 : 0;
            var Keq:Number = bia + vent + cons;
            var Kinv:Number = ci.view_radioman_inventor * 0.002;

            return base_radio_range * skill * (1 + Kcmd) * (1 + Keq) * (1 + Kinv) / 100;
        }
    }

}
