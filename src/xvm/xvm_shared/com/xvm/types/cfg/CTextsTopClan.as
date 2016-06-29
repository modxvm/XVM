/**
 * XVM Config
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CTextsTopClan extends Object implements ICloneable
    {
        public var top:String;
        public var persist:String;
        public var regular:String;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }
    }
}
