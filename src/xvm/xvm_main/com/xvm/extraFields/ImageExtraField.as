package com.xvm.extraFields
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.types.cfg.*;
    import com.xvm.vo.*;
    import com.xvm.wg.*;
    import flash.text.*;

    public class ImageExtraField extends ImageWG implements IExtraField
    {
        private var cfg:CExtraField;
        private var isLeftPanel:Boolean;
        private var getColorSchemeName:Function;

        private var _initialized:Boolean = false;

        private var _xValue:Number = 0;
        private var _yValue:Number = 0;
        private var _widthValue:Number = NaN;
        private var _heightValue:Number = NaN;
        private var _colorSchemeNameValue:String = null;

        public function ImageExtraField(format:CExtraField, isLeftPanel:Boolean, getColorSchemeName:Function)
        {
            super();

            this.cfg = format.clone();
            this.isLeftPanel = isLeftPanel;
            this.getColorSchemeName = getColorSchemeName;

            var defaultAlign:String = isLeftPanel ? TextFormatAlign.LEFT : TextFormatAlign.RIGHT;
            cfg.align = Macros.GlobalString(cfg.align, defaultAlign);
            cfg.bindToIcon = Macros.GlobalBoolean(cfg.bindToIcon, false);
        }

        private function setup(options:IVOMacrosOptions):void
        {
            var value:*;

            value = Macros.FormatNumber(options.playerName, cfg.x, options, 0, 0);
            if (Macros.IsCached(options.playerName, cfg.x))
            {
                _xValue = value;
                cfg.x = null;
            }

            value = Macros.FormatNumber(options.playerName, cfg.y, options, 0, 0);
            if (Macros.IsCached(options.playerName, cfg.y))
            {
                _yValue = value;
                cfg.y = null;
            }

            value = Macros.FormatNumber(options.playerName, cfg.width, options);
            if (Macros.IsCached(options.playerName, cfg.width))
            {
                if (!isNaN(value))
                    _widthValue = value;
                cfg.width = null;
            }

            value = Macros.FormatNumber(options.playerName, cfg.height, options);
            if (Macros.IsCached(options.playerName, cfg.height))
            {
                if (!isNaN(value))
                    _heightValue = value;
                cfg.height = null;
            }

            value = Macros.FormatNumber(options.playerName, cfg.alpha, options, 100, 100);
            if (Macros.IsCached(options.playerName, cfg.alpha))
            {
                alpha = value / 100.0;
                cfg.alpha = null;
            }

            value = Macros.FormatNumber(options.playerName, cfg.rotation, options, 0, 0);
            if (Macros.IsCached(options.playerName, cfg.rotation))
            {
                rotation = value;
                cfg.rotation = null;
            }

            value = Macros.FormatNumber(options.playerName, cfg.scaleX, options, 1, 1);
            if (Macros.IsCached(options.playerName, cfg.scaleX))
            {
                scaleX = value;
                cfg.scaleX = null;
            }

            value = Macros.FormatNumber(options.playerName, cfg.scaleY, options, 1, 1);
            if (Macros.IsCached(options.playerName, cfg.scaleY))
            {
                scaleY = value;
                cfg.scaleY = null;
            }

            value = XfwUtils.toBool(Macros.Format(options.playerName, cfg.highlight, options), false);
            if (Macros.IsCached(options.playerName, cfg.highlights))
            {
                cfg.highlight = value;
            }

            value = Macros.Format(options.playerName, cfg.src, options) || "";
            if (Macros.IsCached(options.playerName, cfg.src))
            {
                cfg.src = value;
            }
        }

        public function update(options:IVOMacrosOptions, bindToIconOffset:Number = NaN):void
        {
            if (!_initialized)
            {
                _initialized = true;
                setup(options);
            }

            var value:*;
            var needAlign:Boolean = false;

            if (cfg.x != null)
            {
                value = Macros.FormatNumber(options.playerName, cfg.x, options, 0, 0);
                if (_xValue != value)
                {
                    _xValue = value;
                    needAlign = true;
                }
            }
            if (cfg.y != null)
            {
                value = Macros.FormatNumber(options.playerName, cfg.y, options, 0, 0);
                if (_yValue != value)
                {
                    _yValue = value;
                    needAlign = true;
                }
            }
            if (cfg.width != null)
            {
                value = Macros.FormatNumber(options.playerName, cfg.width, options);
                if (isNaN(value) && _widthValue != value)
                {
                    _widthValue = value;
                    needAlign = true;
                }
            }
            if (cfg.height != null)
            {
                value = Macros.FormatNumber(options.playerName, cfg.height, options);
                if (isNaN(value) && _heightValue != value)
                {
                    _heightValue = value;
                    needAlign = true;
                }
            }
            if (cfg.alpha != null)
            {
                value = Macros.FormatNumber(options.playerName, cfg.alpha, options, 100, 100) / 100.0;
                if (alpha != value)
                {
                    alpha = value;
                }
            }
            if (cfg.rotation != null)
            {
                value = Macros.FormatNumber(options.playerName, cfg.rotation, options, 0, 0);
                if (rotation != value)
                {
                    rotation = value;
                }
            }
            if (cfg.scaleX != null)
            {
                value = Macros.FormatNumber(options.playerName, cfg.scaleX, options, 1, 1);
                if (scaleX != value)
                {
                    scaleX = value;
                }
            }
            if (cfg.scaleY != null)
            {
                value = Macros.FormatNumber(options.playerName, cfg.scaleY, options, 1, 1);
                if (scaleY != value)
                {
                    scaleY = value;
                }
            }
            if (cfg.src != null)
            {
                if (Macros.IsCached(options.playerName, cfg.src))
                {
                    value = cfg.src;
                }
                else
                {
                    value = Macros.Format(options.playerName, cfg.src, options) || "";
                    if (Macros.IsCached(options.playerName, cfg.src))
                    {
                        cfg.src = value;
                    }
                }
                value = Utils.fixImgTagSrc(value);
                if (source != value)
                {
                    //Logger.add(source + " => " + value);
                    source = value;
                }

                if (cfg.highlight)
                {
                    var highlight:Boolean = cfg.highlight is Boolean ? cfg.highlight : XfwUtils.toBool(Macros.Format(options.playerName, cfg.highlight, options), false);
                    value = highlight ? getColorSchemeName(options) : null;
                    if (_colorSchemeNameValue != value)
                    {
                        _colorSchemeNameValue = value;
                        this.transform.colorTransform = App.colorSchemeMgr.getScheme(value).colorTransform;
                    }
                }
            }
            if (cfg.bindToIcon && !isNaN(bindToIconOffset))
            {
                value = isLeftPanel ? (_xValue + bindToIconOffset) : (_xValue + bindToIconOffset);
                if (x != value)
                {
                    needAlign = true;
                }
                else
                {
                    bindToIconOffset = 0;
                }
            }
            else
            {
                bindToIconOffset = 0;
            }

            if (needAlign)
            {
                x = isLeftPanel ? (_xValue + bindToIconOffset) : (-_xValue + bindToIconOffset);
                y = _yValue;
                if (!isNaN(_widthValue))
                    width = _widthValue;
                if (!isNaN(_heightValue))
                    height = _heightValue;
                if (cfg.align == TextFormatAlign.RIGHT)
                    x -= width;
                else if (cfg.align == TextFormatAlign.CENTER)
                    x -= width / 2;
            }
        }
    }
}
