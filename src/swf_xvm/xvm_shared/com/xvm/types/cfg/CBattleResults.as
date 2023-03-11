/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.types.cfg
{
    import com.xfw.*;
    import com.xvm.*;

    public dynamic class CBattleResults implements ICloneable
    {
        public var showCrewExperience:*;
        public var showExtendedInfo:*;
        public var showNetIncome:*;
        public var showTotalExperience:*;
        public var startPage:*;
        public var bonusState:CBattleResultsBonusState;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }

        internal function applyGlobalMacros():void
        {
            if (bonusState)
            {
                bonusState.applyGlobalMacros();
            }
        }
    }
}
