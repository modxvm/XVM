/**
 * XVM Config
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CCaptureBar extends Object implements ICloneable
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
