/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * http://www.modxvm.com/
 */
package com.xvm.infrastructure
{
    import com.xfw.infrastructure.*;
    import flash.events.*;

    public interface IXvmView extends IXfwView
    {
        function onConfigLoaded(e:Event):void;
    }
}
