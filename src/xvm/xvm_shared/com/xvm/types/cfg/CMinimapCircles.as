/**
 * XVM Config
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    CMinimapCircle;

    public dynamic class CMinimapCircles extends Object implements ICloneable
    {
        public var view:Array;
        public var artillery:CMinimapCirclesRange;
        public var shell:CMinimapCirclesRange;
        public var special:Array;
        public var _internal:CMinimapCirclesInternal;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }
    }
}
