/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * http://www.modxvm.com/
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CCarouselCellStandardFields implements ICloneable
    {
        public var flag:CCarouselCellStandardField;
        public var tankIcon:CCarouselCellStandardField;
        public var tankType:CCarouselCellStandardField;
        public var level:CCarouselCellStandardField;
        public var xp:CCarouselCellStandardField;
        public var tankName:CCarouselCellStandardField;
        public var rentInfo:CCarouselCellStandardField;
        public var clanLock:CCarouselCellStandardField;
        public var info:CCarouselCellStandardField;
        public var infoImg:CCarouselCellStandardField;
        public var infoBuy:CCarouselCellStandardField;
        public var price:CCarouselCellStandardField;
        public var actionPrice:CCarouselCellStandardField;
        public var favorite:CCarouselCellStandardField;
        public var stats:CCarouselCellStandardField;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }
    }
}
