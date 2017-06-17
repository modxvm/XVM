/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * http://www.modxvm.com/
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CPadding implements ICloneable
    {
        public var horizontal:*;
        public var vertical:*;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }
    }
}
