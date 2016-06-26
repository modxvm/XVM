/**
 * XVM Config
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CFragCorrelation extends Object implements ICloneable
    {
        public var showAliveNotFrags:*;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }
    }
}
