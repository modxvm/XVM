/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CSquad implements ICloneable
    {
        public var enabled:*;
        public var showClan:*;
        public var formatInfoField:String;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }
    }
}
