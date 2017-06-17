/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * http://www.modxvm.com/
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CTextsXvmUser implements ICloneable
    {
        public var on:String;
        public var off:String;
        public var none:String;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }
    }
}
