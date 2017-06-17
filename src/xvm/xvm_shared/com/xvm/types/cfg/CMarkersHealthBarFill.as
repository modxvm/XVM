/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * http://www.modxvm.com/
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CMarkersHealthBarFill implements ICloneable
    {
        public var alpha:*;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }

        internal function applyGlobalBattleMacros():void
        {
            // do not apply Macros.FormatNumberGlobal(), because Macros.FormatNumber() used:
            // alpha
        }
    }
}
