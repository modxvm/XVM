/**
 * XVM Config - "userInfo" section
 * @author Maxim Schedriviy <m.schedriviy@gmail.com>
 */
package com.xvm.types.cfg
{
    public dynamic class CUserInfo extends Object
    {
        public var startPage:Number;                // Initial page
        public var sortColumn:Number;               // Number of column for sorting
        public var showExtraDataInProfile:Boolean;
        public var inHangarFilterEnabled:Boolean;   // Enable In hangar check box by default
        public var showFilters:Boolean;             // Show tank filters
        public var filterFocused:Boolean;           // Set the default focus to the filter text input
        public var defaultFilterValue:String;       // Default filter value
    }
}
