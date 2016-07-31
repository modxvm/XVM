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

        private static var _defaultConfig:CShadow = null;
        public static function GetDefaultConfig():CShadow
        {
            if (_defaultConfig == null)
            {
                _defaultConfig = new CShadow();
                _defaultConfig.enabled = true;
                _defaultConfig.distance = 0;
                _defaultConfig.angle = 0;
                _defaultConfig.color = 0x000000;
                _defaultConfig.alpha = 70;
                _defaultConfig.blur = 4;
                _defaultConfig.strength = 2;
                _defaultConfig.quality = 3;
                _defaultConfig.inner = false;
                _defaultConfig.knockout = false;
                _defaultConfig.hideObject = false;
            }
            return _defaultConfig;
        }
    }
}
