/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CTextsBattleType implements ICloneable
    {
        public var unknown:String;
        public var regular:String;
        public var training:String;
        public var tournament:String;
        public var clan:String;
        public var tutorial:String;
        public var cybersport:String;
        public var event_battles:String;
        public var global_map:String;
        public var tournament_regular:String;
        public var tournament_clan:String;
        public var rated_sandbox:String;
        public var sandbox:String;
        public var fallout_classic:String;
        public var fallout_multiteam:String;
        public var sortie_2:String;
        public var fort_battle_2:String;
        public var ranked:String;
        public var bootcamp:String;
        public var epic_random:String;
        public var epic_random_training:String;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }
    }
}
