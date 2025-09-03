/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.infrastructure
{
    import com.xfw.*;
    import com.xfw.infrastructure.*;
    import flash.events.*;
    import net.wg.infrastructure.interfaces.*;

    public class XvmViewBase extends XfwViewBase implements IXvmView
    {
        public function XvmViewBase(view:IView)
        {
            super(view);
        }

        // virtual
        public function onConfigLoaded(e:Event):void
        {
            //Logger.add("onConfigLoaded: " + view.as_alias);
        }
    }
}
