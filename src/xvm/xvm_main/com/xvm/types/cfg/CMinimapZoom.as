/**
 * XVM Config
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CMinimapZoom extends Object implements ICloneable
    {
        public var pixelsBack:*;
        public var centered:*;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }
    }
}
