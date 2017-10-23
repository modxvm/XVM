/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CMarkersDamageText implements ICloneable
    {
        public var enabled:*;
        public var x:*;
        public var y:*;
        public var alpha:*;
        public var color:*;
        public var textFormat:CTextFormat;
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
