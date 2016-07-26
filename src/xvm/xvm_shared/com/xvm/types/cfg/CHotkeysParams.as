/**
 * XVM Config
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CHotkeysParams extends Object implements ICloneable
    {
        public var enabled:*;
        public var keyCode:*;
        public var onHold:*;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }
    }
}
