/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.types.cfg
{
    import com.xfw.*;
    import com.xvm.*;

    public dynamic class CMarkersHealthBarBorder implements ICloneable
    {
        public var alpha:*;
        public var color:*;
        public var size:*;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }

        internal function applyGlobalMacros():void
        {
            if (color == null)
            {
                color = "{{c:system}}";
            }
            size = Macros.FormatNumberGlobal(size, 1);
        }
    }
}
