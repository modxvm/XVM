/**
 * XVM Config
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CXmqp extends Object implements ICloneable
    {
        public var spottedTime:*;
        public var minimapDrawTime:*;
        public var minimapDrawLineWidth:*;
        public var minimapDrawColor:*;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }
    }
}
