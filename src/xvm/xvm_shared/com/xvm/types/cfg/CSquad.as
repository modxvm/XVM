/**
 * XVM Config
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CSquad extends Object implements ICloneable
    {
        public var enabled:*;
        public var showClan:*;
        public var formatInfoField:String;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }
    }
}
