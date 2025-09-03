/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CMarkersDamageText implements ICloneable
    {
        public var alpha:*;
        public var blowupMessage:String;
        public var damageMessage:String;
        public var enabled:*;
        public var maxRange:*;
        public var shadow:CShadow;
        public var speed:*;
        public var textFormat:CTextFormat;
        public var x:*;
        public var y:*;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }
    }
}
