/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CBattleResults implements ICloneable
    {
        public var showCrewExperience:*;
        public var showExtendedInfo:*;
        public var showNetIncome:*;
        public var showTotalExperience:*;
        public var showTotals:*;
        public var startPage:*;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }
    }
}
