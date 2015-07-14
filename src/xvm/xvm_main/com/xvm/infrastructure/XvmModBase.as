/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.infrastructure
{
    import com.xfw.*;
    import com.xfw.infrastructure.*;
    import com.xvm.*;
    import flash.events.*;
    import net.wg.infrastructure.interfaces.*;

    public class XvmModBase extends XfwModBase
    {
        override protected function processView(view:IView, populated:Boolean):IXfwView
        {
            var mod:IXfwView = super.processView(view, populated);
            if (mod != null)
            {
                var xmod:IXvmView = mod as IXvmView;
                if (xmod != null)
                {
                    Xvm.addEventListener(Defines.XVM_EVENT_CONFIG_LOADED,
                        function(e:Event):void { XfwUtils.safeCall(xmod, xmod.onConfigLoaded, [e]); });
                }
            }
            return mod;
        }
    }
}
