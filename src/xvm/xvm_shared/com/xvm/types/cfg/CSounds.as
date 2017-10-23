/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.types.cfg
{
    import com.xfw.*;
    import flash.utils.*;

    public dynamic class CSounds implements ICloneable
    {
        public var enabled:*;
        public var soundBanks:CSoundsBanks;
        public var logSoundEvents:*;
        public var soundMapping:Dictionary;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }
    }
}
