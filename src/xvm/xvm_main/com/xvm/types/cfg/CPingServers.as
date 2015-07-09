/**
 * XVM Config
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.types.cfg
{
    // Show ping to the servers
    public dynamic class CPingServers extends Object
    {
        public var enabled:Boolean;
        public var updateInterval:Number; // msec
        public var x:Number;
        public var y:Number;
        public var hAlign:String;
        public var vAlign:String;
        public var alpha:Number;
        public var delimiter:String;
        public var maxRows:Number;
        public var columnGap:Number;
        public var leading:Number;
        public var topmost:Boolean;
        public var fontStyle:Object;
        //{
            //name: "$FieldFont",
            //size: 12,
            //bold: false,
            //italic: false,
            //color: {
                //great: "0xFFCC66",
                //good: "0xE5E4E1",
                //poor: "0x96948F",
                //bad: "0xD64D4D"
            //}
        //},
            public var threshold:Object;
        //    {
            //great: 35,
            //good: 60,
            //poor: 100
        //},
        public var shadow:CShadow;
    }
}
