/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * http://www.modxvm.com/
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CClanIcon implements ICloneable
    {
        public var show:*;
        public var x:*;
        public var y:*;
        public var xr:*;
        public var yr:*;
        public var h:*;
        public var w:*;
        public var alpha:*;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }
    }
}
