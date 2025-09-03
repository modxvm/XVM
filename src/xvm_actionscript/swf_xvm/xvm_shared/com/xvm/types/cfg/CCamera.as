/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CCamera implements ICloneable
    {
        public var enabled:*;
        public var sniper:CCameraSniper;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }
    }
}
