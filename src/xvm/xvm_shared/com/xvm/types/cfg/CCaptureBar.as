/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CCaptureBar implements ICloneable
    {
        public var enabled:*;
        public var y:*;
        public var distanceOffset:*;
        public var hideProgressBar:*;
        public var enemy:CCaptureBarTeam;
        public var ally:CCaptureBarTeam;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }
    }
}
