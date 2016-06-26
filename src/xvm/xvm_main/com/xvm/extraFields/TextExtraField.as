package com.xvm.extraFields
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.types.cfg.*;
    import com.xvm.vo.*;
    import flash.text.*;
    import scaleform.gfx.*;

    public class TextExtraField extends TextField implements IExtraField
    {
        public static const DEFAULT_TEXT_FIELD_WIDTH:Number = 300;
        public static const DEFAULT_TEXT_FIELD_HEIGHT:Number = 25;

        private var cfg:CExtraField;
        private var isLeftPanel:Boolean;
        private var getColorSchemeName:Function;

        private var _initialized:Boolean = false;

        private var _xValue:Number = 0;
        private var _yValue:Number = 0;
        private var _widthValue:Number = NaN;
        private var _heightValue:Number = NaN;
        private var _textValue:String = null;
        private var _colorSchemeNameValue:String = null;

        public function TextExtraField(format:CExtraField, isLeftPanel:Boolean = true, getColorSchemeName:Function = null)
        {
            super();

            this.cfg = format.clone();
            this.isLeftPanel = isLeftPanel;
            this.getColorSchemeName = getColorSchemeName;

            selectable = false;
            multiline = true;
            wordWrap = false;
            autoSize = TextFieldAutoSize.NONE;

            width = DEFAULT_TEXT_FIELD_WIDTH;
            height = DEFAULT_TEXT_FIELD_HEIGHT;

            var defaultAlign:String = isLeftPanel ? TextFormatAlign.LEFT : TextFormatAlign.RIGHT;
            cfg.align = Macros.FormatStringGlobal(cfg.align, defaultAlign);
            cfg.bindToIcon = Macros.FormatBooleanGlobal(cfg.bindToIcon, false);
            antiAliasType = Macros.FormatStringGlobal(cfg.antiAliasType, AntiAliasType.ADVANCED);
            TextFieldEx.setVerticalAlign(this, Macros.FormatStringGlobal(cfg.valign, TextFieldEx.VALIGN_NONE));
            TextFieldEx.setNoTranslate(this, true);
            defaultTextFormat = new TextFormat("$UniversCondC", 14, 0xFFFFFF, null, null, null, null, null, "center");
        }

        public final function dispose():void
        {
            cfg = null;
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

            value = Macros.FormatNumber(cfg.borderColor, options, NaN, true);
            if (Macros.IsCached(cfg.borderColor, options))
            {
                if (!isNaN(value))
                {
                    border = true;
                    borderColor = value;
                }
                cfg.borderColor = null;
            }

            value = Macros.FormatNumber(cfg.bgColor, options, NaN, true);
            if (Macros.IsCached(cfg.bgColor, options))
            {
                if (!isNaN(value))
                {
                    background = true;
                    backgroundColor = value;
                }
                cfg.bgColor = null;
            }

            value = Macros.Format(cfg.format, options) || "";
            if (Macros.IsCached(cfg.format, options))
            {
                cfg.format = value;
            }

            if (cfg.shadow != null)
            {
                if (!setupShadow(cfg.shadow, options))
                {

                    cfg.shadow = null;
                }
            }
        }

        private function setupShadow(cfg:CShadow, options:IVOMacrosOptions):Boolean
        {
            var value:*;
            var isDynamicShadow:Boolean = false;

            value = Macros.FormatBoolean(cfg.enabled, options, true);
            if (Macros.IsCached(cfg.enabled, options))
            {
                cfg.enabled = value;
                if (!value)
                    return false;
            }

            value = Macros.FormatNumber(cfg.distance, options, 0);
            if (Macros.IsCached(cfg.distance, options))
            {
                cfg.distance = value;
            }
            else
            {
                isDynamicShadow = true;
            }

            value = Macros.FormatNumber(cfg.angle, options, 0);
            if (Macros.IsCached(cfg.angle, options))
            {
                cfg.angle = value;
            }
            else
            {
                isDynamicShadow = true;
            }

            value = Macros.FormatNumber(cfg.color, options, 0);
            if (Macros.IsCached(cfg.color, options))
            {
                cfg.color = value;
            }
            else
            {
                isDynamicShadow = true;
            }

            value = Macros.FormatNumber(cfg.alpha, options, 70);
            if (Macros.IsCached(cfg.alpha, options))
            {
                cfg.alpha = value;
            }
            else
            {
                isDynamicShadow = true;
            }

            value = Macros.FormatNumber(cfg.blur, options, 4);
            if (Macros.IsCached(cfg.blur, options))
            {
                cfg.blur = value;
            }
            else
            {
                isDynamicShadow = true;
            }

            value = Macros.FormatNumber(cfg.strength, options, 2);
            if (Macros.IsCached(cfg.strength, options))
            {
                cfg.strength = value;
            }
            else
            {
                isDynamicShadow = true;
            }

            value = Macros.FormatNumber(cfg.quality, options, 3);
            if (Macros.IsCached(cfg.quality, options))
            {
                cfg.quality = value;
            }
            else
            {
                isDynamicShadow = true;
            }

            value = Macros.FormatBoolean(cfg.inner, options, false);
            if (Macros.IsCached(cfg.inner, options))
            {
                cfg.inner = value;
            }
            else
            {
                isDynamicShadow = true;
            }

            value = Macros.FormatBoolean(cfg.knockout, options, false);
            if (Macros.IsCached(cfg.knockout, options))
            {
                cfg.knockout = value;
            }

            value = Macros.FormatBoolean(cfg.hideObject, options, false);
            if (Macros.IsCached(cfg.hideObject, options))
            {
                cfg.hideObject = value;
            }

            filters = Utils.createShadowFiltersFromConfig(cfg, options);

            return isDynamicShadow;
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
                if (!isNaN(value) && _widthValue != value)
                {
                    _widthValue = value;
                    needAlign = true;
                }
            }
            if (cfg.height != null)
            {
                value = Macros.FormatNumber(cfg.height, options);
                if (!isNaN(value) && _heightValue != value)
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
            if (cfg.borderColor != null)
            {
                value = Macros.FormatNumber(cfg.borderColor, options, NaN, true);
                border = !isNaN(value);
                if (border)
                {
                    borderColor = value;
                }
            }
            if (cfg.bgColor != null)
            {
                value = Macros.FormatNumber(cfg.bgColor, options, NaN, true);
                background = !isNaN(value);
                if (background)
                {
                    backgroundColor = value;
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
            if (cfg.format != null)
            {
                if (Macros.IsCached(cfg.format, options))
                {
                    value = cfg.format;
                }
                else
                {
                    value = Macros.Format(cfg.format, options) || "";
                    if (Macros.IsCached(cfg.format, options))
                    {
                        cfg.format = value;
                    }
                }
                value = Utils.fixImgTag(value);
                if (_textValue != value)
                {
                    //Logger.add(_textValue + " => " + value);
                    _textValue = value;
                    htmlText = _textValue;
                    needAlign = true;
                }
                if (cfg.highlight)
                {
                    var highlight:Boolean = cfg.highlight is Boolean ? cfg.highlight : XfwUtils.toBool(Macros.Format(cfg.highlight, options), false);
                    value = highlight ? getColorSchemeName(options) : null;
                    if (_colorSchemeNameValue != value)
                    {
                        _colorSchemeNameValue = value;
                        textColor = App.colorSchemeMgr.getScheme(value).rgb;
                    }
                }
            }
            if (cfg.shadow != null)
            {
                filters = Utils.createShadowFiltersFromConfig(cfg.shadow, options);
            }

            if (needAlign)
            {
                x = isLeftPanel ? (_xValue + bindToIconOffset) : (-_xValue + bindToIconOffset);
                y = _yValue;
                if (!isNaN(_widthValue))
                    width = _widthValue;
                if (!isNaN(_heightValue))
                    height = _heightValue;
                if (textWidth > 0)
                    width = textWidth + 4; // 2 * 2-pixel gutter
                if (cfg.align == TextFormatAlign.RIGHT)
                    x -= width;
                else if (cfg.align == TextFormatAlign.CENTER)
                    x -= width / 2;
            }

            //if (Config.IS_DEVELOPMENT) { border = true; borderColor = 0xff0000; }
        }
    }
}
