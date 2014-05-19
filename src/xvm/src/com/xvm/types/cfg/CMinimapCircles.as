/**
 * XVM Config - "minimap" section
 * @author Maxim Schedriviy "m.schedriviy(at)gmail.com"
 */
package com.xvm.types.cfg
{
    public dynamic class CMinimapCircles extends Object
    {
        public var enabled:Boolean;
        public var major:Array;
        public var artillery:CMinimapCirclesRange;
        public var view:CMinimapCirclesView;
        public var shell:CMinimapCirclesRange;
        public var special:Array;
        public var _internal:CMinimapCirclesInternal;
    }
}
