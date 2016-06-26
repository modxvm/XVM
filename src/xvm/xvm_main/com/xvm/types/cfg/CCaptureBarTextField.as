/**
 * XVM Config
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CCaptureBarTextField extends Object implements ICloneable
    {
        public var x:*;
        public var y:*;
        public var format:*;
        public var done:*;
        public var shadow:CShadow;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }
    }
}
