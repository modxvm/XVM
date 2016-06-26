/**
 * XVM Config
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CPlayersPanelNoneModeExtraFields extends Object implements ICloneable
    {
        public var leftPanel:CPlayersPanelNoneModeExtraField;
        public var rightPanel:CPlayersPanelNoneModeExtraField;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }
    }
}
