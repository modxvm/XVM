/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.types.cfg
{
    import com.xfw.*;
    import com.xvm.*;

    public dynamic class CSixthSense implements ICloneable
    {
        public var offsetX:*;
        public var offsetY:*;
        public var useOldInitialPosition:*;
        public var alpha:*;
        public var scale:*;
        public var icon:String;
        public var duration:*;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }

        internal function applyGlobalMacros():void
        {
            icon = Macros.FormatStringGlobal(icon, "xvm://res/SixthSense.png");
        }
    }
}
