/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CPingServersFontStyleColors implements ICloneable
    {
        public var great:*;
        public var good:*;
        public var poor:*;
        public var bad:*;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }
    }
}
