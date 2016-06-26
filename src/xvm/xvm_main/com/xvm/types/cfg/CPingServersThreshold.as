/**
 * XVM Config
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CPingServersThreshold extends Object implements ICloneable
    {
        public var great:*;
        public var good:*;
        public var poor:*;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }
    }
}
