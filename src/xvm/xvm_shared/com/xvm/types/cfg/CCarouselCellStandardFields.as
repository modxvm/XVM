/**
 * XVM Config
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CCarouselCellStandardFields extends Object implements ICloneable
    {
        public var tankType:CCarouselCellStandardField;
        public var level:CCarouselCellStandardField;
        public var xp:CCarouselCellStandardField;
        public var tankName:CCarouselCellStandardField;
        public var rentInfo:CCarouselCellStandardField;
        public var clanLock:CCarouselCellStandardField;
        public var info:CCarouselCellStandardField;
        public var infoBuy:CCarouselCellStandardField;
        public var price:CCarouselCellStandardField;
        public var actionPrice:CCarouselCellStandardField;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }
    }
}
