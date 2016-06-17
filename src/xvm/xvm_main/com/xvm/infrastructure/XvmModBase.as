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
        override protected function processView(view:IView, populated:Boolean):Vector.<IXfwView>
        {
            var mods:Vector.<IXfwView> = super.processView(view, populated);
            if (mods != null)
            {
                for (var i:int = 0; i < mods.length; ++i)
                {
                    try
                    {
                        var xmod:IXvmView = mods[i] as IXvmView;
                        if (xmod != null)
                        {
                            Xvm.addEventListener(Defines.XVM_EVENT_CONFIG_LOADED,
                                function(e:Event):void { XfwUtils.safeCall(xmod, xmod.onConfigLoaded, [e]); });
                        }
                    }
                    catch (ex:Error)
                    {
                        Logger.err(ex);
                    }
                }
            }
            return mods;
        }
    }
}
