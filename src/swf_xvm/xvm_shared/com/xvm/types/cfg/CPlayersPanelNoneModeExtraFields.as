/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CPlayersPanelNoneModeExtraFields implements ICloneable
    {
        public var leftPanel:CPlayersPanelNoneModeExtraField;
        public var rightPanel:CPlayersPanelNoneModeExtraField;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }
    }
}
