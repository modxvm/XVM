/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CPingServersFontStyle implements ICloneable
    {
        public var bold:*;
        public var color:Object;
        public var italic:*;
        public var name:String;
        public var serverColor:*;
        public var size:*;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }
    }
}
