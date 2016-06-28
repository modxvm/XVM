/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package xvm.vehiclemarkers_ui
{
    import com.xfw.*;
    import flash.display.*;
    import flash.external.*;

    XvmVehicleMarker;

    /**
     *  This class is used to link UI classes into *_ui.swf
     */
    public class XvmVehicleMarkersMod extends Sprite
    {
        public function XvmVehicleMarkersMod():void
        {
            super();
            Xfw.registerCommandProvider(xvm_cmd);
        }

        private function xvm_cmd(... rest):*
        {
            rest.unshift("xvm.cmd");
            return ExternalInterface.call.apply(null, rest);
        }
    }
}
