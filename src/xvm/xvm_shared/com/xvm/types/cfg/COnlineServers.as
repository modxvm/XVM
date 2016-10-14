/**
 * XVM Config
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class COnlineServers extends Object implements ICloneable
    {
        public var enabled:*;
        public var x:*;
        public var y:*;
        public var hAlign:String;
        public var vAlign:String;
        public var alpha:*;
        public var delimiter:String;
        public var maxRows:*;
        public var columnGap:*;
        public var leading:*;
        public var layer:String;
        public var showTitle:*;
        public var showServerName:*;
        public var minimalNameLength:*;
        public var minimalValueLength:*;
        public var errorString:String;
        public var ignoredServers:Array;
        public var fontStyle:CPingServersFontStyle;
        public var threshold:CPingServersThreshold;
        public var shadow:CShadow;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }
    }
}
