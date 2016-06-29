/**
 * XVM Config
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CCamera extends Object implements ICloneable
    {
        public var enabled:*;
        public var arcade:CCameraArcade;
        public var postmortem:CCameraArcade;
        public var strategic:CCameraStrategic;
        public var sniper:CCameraSniper;

        public function clone():*
        {
            throw new Error("clone() method is not implemented");
        }
    }
}
