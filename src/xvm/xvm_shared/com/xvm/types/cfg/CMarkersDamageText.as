/**
 * XVM Config
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CMarkersDamageText extends Object implements ICloneable
    {
        public var visible:*;
        public var x:*;
        public var y:*;
        public var alpha:*;
        public var color:*;
        public var font:*;
        public var shadow:CShadow;
        public var speed:*;
        public var maxRange:*;
        public var damageMessage:String;
        public var blowupMessage:String;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }
    }
}
