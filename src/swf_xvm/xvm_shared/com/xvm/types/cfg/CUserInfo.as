/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CUserInfo implements ICloneable
    {
        public var inHangarFilterEnabled:*;
        public var showXTEColumn:*;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }
    }
}
