/**
 * XVM Config
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CMarkersHealthBar extends Object implements ICloneable
    {
        public var enabled:*;
        public var x:*;
        public var y:*;
        public var alpha:*;
        public var color:*;
        public var lcolor:*;
        public var width:*;
        public var height:*;
        public var border:CMarkersHealthBarBorder;
        public var fill:CMarkersHealthBarFill;
        public var damage:CMarkersHealthBarDamage;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }
    }
}
