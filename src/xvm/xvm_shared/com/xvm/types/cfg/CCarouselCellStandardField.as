/**
 * XVM Config
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CCarouselCellStandardField extends Object implements ICloneable
    {
        public var enabled:*;
        public var dx:*;
        public var dy:*;
        public var alpha:*;
        public var scale:*;
        public var textFormat:CTextFormat;
        public var shadow:CShadow;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }
    }
}
