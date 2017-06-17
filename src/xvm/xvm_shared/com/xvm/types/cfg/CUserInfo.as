/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * http://www.modxvm.com/
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CUserInfo implements ICloneable
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
