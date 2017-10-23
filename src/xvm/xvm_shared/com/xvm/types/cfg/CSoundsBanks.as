/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CSoundsBanks implements ICloneable
    {
        public var hangar:String;
        public var battle:String;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }
    }
}
