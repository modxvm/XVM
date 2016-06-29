/**
 * XVM Config
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CShadow extends Object implements ICloneable
    {
        public var enabled:*;
        public var distance:*;
        public var angle:*;
        public var color:*;
        public var alpha:*;
        public var blur:*;
        public var strength:*;
        public var quality:*;
        public var inner:*;
        public var knockout:*;
        public var hideObject:*;

        public function clone():*
        {
            var cloned:CShadow = new CShadow();
            cloned.enabled = enabled;
            cloned.distance = distance;
            cloned.angle = angle;
            cloned.color = color;
            cloned.alpha = alpha;
            cloned.blur = blur;
            cloned.strength = strength;
            cloned.quality = quality;
            cloned.inner = inner;
            cloned.knockout = knockout;
            cloned.hideObject = hideObject;
            return cloned;
        }
    }
}
