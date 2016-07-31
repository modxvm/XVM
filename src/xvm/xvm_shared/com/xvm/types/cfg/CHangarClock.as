/**
 * XVM Config
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CHangarClock extends Object implements ICloneable
    {
        public var enabled:*;
        public var x:*;
        public var y:*;
        public var width:*;
        public var height:*;
        public var topmost:*;
        public var align:String;
        public var valign:String;
        public var textAlign:String;
        public var textVAlign:String;
        public var alpha:*;
        public var rotation:*;
        public var borderColor:*;
        public var bgColor:*;
        public var bgImage:String;
        public var antiAliasType:String;
        public var format:String;
        public var shadow:CShadow;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }
    }
}
