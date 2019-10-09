/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.types.cfg
{
    import com.xfw.*;
    import com.xvm.*;

    public dynamic class CBattleResultsBonusState implements ICloneable
    {
        public var enabled:*;
        public var offsetX:*;
        public var offsetY:*;
        public var backgroundAlpha:*;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }

        internal function applyGlobalMacros():void
        {
            enabled = Macros.FormatBooleanGlobal(Config.config.battleResults.bonusState.enabled, true);
            offsetX = Macros.FormatNumberGlobal(Config.config.battleResults.bonusState.offsetX, 25);
            offsetY = Macros.FormatNumberGlobal(Config.config.battleResults.bonusState.offsetY, 60);
            backgroundAlpha = Macros.FormatNumberGlobal(Config.config.battleResults.bonusState.backgroundAlpha, 70) / 100.0;
        }
    }
}
