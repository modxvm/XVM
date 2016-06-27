package com.xvm.extraFields
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.types.cfg.*;
    import com.xvm.vo.*;
    import com.xvm.wg.*;
    import flash.text.*;
    import flash.events.*;

    public class ImageExtraField extends ImageWG implements IExtraField
    {
        private var cfg:CExtraField;
        private var isLeftPanel:Boolean;
        private var getColorSchemeName:Function;

        private var _initialized:Boolean = false;

        private var _xValue:Number = 0;
        private var _yValue:Number = 0;
        private var _bindToIconOffset:Number = 0;
        private var _widthValue:Number = NaN;
        private var _heightValue:Number = NaN;
        private var _colorSchemeNameValue:String = null;

        public function ImageExtraField(format:CExtraField, isLeftPanel:Boolean = true, getColorSchemeName:Function = null)
        {
            super();

            mouseEnabled = false;
            mouseChildren = false;

            this.cfg = format.clone();
            this.isLeftPanel = isLeftPanel;
            this.getColorSchemeName = getColorSchemeName;

            var defaultAlign:String = isLeftPanel ? TextFormatAlign.LEFT : TextFormatAlign.RIGHT;
            cfg.align = Macros.FormatStringGlobal(cfg.align, defaultAlign);
            cfg.bindToIcon = Macros.FormatBooleanGlobal(cfg.bindToIcon, false);
        }

        override public function dispose():void
        {
            super.dispose();
            cfg = null;
        }

        override protected function onImgDataCompleteHandler(param1:Event):void
        {
            super.onImgDataCompleteHandler(param1);
            align();
        }

        private function setup(options:IVOMacrosOptions):void
        {
            var value:*;

            value = Macros.FormatNumber(cfg.x, options, 0);
            if (Macros.IsCached(cfg.x, options))
            {
                _xValue = value;
                cfg.x = null;
            }

            value = Macros.FormatNumber(cfg.y, options, 0);
            if (Macros.IsCached(cfg.y, options))
            {
                _yValue = value;
                cfg.y = null;
            }

            value = Macros.FormatNumber(cfg.width, options);
            if (Macros.IsCached(cfg.width, options))
            {
                if (!isNaN(value))
                    _widthValue = value;
                cfg.width = null;
            }

            value = Macros.FormatNumber(cfg.height, options);
            if (Macros.IsCached(cfg.height, options))
            {
                if (!isNaN(value))
                    _heightValue = value;
                cfg.height = null;
            }

            value = Macros.FormatNumber(cfg.alpha, options, 100);
            if (Macros.IsCached(cfg.alpha, options))
            {
                alpha = value / 100.0;
                cfg.alpha = null;
            }

            value = Macros.FormatNumber(cfg.rotation, options, 0);
            if (Macros.IsCached(cfg.rotation, options))
            {
                rotation = value;
                cfg.rotation = null;
            }

            value = Macros.FormatNumber(cfg.scaleX, options, 1);
            if (Macros.IsCached(cfg.scaleX, options))
            {
                scaleX = value;
                cfg.scaleX = null;
            }

            value = Macros.FormatNumber(cfg.scaleY, options, 1);
            if (Macros.IsCached(cfg.scaleY, options))
            {
                scaleY = value;
                cfg.scaleY = null;
            }

            value = Macros.FormatBoolean(cfg.highlight, options, false);
            if (Macros.IsCached(cfg.highlights, options))
            {
                cfg.highlight = value;
            }

            value = Macros.Format(cfg.src, options) || "";
            if (Macros.IsCached(cfg.src, options))
            {
                cfg.src = value;
            }
        }

        public function update(options:IVOMacrosOptions, bindToIconOffset:Number = 0):void
        {
            var needAlign:Boolean = false;

            if (!_initialized)
            {
                _initialized = true;
                setup(options);
                needAlign = true;
            }

            var value:*;

            if (cfg.x != null)
            {
                value = Macros.FormatNumber(cfg.x, options, 0);
                if (_xValue != value)
                {
                    _xValue = value;
                    needAlign = true;
                }
            }
            if (cfg.y != null)
            {
                value = Macros.FormatNumber(cfg.y, options, 0);
                if (_yValue != value)
                {
                    _yValue = value;
                    needAlign = true;
                }
            }
            if (cfg.width != null)
            {
                value = Macros.FormatNumber(cfg.width, options);
                if (isNaN(value) && _widthValue != value)
                {
                    _widthValue = value;
                    needAlign = true;
                }
            }
            if (cfg.height != null)
            {
                value = Macros.FormatNumber(cfg.height, options);
                if (isNaN(value) && _heightValue != value)
                {
                    _heightValue = value;
                    needAlign = true;
                }
            }
            if (cfg.alpha != null)
            {
                value = Macros.FormatNumber(cfg.alpha, options, 100) / 100.0;
                if (alpha != value)
                {
                    alpha = value;
                }
            }
            if (cfg.rotation != null)
            {
                value = Macros.FormatNumber(cfg.rotation, options, 0);
                if (rotation != value)
                {
                    rotation = value;
                }
            }
            if (cfg.scaleX != null)
            {
                value = Macros.FormatNumber(cfg.scaleX, options, 1);
                if (scaleX != value)
                {
                    scaleX = value;
                }
            }
            if (cfg.scaleY != null)
            {
                value = Macros.FormatNumber(cfg.scaleY, options, 1);
                if (scaleY != value)
                {
                    scaleY = value;
                }
            }
            if (cfg.bindToIcon && !isNaN(bindToIconOffset))
            {
                value = isLeftPanel ? (_xValue + bindToIconOffset) : (-_xValue + bindToIconOffset);
                if (x != value)
                {
                    needAlign = true;
                }
            }
            else
            {
                bindToIconOffset = 0;
            }
            _bindToIconOffset = bindToIconOffset;
            if (cfg.src != null)
            {
                if (Macros.IsCached(cfg.src, options))
                {
                    value = cfg.src;
                }
                else
                {
                    value = Macros.Format(cfg.src, options) || "";
                    if (Macros.IsCached(cfg.src, options))
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
                if (cfg.highlight && getColorSchemeName != null)
                {
                    var highlight:Boolean = cfg.highlight is Boolean ? cfg.highlight : XfwUtils.toBool(Macros.Format(cfg.highlight, options), false);
                    value = highlight ? getColorSchemeName(options) : null;
                    if (_colorSchemeNameValue != value)
                    {
                        _colorSchemeNameValue = value;
                        this.transform.colorTransform = App.colorSchemeMgr.getScheme(value).colorTransform;
                    }
                }
            }

            if (needAlign)
            {
                align();
            }
        }

        private function align():void
        {
            x = isLeftPanel ? (_xValue + _bindToIconOffset) : (-_xValue + _bindToIconOffset);
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
