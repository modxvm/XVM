/**
 * XVM Config
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CPlayersPanelNoneMode extends Object implements ICloneable
    {
        public var enabled:*;
        public var layout:String;
        public var extraFields:CPlayersPanelNoneModeExtraFields;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }
    }
}
