/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CCarouselCell implements ICloneable
    {
        public var extraFields:Array;
        public var fields:CCarouselCellStandardFields;
        public var gap:*;
        public var height:*;
        public var width:*;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }
    }
}
