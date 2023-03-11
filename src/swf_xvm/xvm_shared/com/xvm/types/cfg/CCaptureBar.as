/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CCaptureBar implements ICloneable
    {
        public var ally:CCaptureBarTeam;
        public var block:CCaptureBarTeam;
        public var distanceOffset:*;
        public var enabled:*;
        public var enemy:CCaptureBarTeam;
        public var hideProgressBar:*;
        public var y:*;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }
    }
}
