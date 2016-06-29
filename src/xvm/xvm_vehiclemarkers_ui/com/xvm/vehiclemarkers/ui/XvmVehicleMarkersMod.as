/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.vehiclemarkers.ui
{
    import com.xfw.*;
    import com.xvm.*;
    import flash.display.*;
    import flash.external.*;

    XvmVehicleMarker;

    /**
     * This class is used as wrapper for Flash->Python communication.
     */
    public class XvmVehicleMarkersMod extends Xvm
    {
        public function XvmVehicleMarkersMod():void
        {
            Xfw.registerCommandProvider(xvm_cmd);
            Logger.counterPrefix = "V";
            super();
        }

        private function xvm_cmd(... rest):*
        {
            rest.unshift("xvm.cmd");
            return ExternalInterface.call.apply(null, rest);
        }
    }
}
