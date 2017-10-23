/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CUserInfo implements ICloneable
    {
        public var profileStartPage:String;
        public var contactsStartPage:String;
        public var showXTEColumn:*;
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
