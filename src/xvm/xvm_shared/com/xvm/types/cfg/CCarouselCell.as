/**
 * XVM Config
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CCarouselCell extends Object implements ICloneable
    {
        public var width:*;
        public var height:*;
        public var gap:*;
        public var fields:CCarouselCellStandardFields;
        public var extraFields:Array;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }
    }
}
