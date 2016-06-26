/**
 * XVM Config
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CCameraArcade extends Object implements ICloneable
    {
        public var distRange:Array;
        public var startDist:*;
        public var scrollSensitivity:*;
        public var dynamicCameraEnabled:*;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }
    }
}
