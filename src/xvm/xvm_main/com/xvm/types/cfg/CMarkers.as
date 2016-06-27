/**
 * XVM Config
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CMarkers extends Object implements ICloneable
    {
        public var enabled:*;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }
    }
}
