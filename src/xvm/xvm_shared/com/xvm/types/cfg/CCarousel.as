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
        public var scrollingSpeed:*;
        public var hideBuyTank:Boolean;
        public var hideBuySlot:Boolean;
        public var showTotalSlots:Boolean;
        public var showUsedSlots:Boolean;
        public var enableLockBackground:Boolean;
        public var filters:Object; // TODO
        public var filtersPadding:CPadding;
        public var nations_order:Array;
        public var types_order:Array;
        public var sorting_criteria:Array;
        public var suppressCarouselTooltips:*;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }
    }
}
