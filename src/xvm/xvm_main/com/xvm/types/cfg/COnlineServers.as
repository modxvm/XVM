/**
 * XVM Config
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.types.cfg
{
    public dynamic class COnlineServers extends Object
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
        public var topmost:*;
        public var showTitle:*;
        public var showServerName:*;
        public var minimalNameLength:*;
        public var minimalValueLength:*;
        public var errorString:String;
        public var ignoredServers:Array;
        public var fontStyle:CPingServersFontStyle;
        public var threshold:CPingServersThreshold;
        public var shadow:CShadow;
    }
}
