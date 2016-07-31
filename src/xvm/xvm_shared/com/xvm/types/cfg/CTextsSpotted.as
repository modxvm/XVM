/**
 * XVM Config
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CTextsSpotted extends Object implements ICloneable
    {
        public var neverSeen:String;
        public var lost:String;
        public var spotted:String;
        public var dead:String;
        public var neverSeen_arty:String;
        public var lost_arty:String;
        public var spotted_arty:String;
        public var dead_arty:String;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }
    }
}
