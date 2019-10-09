/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CTextsXvmUser implements ICloneable
    {
        public var none:String;
        public var off:String;
        public var on:String;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }
    }
}
