/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CCarouselCellStandardFields implements ICloneable
    {
        public var actionPrice:CCarouselCellStandardField;
        public var clanLock:CCarouselCellStandardField;
        public var crystalsBorder:CCarouselCellStandardField;
        public var crystalsIcon:CCarouselCellStandardField;
        public var favorite:CCarouselCellStandardField;
        public var flag:CCarouselCellStandardField;
        public var info:CCarouselCellStandardField;
        public var infoBuy:CCarouselCellStandardField;
        public var infoImg:CCarouselCellStandardField;
        public var level:CCarouselCellStandardField;
        public var price:CCarouselCellStandardField;
        public var rentInfo:CCarouselCellStandardField;
        public var stats:CCarouselCellStandardField;
        public var tankIcon:CCarouselCellStandardField;
        public var tankName:CCarouselCellStandardField;
        public var tankType:CCarouselCellStandardField;
        public var xp:CCarouselCellStandardField;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }
    }
}
