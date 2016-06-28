package xvm.vehiclemarkers_ui
{
    import com.xfw.*;
    import flash.utils.*;
    import flash.external.*;

    public dynamic class XvmVehicleMarker extends VehicleMarker
    {
        public function XvmVehicleMarker()
        {
            super();
        }

        public function test():void
        {
            ExternalInterface.call("xvm.cmd", "xfw.log", "test invoked: " + arguments);
        }
    }
}
