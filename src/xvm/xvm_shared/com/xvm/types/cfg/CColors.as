/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CColors implements ICloneable
    {
        public var system:Object;
        public var dmg_kind:Object;
        public var vtype:Object;
        public var spotted:Object;
        public var totalHP:Object;
        public var damage:Object;
        public var hp:Array;
        public var hp_ratio:Array;
        public var x:Array;
        public var eff:Array;
        public var wtr:Array;
        public var wn8:Array;
        public var wgr:Array;
        public var winrate:Array;
        public var kb:Array;
        public var avglvl:Array;
        public var t_battles:Array;
        public var tdb:Array;
        public var tdv:Array;
        public var tfb:Array;
        public var tsb:Array;
        public var wn8effd:Array;
        public var damageRating:Array;
        public var hitsRatio:Array;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }
    }
}
