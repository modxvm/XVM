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
            visible = false;
        }

        public function as_xvm_cmd(...rest):*
        {
            ExternalInterface.call("xvm.cmd", "xfw.log", "as_xvm_cmd: " + rest);
            return null;
        }
    }
}
