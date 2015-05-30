/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package xvm.svcmsg_ui
{
    import com.xfw.*;
    import com.xvm.infrastructure.*;

    /**
     *  This class is used to link UI classes into *_ui.swf
     */
    public class ServiceMessageUIXvmMod extends XvmModBase
    {
        UI_ServiceMessageIR;
        UI_ServiceMessagePopUp;

        private static const XVM_SVCMSG_INITIALIZED:String = "xvm.xvm_svcmsg_initialized";

        override public function entryPoint():void
        {
            Xfw.cmd(XVM_SVCMSG_INITIALIZED);
        }
    }
}
