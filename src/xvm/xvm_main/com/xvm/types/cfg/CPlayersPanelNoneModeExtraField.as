/**
 * XVM Config
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CPlayersPanelNoneModeExtraField extends Object implements ICloneable
    {
        public var x:*;
        public var y:*;
        public var width:*;
        public var height:*;
        public var formats:Array;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }
    }
}
