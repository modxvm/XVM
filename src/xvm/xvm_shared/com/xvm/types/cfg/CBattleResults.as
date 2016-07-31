/**
 * XVM Config
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CBattleResults extends Object implements ICloneable
    {
        public var startPage:*;
        public var showTotalExperience:*;
        public var showCrewExperience:*;
        public var showNetIncome:*;
        public var showExtendedInfo:*;
        public var showTotals:*;
        public var showBattleTier:*;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }
    }
}
