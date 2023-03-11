/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CCarouselCellStandardField implements ICloneable
    {
        public var alpha:*;
        public var dx:*;
        public var dy:*;
        public var enabled:*;
        public var scale:*;
        public var shadow:CShadow;
        public var textFormat:CTextFormat;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }
    }
}
