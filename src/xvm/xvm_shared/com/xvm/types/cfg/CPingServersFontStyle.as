/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CPingServersFontStyle implements ICloneable
    {
        public var name:String;
        public var size:*;
        public var bold:*;
        public var italic:*;
        public var color: CPingServersFontStyleColors;
        public var markCurrentServer:*;
        public var serverColor:*;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }
    }
}
