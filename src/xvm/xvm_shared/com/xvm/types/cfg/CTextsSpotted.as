/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CTextsSpotted implements ICloneable
    {
        public var dead:String;
        public var dead_arty:String;
        public var lost:String;
        public var lost_arty:String;
        public var neverSeen:String;
        public var neverSeen_arty:String;
        public var spotted:String;
        public var spotted_arty:String;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }
    }
}
