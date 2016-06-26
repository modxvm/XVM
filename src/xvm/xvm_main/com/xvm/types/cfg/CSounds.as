/**
 * XVM Config
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.types.cfg
{
    import com.xfw.*;
    import flash.utils.*;

    public dynamic class CSounds extends Object implements ICloneable
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
