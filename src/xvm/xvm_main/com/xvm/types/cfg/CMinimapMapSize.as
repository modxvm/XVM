/**
 * XVM Config
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CMinimapMapSize extends Object implements ICloneable
    {
        public var enabled:*;
        public var format:String;
        public var alpha:*;
        public var offsetX:*;
        public var offsetY:*;
        public var shadow:CShadow;
        public var width:*;
        public var height:*;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }
    }
}
