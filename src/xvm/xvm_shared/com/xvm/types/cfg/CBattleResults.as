/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * http://www.modxvm.com/
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CBattleResults implements ICloneable
    {
        public var startPage:*;
        public var showTotalExperience:*;
        public var showCrewExperience:*;
        public var showNetIncome:*;
        public var showExtendedInfo:*;
        public var showTotals:*;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }
    }
}
