/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.vehiclemarkers.ui
{
    import com.xfw.*;
    import flash.display.*;
    import flash.external.*;

    XvmVehicleMarker;

    /**
     * This class is used as wrapper for Flash->Python communication.
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
