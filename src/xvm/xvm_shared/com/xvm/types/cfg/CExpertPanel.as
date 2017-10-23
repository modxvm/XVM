/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CExpertPanel implements ICloneable
    {
        public var delay:*;
        public var scale:*;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }
    }
}
