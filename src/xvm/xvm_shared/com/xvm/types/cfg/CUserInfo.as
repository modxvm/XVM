/**
 * XVM Config
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CUserInfo extends Object implements ICloneable
    {
        public var startPage:*;
        public var showXTEColumn:*;
        public var showExtraDataInProfile:*;
        public var inHangarFilterEnabled:*;
        public var showFilters:*;
        public var filterFocused:*;
        public var defaultFilterValue:String;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }
    }
}
