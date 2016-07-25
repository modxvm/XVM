/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.extraFields
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.battle.*;
    import com.xvm.battle.events.PlayerStateEvent;
    import com.xvm.types.cfg.*;
    import com.xvm.vo.*;
    import flash.events.*;
    import flash.text.*;
    import flash.geom.*;
    import scaleform.gfx.*;

    public class TextExtraField extends TextField implements IExtraField
    {
        public static const DEFAULT_TEXT_FIELD_WIDTH:Number = 300;
        public static const DEFAULT_TEXT_FIELD_HEIGHT:Number = 25;

        private var _cfg:CExtraField;
        private var _isLeftPanel:Boolean;
        private var _getColorSchemeName:Function;
        private var _bounds:Rectangle;
        private var _layout:String;
        private var _defaultTextFormatConfig:CTextFormat;

        private var _initialized:Boolean = false;

        private var _xValue:Number = 0;
        private var _yValue:Number = 0;
        private var _widthValue:Number = NaN;
        private var _heightValue:Number = NaN;
        private var _textValue:String = null;
        private var _highlightValue:Boolean = false;
        private var _colorSchemeNameValue:String = null;
        private var _keyHolded:Boolean = false;

        public function TextExtraField(format:CExtraField, isLeftPanel:Boolean = true, getColorSchemeName:Function = null, bounds:Rectangle = null, layout:String = null,
            defaultAlign:String = null, defaultTextFormatConfig:CTextFormat = null)
        {
            super();

            this._cfg = format.clone();
            this._isLeftPanel = isLeftPanel;
            this._getColorSchemeName = getColorSchemeName;
            this._bounds = bounds;
            this._layout = layout;
            this._defaultTextFormatConfig = defaultTextFormatConfig;

            mouseEnabled = false;
            selectable = false;
            multiline = true;
            wordWrap = false;
            autoSize = TextFieldAutoSize.NONE;

            width = _bounds == null ? DEFAULT_TEXT_FIELD_WIDTH : _bounds.width;
            height = _bounds == null ? DEFAULT_TEXT_FIELD_HEIGHT : _bounds.height;

            if (defaultAlign == null)
                defaultAlign = isLeftPanel ? TextFormatAlign.LEFT : TextFormatAlign.RIGHT;
            var align:String = _cfg.align != null ? _cfg.align : _cfg.textFormat ? _cfg.textFormat.align : null;
            _cfg.align = Macros.FormatStringGlobal(align, defaultAlign);
            _cfg.bindToIcon = Macros.FormatBooleanGlobal(_cfg.bindToIcon, false);
            if (_cfg.hotKeyCode != null)
            {
                _cfg.visibleOnHotKey = Macros.FormatBooleanGlobal(_cfg.visibleOnHotKey, true);
                _cfg.onHold = Macros.FormatBooleanGlobal(_cfg.onHold, true);
            }
            antiAliasType = Macros.FormatStringGlobal(_cfg.antiAliasType, AntiAliasType.ADVANCED);
            TextFieldEx.setVerticalAlign(this, Macros.FormatStringGlobal(_cfg.valign, TextFieldEx.VALIGN_NONE));
            TextFieldEx.setNoTranslate(this, true);
            defaultTextFormat = Utils.DEFAULT_TEXT_FORMAT;
            if (_cfg.textFormat == null)
                _cfg.textFormat = defaultTextFormatConfig;
            if (_cfg.shadow == null)
                _cfg.shadow = CShadow.GetDefaultConfig();
            ExtraFieldsHelper.setupEvents(this);
        }

        public final function dispose():void
        {
            _cfg = null;
            Xfw.removeCommandListener(XvmCommands.AS_ON_KEY_EVENT, onKeyEvent);
        }

        public function get cfg():CExtraField
        {
            return _cfg;
        }

        public function get xValue():Number
        {
            return _xValue;
        }

        public function get yValue():Number
        {
            return _yValue;
        }

        public function get widthValue():Number
        {
            return (textWidth <= 0) ? _widthValue : textWidth + 4; // 2 * 2-pixel gutter
        }

        public function get heightValue():Number
        {
            return _heightValue;
        }

        private function setup(options:IVOMacrosOptions):void
        {
            var value:*;

            value = Macros.FormatNumber(_cfg.x, options, 0);
            if (Macros.IsCached(_cfg.x, options))
            {
                _xValue = value;
                _cfg.x = null;
            }

            value = Macros.FormatNumber(_cfg.y, options, 0);
            if (Macros.IsCached(_cfg.y, options))
            {
                _yValue = value;
                _cfg.y = null;
            }

            value = Macros.FormatNumber(_cfg.width, options);
            if (Macros.IsCached(_cfg.width, options))
            {
                if (!isNaN(value))
                    _widthValue = value;
                _cfg.width = null;
            }

            value = Macros.FormatNumber(_cfg.height, options);
            if (Macros.IsCached(_cfg.height, options))
            {
                if (!isNaN(value))
                    _heightValue = value;
                _cfg.height = null;
            }

            value = Macros.FormatNumber(_cfg.alpha, options, 100);
            if (Macros.IsCached(_cfg.alpha, options))
            {
                alpha = value / 100.0;
                _cfg.alpha = null;
            }

            value = Macros.FormatNumber(_cfg.rotation, options, 0);
            if (Macros.IsCached(_cfg.rotation, options))
            {
                rotation = value;
                _cfg.rotation = null;
            }

            value = Macros.FormatNumber(_cfg.scaleX, options, 1);
            if (Macros.IsCached(_cfg.scaleX, options))
            {
                scaleX = value;
                _cfg.scaleX = null;
            }

            value = Macros.FormatNumber(_cfg.scaleY, options, 1);
            if (Macros.IsCached(_cfg.scaleY, options))
            {
                scaleY = value;
                _cfg.scaleY = null;
            }

            value = Macros.FormatNumber(_cfg.borderColor, options);
            if (Macros.IsCached(_cfg.borderColor, options))
            {
                if (!isNaN(value))
                {
                    border = true;
                    borderColor = value;
                }
                _cfg.borderColor = null;
            }

            value = Macros.FormatNumber(_cfg.bgColor, options);
            if (Macros.IsCached(_cfg.bgColor, options))
            {
                if (!isNaN(value))
                {
                    background = true;
                    backgroundColor = value;
                }
                _cfg.bgColor = null;
            }

            if (_cfg.textFormat)
            {
                if (!setupTextFormat(_cfg.textFormat, options))
                {
                    _cfg.textFormat = null;
                }
            }

            if (_cfg.shadow)
            {
                if (!setupShadow(_cfg.shadow, options))
                {

                    _cfg.shadow = null;
                }
            }

            value = Macros.Format(_cfg.format, options);
            if (Macros.IsCached(_cfg.format, options))
            {
                _textValue = value;
                _cfg.format = null;
                htmlText = _textValue;
            }

            value = Macros.FormatBoolean(_cfg.highlight, options, false);
            if (Macros.IsCached(_cfg.highlight, options))
            {
                _highlightValue = value;
                _cfg.highlight = null;
            }
        }

        private function setupTextFormat(cfg:CTextFormat, options:IVOMacrosOptions):Boolean
        {
            var value:*;
            var isDynamic:Boolean = false;

            value = Macros.FormatBoolean(cfg.enabled, options, true);
            if (Macros.IsCached(cfg.enabled, options))
            {
                cfg.enabled = value;
                if (!value)
                    return false;
            }

            value = Macros.FormatString(cfg.font, options, Utils.DEFAULT_TEXT_FORMAT.font);
            if (Macros.IsCached(cfg.font, options))
            {
                cfg.font = value;
            }
            else
            {
                isDynamic = true;
            }

            value = Macros.FormatNumber(cfg.size, options, Number(Utils.DEFAULT_TEXT_FORMAT.size));
            if (Macros.IsCached(cfg.size, options))
            {
                cfg.size = value;
            }
            else
            {
                isDynamic = true;
            }

            if (cfg.color == null)
                cfg.color = "{{c:system}}";
            value = Macros.FormatNumber(cfg.color, options, Number(Utils.DEFAULT_TEXT_FORMAT.color));
            if (Macros.IsCached(cfg.color, options))
            {
                cfg.color = value;
            }
            else
            {
                isDynamic = true;
            }

            value = Macros.FormatBoolean(cfg.bold, options, Boolean(Utils.DEFAULT_TEXT_FORMAT.bold));
            if (Macros.IsCached(cfg.bold, options))
            {
                cfg.bold = value;
            }
            else
            {
                isDynamic = true;
            }

            value = Macros.FormatBoolean(cfg.italic, options, Boolean(Utils.DEFAULT_TEXT_FORMAT.italic));
            if (Macros.IsCached(cfg.italic, options))
            {
                cfg.italic = value;
            }
            else
            {
                isDynamic = true;
            }

            value = Macros.FormatBoolean(cfg.underline, options, Boolean(Utils.DEFAULT_TEXT_FORMAT.underline));
            if (Macros.IsCached(cfg.underline, options))
            {
                cfg.underline = value;
            }
            else
            {
                isDynamic = true;
            }

            value = Macros.FormatString(cfg.align, options, Utils.DEFAULT_TEXT_FORMAT.align);
            if (Macros.IsCached(cfg.align, options))
            {
                cfg.align = value;
            }
            else
            {
                isDynamic = true;
            }

            value = Macros.FormatNumber(cfg.leftMargin, options, Number(Utils.DEFAULT_TEXT_FORMAT.leftMargin));
            if (Macros.IsCached(cfg.leftMargin, options))
            {
                cfg.leftMargin = value;
            }
            else
            {
                isDynamic = true;
            }

            value = Macros.FormatNumber(cfg.rightMargin, options, Number(Utils.DEFAULT_TEXT_FORMAT.rightMargin));
            if (Macros.IsCached(cfg.rightMargin, options))
            {
                cfg.rightMargin = value;
            }
            else
            {
                isDynamic = true;
            }

            value = Macros.FormatNumber(cfg.indent, options, Number(Utils.DEFAULT_TEXT_FORMAT.indent));
            if (Macros.IsCached(cfg.indent, options))
            {
                cfg.indent = value;
            }
            else
            {
                isDynamic = true;
            }

            value = Macros.FormatNumber(cfg.leading, options, Number(Utils.DEFAULT_TEXT_FORMAT.leading));
            if (Macros.IsCached(cfg.leading, options))
            {
                cfg.leading = value;
            }
            else
            {
                isDynamic = true;
            }

            defaultTextFormat = Utils.createTextFormatFromConfig(cfg, options);

            return isDynamic;
        }

        private function setupShadow(cfg:CShadow, options:IVOMacrosOptions):Boolean
        {
            var value:*;
            var isDynamic:Boolean = false;

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
                isDynamic = true;
            }

            value = Macros.FormatNumber(cfg.angle, options, 0);
            if (Macros.IsCached(cfg.angle, options))
            {
                cfg.angle = value;
            }
            else
            {
                isDynamic = true;
            }

            value = Macros.FormatNumber(cfg.color, options, 0);
            if (Macros.IsCached(cfg.color, options))
            {
                cfg.color = value;
            }
            else
            {
                isDynamic = true;
            }

            value = Macros.FormatNumber(cfg.alpha, options, 70);
            if (Macros.IsCached(cfg.alpha, options))
            {
                cfg.alpha = value;
            }
            else
            {
                isDynamic = true;
            }

            value = Macros.FormatNumber(cfg.blur, options, 4);
            if (Macros.IsCached(cfg.blur, options))
            {
                cfg.blur = value;
            }
            else
            {
                isDynamic = true;
            }

            value = Macros.FormatNumber(cfg.strength, options, 2);
            if (Macros.IsCached(cfg.strength, options))
            {
                cfg.strength = value;
            }
            else
            {
                isDynamic = true;
            }

            value = Macros.FormatNumber(cfg.quality, options, 3);
            if (Macros.IsCached(cfg.quality, options))
            {
                cfg.quality = value;
            }
            else
            {
                isDynamic = true;
            }

            value = Macros.FormatBoolean(cfg.inner, options, false);
            if (Macros.IsCached(cfg.inner, options))
            {
                cfg.inner = value;
            }
            else
            {
                isDynamic = true;
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

            return isDynamic;
        }

        public function update(options:IVOMacrosOptions, bindToIconOffset:Number = 0, offsetX:Number = 0, offsetY:Number = 0, bounds:Rectangle = null):void
        {
            try
            {
                var needAlign:Boolean = false;

                if (!_initialized)
                {
                    _initialized = true;
                    setup(options);
                    needAlign = true;
                }

                if (bounds && _bounds != bounds)
                {
                    _bounds = bounds;
                    needAlign = true;
                }

                var value:*;

                if (_cfg.x != null)
                {
                    value = Macros.FormatNumber(_cfg.x, options, 0);
                    if (_xValue != value)
                    {
                        _xValue = value;
                        needAlign = true;
                    }
                }
                if (_cfg.y != null)
                {
                    value = Macros.FormatNumber(_cfg.y, options, 0);
                    if (_yValue != value)
                    {
                        _yValue = value;
                        needAlign = true;
                    }
                }
                if (_cfg.width != null)
                {
                    value = Macros.FormatNumber(_cfg.width, options);
                    if (!isNaN(value) && _widthValue != value)
                    {
                        _widthValue = value;
                        needAlign = true;
                    }
                }
                if (_cfg.height != null)
                {
                    value = Macros.FormatNumber(_cfg.height, options);
                    if (!isNaN(value) && _heightValue != value)
                    {
                        _heightValue = value;
                        needAlign = true;
                    }
                }
                if (_cfg.alpha != null)
                {
                    value = Macros.FormatNumber(_cfg.alpha, options, 100) / 100.0;
                    if (alpha != value)
                    {
                        alpha = value;
                    }
                }
                if (_cfg.rotation != null)
                {
                    value = Macros.FormatNumber(_cfg.rotation, options, 0);
                    if (rotation != value)
                    {
                        rotation = value;
                    }
                }
                if (_cfg.scaleX != null)
                {
                    value = Macros.FormatNumber(_cfg.scaleX, options, 1);
                    if (scaleX != value)
                    {
                        scaleX = value;
                    }
                }
                if (_cfg.scaleY != null)
                {
                    value = Macros.FormatNumber(_cfg.scaleY, options, 1);
                    if (scaleY != value)
                    {
                        scaleY = value;
                    }
                }
                if (_cfg.borderColor != null)
                {
                    value = Macros.FormatNumber(_cfg.borderColor, options);
                    border = !isNaN(value);
                    if (border)
                    {
                        borderColor = value;
                    }
                }
                if (_cfg.bgColor != null)
                {
                    value = Macros.FormatNumber(_cfg.bgColor, options);
                    background = !isNaN(value);
                    if (background)
                    {
                        backgroundColor = value;
                    }
                }
                if (_cfg.bindToIcon && !isNaN(bindToIconOffset))
                {
                    value = _isLeftPanel ? (_xValue + bindToIconOffset) : (-_xValue + bindToIconOffset);
                    if (x != value)
                    {
                        needAlign = true;
                    }
                }
                else
                {
                    bindToIconOffset = 0;
                }
                if (_cfg.textFormat)
                {
                    defaultTextFormat = Utils.createTextFormatFromConfig(_cfg.textFormat, options);
                    htmlText = _textValue;
                }
                if (_cfg.shadow)
                {
                    filters = Utils.createShadowFiltersFromConfig(_cfg.shadow, options);
                }
                if (_cfg.format)
                {
                    value = Macros.Format(_cfg.format, options);

                    //value = Utils.fixImgTag(value); // is required?
                    if (_textValue != value)
                    {
                        //Logger.add(_textValue + " => " + value);
                        _textValue = value;
                        htmlText = _textValue;
                        needAlign = true;
                    }
                }
                if (_getColorSchemeName != null)
                {
                    if (_cfg.highlight)
                    {
                        _highlightValue = _cfg.highlight is Boolean ? _cfg.highlight : Macros.FormatBoolean(_cfg.highlight, options, false);
                    }
                    value = _highlightValue ? _getColorSchemeName(options) : null;
                    if (_colorSchemeNameValue != value)
                    {
                        _colorSchemeNameValue = value;
                        textColor = App.colorSchemeMgr.getScheme(value).rgb;
                    }
                }

                if (needAlign)
                {
                    align(bindToIconOffset, offsetX, offsetY);
                }

                //if (Config.IS_DEVELOPMENT) { border = true; borderColor = 0xff0000; }
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        private function align(bindToIconOffset:Number, offsetX:Number, offsetY:Number):void
        {
            if (textWidth > 0)
                width = textWidth + 4; // 2 * 2-pixel gutter
            else if (!isNaN(_widthValue))
                width = _widthValue;
            if (!isNaN(_heightValue))
                height = _heightValue;
            if (_bounds && _layout == ExtraFields.LAYOUT_ROOT)
            {
                var align:String = Macros.FormatStringGlobal(_cfg.screenHAlign, TextFormatAlign.LEFT);
                x = xValue + Utils.HAlign(align, widthValue, _bounds.width);
                var valign:String = Macros.FormatStringGlobal(_cfg.screenVAlign, TextFieldEx.VALIGN_TOP);
                y = yValue + Utils.VAlign(valign, heightValue, _bounds.height);
            }
            else
            {
                x = _isLeftPanel ? (_xValue + bindToIconOffset + offsetX) : (-_xValue + bindToIconOffset + offsetX);
                y = _yValue + offsetY;
                if (_cfg.align == TextFormatAlign.RIGHT)
                    x -= width;
                else if (_cfg.align == TextFormatAlign.CENTER)
                    x -= width / 2;
            }

            //if (Config.IS_DEVELOPMENT) { border = true; borderColor = 0xff0000; }
        }

        public function updateOnEvent(e:PlayerStateEvent):void
        {
            update(BattleState.get(e.vehicleID));
        }

        public function onKeyEvent(key:Number, isDown:Boolean):void
        {
            if (key == _cfg.hotKeyCode)
            {
                if (_cfg.onHold)
                    _keyHolded = isDown;
                else if (isDown)
                    _keyHolded = !_keyHolded;
                else
                    return;
                if (_cfg.visibleOnHotKey)
                {
                    visible = _keyHolded;
                }
                else
                {
                    visible = !_keyHolded;
                }
            }
        }
    }
}
