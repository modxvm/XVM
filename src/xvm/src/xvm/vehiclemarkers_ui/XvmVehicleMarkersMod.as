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
    Xvm;

    /**
     *  This class is used to link UI classes into *_ui.swf
     */
    public class XvmVehicleMarkersMod extends Sprite
    {
        private static var inCommandHandler:Function = null;
        private var xvm:Xvm;

        public function XvmVehicleMarkersMod():void
        {
            visible = false;
            ExternalInterface.addCallback("xvm.as.cmd", as_cmd);
            inCommandHandler = Xfw.registerCommandProviders(py_cmd);
            xvm = new Xvm();
        }

        // Python-Flash communication

        private function py_cmd(...rest):*
        {
            return ExternalInterface.call("xvm.cmd", rest);
        }

        // Handle ExternalInterface callback
        private function as_cmd(command:String, ...rest):*
        {
            try
            {
                return (inCommandHandler != null) ? inCommandHandler.apply(null, rest) : null;
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }
    }
}
