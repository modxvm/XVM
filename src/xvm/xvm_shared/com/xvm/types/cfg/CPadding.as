/**
 * XVM Config
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CPadding extends Object implements ICloneable
    {
        public var horizontal:*;
        public var vertical:*;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }
    }
}
