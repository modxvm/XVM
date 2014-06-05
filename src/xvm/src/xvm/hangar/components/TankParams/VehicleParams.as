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

            var vr:Object = getViewRanges();

            var list:WgScrollingList = params.list;

            var dp:DataProvider = list.dataProvider as DataProvider;

            var label:String = Locale.get("Current view distance");
            var p:String = App.utils.locale.integer(vr.view_distance);
            if (vr.stereoscope_distance > 0)
            {
                p += " / " + App.utils.locale.integer(vr.stereoscope_distance);
                label += " / " + Locale.get("with stereoscope");
            }
            label = "<font color='#B4A983'>" + label + "</font> <font color='#9F9260'>" + Locale.get("(m)") + "</font>";

            list.height += 28;
            var lastItem:Object = dp.pop();
            dp.push( { label: label, param: p, selected: false } );
            dp.push(lastItem);
            dp.invalidate();
        }

        private static function getViewRanges():Object
        {
            var ci:CMinimapCirclesInternal = Config.config.minimap.circles._internal;

            // Calculations
            var view_distance_vehicle:Number = ci.view_distance_vehicle;
            var bia:Number = ci.view_brothers_in_arms ? 5 : 0;
            var vent:Number = ci.view_ventilation ? 5 : 0;
            var cons:Number = ci.view_consumable ? 10 : 0;

            var K:Number = ci.view_base_commander_skill + bia + vent + cons;
            var Kcom:Number = K / 10.0;
            var Kee:Number = ci.view_commander_eagleEye <= 0 ? 0 : ci.view_commander_eagleEye + bia + vent + cons;
            var Krf:Number = ci.view_radioman_finder <= 0 ? 0 : ci.view_radioman_finder + bia + vent + cons + (ci.view_is_commander_radioman == true ? 0 : Kcom);
            //var M:Number = ci.view_camouflage <= 0 ? 0 : ci.view_camouflage + bia + vent + cons + (ci.view_is_commander_camouflage == true ? 0 : Kcom);

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
    }

}
