/**
 * XVM Config - "hangar"/"carousel" section
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.types.cfg
{
    public dynamic class CCarousel extends Object
    {
        public var enabled:Boolean;
        public var zoom:Number;
        public var rows:Number;
        public var padding:Object;
        public var alwaysShowFilters:Boolean;
        public var hideBuyTank:Boolean;
        public var hideBuySlot:Boolean;
        public var filters:Object;
        public var fields:Object;
        public var extraFields:Array;
        public var nations_order:Array;
        public var types_order:Array;
        public var sorting_criteria:Array;
    }
}
