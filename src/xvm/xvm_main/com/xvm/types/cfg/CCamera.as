/**
 * XVM Config
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.types.cfg
{
    public dynamic class CCamera extends Object
    {
        public var enabled:*;
        public var arcade:CCameraArcade;
        public var postmortem:CCameraArcade;
        public var strategic:CCameraStrategic;
        public var sniper:CCameraSniper;
    }
}
