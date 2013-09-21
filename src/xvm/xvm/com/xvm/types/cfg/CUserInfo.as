/**
 * XVM Config - "userInfo" section
 * @author Maxim Schedriviy <m.schedriviy@gmail.com>
 */
package com.xvm.types.cfg
{
    public dynamic class CUserInfo extends Object
    {
        public var startPage:Number;                // Initial page
        public var showFilters:Boolean;             // Show tank filters
        public var filterFocused:Boolean;           // Set the default focus to the filter text input
        public var inHangarFilterEnabled:Boolean;   // Enable In hangar radio button by default
        public var showEColumn:Boolean;             // Show column for per-vehicle efficiency
        public var sortColumn:Number;               // Number of column for sorting
    }
}
