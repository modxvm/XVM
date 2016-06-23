/**
 * XVM Config
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CExtraField implements ICloneable
    {
        public var enabled:*
        public var x:*;
        public var y:*;
        public var w:*;
        public var h:*;
        public var alpha:*;
        public var rotation:*;
        public var scaleX:*;
        public var scaleY:*;
        public var align:String;
        public var valign:String;
        public var borderColor:String;
        public var bgColor:String;
        public var antiAliasType:String;
        public var bindToIcon:*;
        public var src:String;
        public var format:String;
        public var shadow:CShadow;
        public var highlight:*;

        public function clone():*
        {
            var cloned:CExtraField = new CExtraField();
            cloned.enabled = enabled;
            cloned.x = x;
            cloned.y = y;
            cloned.w = w;
            cloned.h = h;
            cloned.alpha = alpha;
            cloned.rotation = rotation;
            cloned.scaleX = scaleX;
            cloned.scaleY = scaleY;
            cloned.align = align;
            cloned.valign = valign;
            cloned.borderColor = borderColor;
            cloned.bgColor = bgColor;
            cloned.antiAliasType = antiAliasType;
            cloned.bindToIcon = bindToIcon;
            cloned.src = src;
            cloned.format = format;
            cloned.shadow = shadow ? shadow.clone() : null;
            cloned.highlight = highlight;
            return cloned;
        }
    }
}
