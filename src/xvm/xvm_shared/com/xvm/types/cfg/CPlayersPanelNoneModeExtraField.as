/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CPlayersPanelNoneModeExtraField implements ICloneable
    {
        public var formats:Array;
        public var height:*;
        public var width:*;
        public var x:*;
        public var y:*;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }
    }
}
