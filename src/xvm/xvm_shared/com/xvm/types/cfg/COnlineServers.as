/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class COnlineServers implements ICloneable
    {
        public var alpha:*;
        public var bgImage:String;
        public var columnGap:*;
        public var currentServerFormat:String;
        public var delimiter:String;
        public var enabled:*;
        public var fontStyle:CPingServersFontStyle;
        public var hAlign:String;
        public var layer:String;
        public var leading:*;
        public var maxRows:*;
        public var minimalNameLength:*;
        public var minimalValueLength:*;
        public var shadow:CShadow;
        public var showServerName:*;
        public var showTitle:*;
        public var threshold:Object;
        public var vAlign:String;
        public var x:*;
        public var y:*;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }
    }
}
