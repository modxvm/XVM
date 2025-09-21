/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CCarousel implements ICloneable
    {
        public var enabled:*;
        public var cellType:String;
        public var normal:CCarouselCell;
        public var small:CCarouselCell;
        public var rows:*;
        public var backgroundAlpha:*;
        public var slotBackgroundAlpha:*;
        public var showSlotHighlight:Boolean;
        public var slotBorderAlpha:*;
        public var edgeFadeAlpha:*;
        public var scrollingSpeed:*;
        public var showTotalSlots:Boolean;
        public var showUsedSlots:Boolean;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }
    }
}
