/**
 * XVM Config
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CCameraZoomIndicator extends Object implements ICloneable
    {
        public var enabled:*;
        public var x:*;
        public var y:*;
        public var width:*;
        public var height:*;
        public var alpha:*;
        public var align:String;
        public var valign:String;
        public var bgColor:*;
        public var borderColor:*;
        public var format:String;
        public var shadow:CShadow;

        public function clone():*
        {
            var cloned:CCameraZoomIndicator = new CCameraZoomIndicator();
            cloned.enabled = enabled;
            cloned.x = x;
            cloned.y = y;
            cloned.width = width;
            cloned.height = height;
            cloned.alpha = alpha;
            cloned.align = align;
            cloned.valign = valign;
            cloned.bgColor = bgColor;
            cloned.borderColor = borderColor;
            cloned.format = format;
            cloned.shadow = shadow ? shadow.clone() : null;
            return cloned;
        }
    }
}
