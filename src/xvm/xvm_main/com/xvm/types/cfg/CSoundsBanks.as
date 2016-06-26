/**
 * XVM Config
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CSoundsBanks extends Object implements ICloneable
    {
        public var hangar:String;
        public var battle:String;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }
    }
}
