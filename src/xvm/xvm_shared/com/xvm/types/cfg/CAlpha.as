/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CAlpha implements ICloneable
    {
        public var avglvl:Array;
        public var eff:Array;
        public var hp:Array;
        public var hp_ratio:Array;
        public var kb:Array;
        public var spotted:Object;
        public var t_battles:Array;
        public var tdb:Array;
        public var tdv:Array;
        public var tfb:Array;
        public var tsb:Array;
        public var wgr:Array;
        public var winrate:Array;
        public var wn8:Array;
        public var wtr:Array;
        public var x:Array;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }
    }
}
