/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * http://www.modxvm.com/
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CTextsTopClan implements ICloneable
    {
        public var top:String;
        public var persist:String;
        public var regular:String;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }
    }
}
