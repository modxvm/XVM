package xvm.vehiclemarkers_ui
{
    import com.xfw.*;
    import com.xvm.*;
    import flash.utils.*;
    import flash.external.*;

    public dynamic class XvmVehicleMarker extends VehicleMarker
    {
        public function XvmVehicleMarker()
        {
            //Logger.add(getQualifiedClassName(this));
            ExternalInterface.call("xvm.cmd", "log", "create xvm marker");
            super();
        }
    }
}
