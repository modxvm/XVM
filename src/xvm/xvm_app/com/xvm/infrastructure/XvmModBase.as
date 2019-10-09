/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
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
            try
            {
                var mods:Vector.<IXfwView> = super.processView(view, populated);
                if (mods)
                {
                    Xvm.addEventListener(Defines.XVM_EVENT_CONFIG_LOADED, function(e:Event):void { onConfigLoaded(e, mods); }, false);
                }
                return mods;
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
            return null;
        }

        private function onConfigLoaded(e:Event, mods:Vector.<IXfwView>):void
        {
            var len:int = mods.length;
            for (var i:int = 0; i < len; ++i)
            {
                var mod:IXvmView = mods[i] as IXvmView;
                if (mod)
                {
                    if (mod.isActive)
                    {
                        XfwUtils.safeCall(mod, mod.onConfigLoaded, [e]);
                    }
                }
            }
        }
    }
}
