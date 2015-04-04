/**
 * XVM Config - "minimap" section
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.types.cfg
{
    public dynamic class CMinimapCircles extends Object
    {
        public var enabled:Boolean;
        public var view:Array;
        public var artillery:CMinimapCirclesRange;
        public var shell:CMinimapCirclesRange;
        public var special:Array;
        public var _internal:CMinimapCirclesInternal;
    }
}
