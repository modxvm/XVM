/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * http://www.modxvm.com/
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CPingServersThreshold implements ICloneable
    {
        public var great:*;
        public var good:*;
        public var poor:*;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }
    }
}
