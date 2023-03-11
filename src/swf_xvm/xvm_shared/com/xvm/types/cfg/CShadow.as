/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.types.cfg
{
    import com.xfw.*;

    public dynamic class CShadow implements ICloneable
    {
        public var alpha:*;
        public var angle:*;
        public var blur:*;
        public var color:*;
        public var distance:*;
        public var enabled:*;
        public var hideObject:*;
        public var inner:*;
        public var knockout:*;
        public var quality:*;
        public var strength:*;

        public function clone():*
        {
            var cloned:CShadow = new CShadow();
            cloned.alpha = alpha;
            cloned.angle = angle;
            cloned.blur = blur;
            cloned.color = color;
            cloned.distance = distance;
            cloned.enabled = enabled;
            cloned.hideObject = hideObject;
            cloned.inner = inner;
            cloned.knockout = knockout;
            cloned.quality = quality;
            cloned.strength = strength;
            return cloned;
        }

        private static var _defaultConfig:CShadow = null;
        public static function GetDefaultConfig():CShadow
        {
            if (_defaultConfig == null)
            {
                _defaultConfig = new CShadow();
                _defaultConfig.alpha = 70;
                _defaultConfig.angle = 0;
                _defaultConfig.blur = 4;
                _defaultConfig.color = 0x000000;
                _defaultConfig.distance = 0;
                _defaultConfig.enabled = true;
                _defaultConfig.hideObject = false;
                _defaultConfig.inner = false;
                _defaultConfig.knockout = false;
                _defaultConfig.quality = 3;
                _defaultConfig.strength = 2;
            }
            return _defaultConfig;
        }
    }
}
