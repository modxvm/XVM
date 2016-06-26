/**
 * XVM Config
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CMinimapCirclesViewRange extends Object implements ICloneable
    {
        public var enabled:*;
        public var distance:*;
        public var scale:*;
        public var thickness:*;
        public var alpha:*;
        public var color:*;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }
    }
}
