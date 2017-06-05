/**
 * XVM Config
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CHangarCamera extends Object implements ICloneable
    {
        public var minDistance:*;
        public var maxDistance:*;
        public var startDistance:*;
        public var zoomSensitivity:*;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }
    }
}
