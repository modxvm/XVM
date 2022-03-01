/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.extraFields
{
    import com.greensock.TimelineLite;
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.battle.BattleState;
    import com.xvm.battle.events.PlayerStateEvent;
    import com.xvm.extraFields.IExtraField;
    import com.xvm.types.cfg.CExtraField;
    import com.xvm.types.cfg.CShadow;
    import com.xvm.types.cfg.CTextFormat;
    import com.xvm.vo.IVOMacrosOptions;
    import flash.display.Sprite;
    import flash.geom.Rectangle;
    import flash.text.AntiAliasType;
    import flash.text.TextField;
    import flash.text.TextFieldAutoSize;
    import flash.text.TextFormatAlign;
    import scaleform.gfx.TextFieldEx;

    public class TextExtraField extends Sprite implements IExtraField
    {
        public static const DEFAULT_TEXT_FIELD_WIDTH:Number = 300;
        public static const DEFAULT_TEXT_FIELD_HEIGHT:Number = 25;

        private var _textField:TextField;
        private var _cfg:CExtraField;
        private var _isLeftPanel:Boolean;
        private var _getColorSchemeName:Function;
        private var _bounds:Rectangle;
        private var _layout:String;
        private var _defaultTextFormatConfig:CTextFormat;
        private var _lastOptions:IVOMacrosOptions = null;

        private var _initialized:Boolean = false;
        private var _disposed:Boolean = false;


        private var _xValue:Number = 0;
        private var _yValue:Number = 0;
        private var _bindToIconOffset:int = 0;
        private var _offsetX:int = 0;
        private var _offsetY:int = 0;
        private var _widthValue:Number = NaN;
        private var _heightValue:Number = NaN;
        private var _textValue:String = null;
        private var _highlightValue:Boolean = false;
        private var _colorSchemeNameValue:String = null;
        private var _keyHolded:Boolean = false;
        private var _visibleOnHotKeyEnabled:Boolean = true;
        private var _visibilityFlag:Boolean = true;
        private var _tweens:TimelineLite = null;
        private var _tweensIn:TimelineLite = null;
        private var _tweensOut:TimelineLite = null;

        public function TextExtraField(format:CExtraField, isLeftPanel:Boolean = true, getColorSchemeName:Function = null, bounds:Rectangle = null,
            layout:String = null, defaultAlign:String = null, defaultTextFormatConfig:CTextFormat = null)
        {
            super();
            // https://ci.modxvm.com/sonarqube/coding_rules?open=flex%3AS1447&rule_key=flex%3AS1447
            _init(format, isLeftPanel, getColorSchemeName, bounds, layout, defaultAlign, defaultTextFormatConfig);
        }

        private function _init(format:CExtraField, isLeftPanel:Boolean, getColorSchemeName:Function, bounds:Rectangle,
            layout:String, defaultAlign:String, defaultTextFormatConfig:CTextFormat):void
        {
            mouseEnabled = false;
            mouseChildren = false;
            buttonMode = false;
            visible = false;

            this._cfg = format.clone();
            this._isLeftPanel = isLeftPanel;
            this._getColorSchemeName = getColorSchemeName;
            this._bounds = bounds;
            this._layout = layout;
            this._defaultTextFormatConfig = defaultTextFormatConfig || CTextFormat.GetDefaultConfigForBattle();

            _textField = new TextField();
            _textField.mouseEnabled = false;
            _textField.selectable = false;
            _textField.multiline = true;
            _textField.wordWrap = false;
            _textField.autoSize = TextFieldAutoSize.NONE;
            addChild(_textField);

            _textField.width = _bounds == null ? DEFAULT_TEXT_FIELD_WIDTH : _bounds.width;
            _textField.height = _bounds == null ? DEFAULT_TEXT_FIELD_HEIGHT : _bounds.height;

            if (defaultAlign == null)
                defaultAlign = isLeftPanel ? TextFormatAlign.LEFT : TextFormatAlign.RIGHT;
            _cfg.align = Macros.FormatStringGlobal(_cfg.align, defaultAlign);
            _cfg.valign = Macros.FormatStringGlobal(_cfg.valign, TextFieldEx.VALIGN_NONE);
            _cfg.bindToIcon = Macros.FormatBooleanGlobal(_cfg.bindToIcon, false);
            if (_cfg.hotKeyCode != null)
            {
                _cfg.visibleOnHotKey = Macros.FormatBooleanGlobal(_cfg.visibleOnHotKey, true);
                _visibleOnHotKeyEnabled = !_cfg.visibleOnHotKey;
                _cfg.onHold = Macros.FormatBooleanGlobal(_cfg.onHold, true);
            }
            _textField.antiAliasType = Macros.FormatStringGlobal(_cfg.antiAliasType, AntiAliasType.ADVANCED);
            TextFieldEx.setVerticalAlign(_textField, TextFieldEx.VALIGN_NONE);
            TextFieldEx.setNoTranslate(_textField, true);
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
            _disposed = true;
        }

        public final function isDisposed () : Boolean
        {
            return _disposed;	
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
            return isNaN(_widthValue) ? ((_textField.textWidth > 0) ? _textField.textWidth + 4 : NaN) : _widthValue; // 2 * 2-pixel gutter
        }

        public function get heightValue():Number
        {
            return _heightValue;
        }

        public function get tweens():TimelineLite
        {
            return _tweens;
        }

        public function set tweens(value:TimelineLite):void
        {
            _tweens = value;
        }

        public function get tweensIn():TimelineLite
        {
            return _tweensIn;
        }

        public function set tweensIn(value:TimelineLite):void
        {
            _tweensIn = value;
        }

        public function get tweensOut():TimelineLite
        {
            return _tweensOut;
        }

        public function set tweensOut(value:TimelineLite):void
        {
            _tweensOut = value;
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
                _textField.alpha = value / 100.0;
                _cfg.alpha = null;
            }

            value = Macros.FormatNumber(_cfg.rotation, options, 0);
            if (Macros.IsCached(_cfg.rotation, options))
            {
                _textField.rotation = value;
                _cfg.rotation = null;
            }

            value = Macros.FormatNumber(_cfg.scaleX, options, 1);
            if (Macros.IsCached(_cfg.scaleX, options))
            {
                _textField.scaleX = value;
                _cfg.scaleX = null;
            }

            value = Macros.FormatNumber(_cfg.scaleY, options, 1);
            if (Macros.IsCached(_cfg.scaleY, options))
            {
                _textField.scaleY = value;
                _cfg.scaleY = null;
            }

            value = Macros.FormatNumber(_cfg.borderColor, options);
            if (Macros.IsCached(_cfg.borderColor, options))
            {
                if (!isNaN(value))
                {
                    _textField.border = true;
                    _textField.borderColor = value;
                }
                _cfg.borderColor = null;
            }

            value = Macros.FormatNumber(_cfg.bgColor, options);
            if (Macros.IsCached(_cfg.bgColor, options))
            {
                if (!isNaN(value))
                {
                    _textField.background = true;
                    _textField.backgroundColor = value;
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
                _textField.htmlText = _textValue;
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

            if (cfg.font == null)
                cfg.font = _defaultTextFormatConfig.font;
            value = Macros.FormatString(cfg.font, options, _defaultTextFormatConfig.font);
            if (Macros.IsCached(cfg.font, options))
            {
                cfg.font = value;
            }
            else
            {
                isDynamic = true;
            }

            if (cfg.size == null)
                cfg.size = _defaultTextFormatConfig.size;
            value = Macros.FormatNumber(cfg.size, options, Number(_defaultTextFormatConfig.size));
            if (Macros.IsCached(cfg.size, options))
            {
                cfg.size = value;
            }
            else
            {
                isDynamic = true;
            }

            if (cfg.color == null)
                cfg.color = _defaultTextFormatConfig.color;
            value = Macros.FormatNumber(cfg.color, options, Number(_defaultTextFormatConfig.color));
            if (Macros.IsCached(cfg.color, options))
            {
                cfg.color = value;
            }
            else
            {
                isDynamic = true;
            }

            if (cfg.bold == null)
                cfg.bold = _defaultTextFormatConfig.bold;
            value = Macros.FormatBoolean(cfg.bold, options, Boolean(_defaultTextFormatConfig.bold));
            if (Macros.IsCached(cfg.bold, options))
            {
                cfg.bold = value;
            }
            else
            {
                isDynamic = true;
            }

            if (cfg.italic == null)
                cfg.italic = _defaultTextFormatConfig.italic;
            value = Macros.FormatBoolean(cfg.italic, options, Boolean(_defaultTextFormatConfig.italic));
            if (Macros.IsCached(cfg.italic, options))
            {
                cfg.italic = value;
            }
            else
            {
                isDynamic = true;
            }

            if (cfg.underline == null)
                cfg.underline = _defaultTextFormatConfig.underline;
            value = Macros.FormatBoolean(cfg.underline, options, Boolean(_defaultTextFormatConfig.underline));
            if (Macros.IsCached(cfg.underline, options))
            {
                cfg.underline = value;
            }
            else
            {
                isDynamic = true;
            }

            if (cfg.align == null)
                cfg.align = _defaultTextFormatConfig.align;
            value = Macros.FormatString(cfg.align, options, _defaultTextFormatConfig.align);
            if (Macros.IsCached(cfg.align, options))
            {
                cfg.align = value;
            }
            else
            {
                isDynamic = true;
            }

            if (cfg.valign == null)
                cfg.valign = _defaultTextFormatConfig.valign;
            value = Macros.FormatString(cfg.valign, options, _defaultTextFormatConfig.valign);
            if (Macros.IsCached(cfg.valign, options))
            {
                cfg.valign = value;
            }
            else
            {
                isDynamic = true;
            }

            if (cfg.leftMargin == null)
                cfg.leftMargin = _defaultTextFormatConfig.leftMargin;
            value = Macros.FormatNumber(cfg.leftMargin, options, Number(_defaultTextFormatConfig.leftMargin));
            if (Macros.IsCached(cfg.leftMargin, options))
            {
                cfg.leftMargin = value;
            }
            else
            {
                isDynamic = true;
            }

            if (cfg.rightMargin == null)
                cfg.rightMargin = _defaultTextFormatConfig.rightMargin;
            value = Macros.FormatNumber(cfg.rightMargin, options, Number(_defaultTextFormatConfig.rightMargin));
            if (Macros.IsCached(cfg.rightMargin, options))
            {
                cfg.rightMargin = value;
            }
            else
            {
                isDynamic = true;
            }

            if (cfg.indent == null)
                cfg.indent = _defaultTextFormatConfig.indent;
            value = Macros.FormatNumber(cfg.indent, options, Number(_defaultTextFormatConfig.indent));
            if (Macros.IsCached(cfg.indent, options))
            {
                cfg.indent = value;
            }
            else
            {
                isDynamic = true;
            }

            if (cfg.leading == null)
                cfg.leading = _defaultTextFormatConfig.leading;
            value = Macros.FormatNumber(cfg.leading, options, Number(_defaultTextFormatConfig.leading));
            if (Macros.IsCached(cfg.leading, options))
            {
                cfg.leading = value;
            }
            else
            {
                isDynamic = true;
            }

            _textField.defaultTextFormat = Utils.createTextFormatFromConfig(cfg, options);
            TextFieldEx.setVerticalAlign(_textField, Macros.FormatStringGlobal(cfg.valign, TextFieldEx.VALIGN_NONE));

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

            var defaultConfig:CShadow = CShadow.GetDefaultConfig();

            if (cfg.distance == null)
                cfg.distance = defaultConfig.distance;
            value = Macros.FormatNumber(cfg.distance, options, defaultConfig.distance);
            if (Macros.IsCached(cfg.distance, options))
            {
                cfg.distance = value;
            }
            else
            {
                isDynamic = true;
            }

            if (cfg.angle == null)
                cfg.angle = defaultConfig.angle;
            value = Macros.FormatNumber(cfg.angle, options, defaultConfig.angle);
            if (Macros.IsCached(cfg.angle, options))
            {
                cfg.angle = value;
            }
            else
            {
                isDynamic = true;
            }

            if (cfg.color == null)
                cfg.color = defaultConfig.color;
            value = Macros.FormatNumber(cfg.color, options, defaultConfig.color);
            if (Macros.IsCached(cfg.color, options))
            {
                cfg.color = value;
            }
            else
            {
                isDynamic = true;
            }

            if (cfg.alpha == null)
                cfg.alpha = defaultConfig.alpha;
            value = Macros.FormatNumber(cfg.alpha, options, defaultConfig.alpha);
            if (Macros.IsCached(cfg.alpha, options))
            {
                cfg.alpha = value;
            }
            else
            {
                isDynamic = true;
            }

            if (cfg.blur == null)
                cfg.blur = defaultConfig.blur;
            value = Macros.FormatNumber(cfg.blur, options, defaultConfig.blur);
            if (Macros.IsCached(cfg.blur, options))
            {
                cfg.blur = value;
            }
            else
            {
                isDynamic = true;
            }

            if (cfg.strength == null)
                cfg.strength = defaultConfig.strength;
            value = Macros.FormatNumber(cfg.strength, options, defaultConfig.strength);
            if (Macros.IsCached(cfg.strength, options))
            {
                cfg.strength = value;
            }
            else
            {
                isDynamic = true;
            }

            if (cfg.quality == null)
                cfg.quality = defaultConfig.quality;
            value = Macros.FormatNumber(cfg.quality, options, defaultConfig.quality);
            if (Macros.IsCached(cfg.quality, options))
            {
                cfg.quality = value;
            }
            else
            {
                isDynamic = true;
            }

            if (cfg.inner == null)
                cfg.inner = defaultConfig.inner;
            value = Macros.FormatBoolean(cfg.inner, options, defaultConfig.inner);
            if (Macros.IsCached(cfg.inner, options))
            {
                cfg.inner = value;
            }
            else
            {
                isDynamic = true;
            }

            if (cfg.knockout == null)
                cfg.knockout = defaultConfig.knockout;
            value = Macros.FormatBoolean(cfg.knockout, options, defaultConfig.knockout);
            if (Macros.IsCached(cfg.knockout, options))
            {
                cfg.knockout = value;
            }

            if (cfg.hideObject == null)
                cfg.hideObject = defaultConfig.hideObject;
            value = Macros.FormatBoolean(cfg.hideObject, options, defaultConfig.hideObject);
            if (Macros.IsCached(cfg.hideObject, options))
            {
                cfg.hideObject = value;
            }

            _textField.filters = Utils.createShadowFiltersFromConfig(cfg, options);

            return isDynamic;
        }

        public function update(options:IVOMacrosOptions, bindToIconOffset:int = 0, offsetX:int = 0, offsetY:int = 0, bounds:Rectangle = null):void
        {
            try
            {
                _lastOptions = options;

                _visibilityFlag = ExtraFieldsHelper.checkVisibilityFlags(cfg.flags, options);
                if (!_visibilityFlag)
                {
                    ExtraFieldsHelper.changeVisible(this, false);
                    return;
                }

                ExtraFieldsHelper.changeVisible(this, _visibleOnHotKeyEnabled && _visibilityFlag);

                var needAlign:Boolean = false;

                if (!_initialized)
                {
                    _initialized = true;
                    setup(options);
                    needAlign = true;
                }

                if (bounds)
                {
                    if (_bounds != bounds)
                    {
                        _bounds = bounds;
                        needAlign = true;
                    }
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
                if (_offsetX != offsetX)
                {
                    _offsetX = offsetX;
                    needAlign = true;
                }
                if (_offsetY != offsetY)
                {
                    _offsetY = offsetY;
                    needAlign = true;
                }
                if (_cfg.width != null)
                {
                    value = Macros.FormatNumber(_cfg.width, options);
                    if (!isNaN(value))
                    {
                        if (_widthValue != value)
                        {
                            _widthValue = value;
                            needAlign = true;
                        }
                    }
                }
                if (_cfg.height != null)
                {
                    value = Macros.FormatNumber(_cfg.height, options);
                    if (!isNaN(value))
                    {
                        if (_heightValue != value)
                        {
                            _heightValue = value;
                            needAlign = true;
                        }
                    }
                }
                if (_cfg.alpha != null)
                {
                    value = Macros.FormatNumber(_cfg.alpha, options, 100) / 100.0;
                    if (_textField.alpha != value)
                    {
                        _textField.alpha = value;
                    }
                }
                if (_cfg.rotation != null)
                {
                    value = Macros.FormatNumber(_cfg.rotation, options, 0);
                    if (_textField.rotation != value)
                    {
                        _textField.rotation = value;
                    }
                }
                if (_cfg.scaleX != null)
                {
                    value = Macros.FormatNumber(_cfg.scaleX, options, 1);
                    if (_textField.scaleX != value)
                    {
                        _textField.scaleX = value;
                    }
                }
                if (_cfg.scaleY != null)
                {
                    value = Macros.FormatNumber(_cfg.scaleY, options, 1);
                    if (_textField.scaleY != value)
                    {
                        _textField.scaleY = value;
                    }
                }
                if (_cfg.borderColor != null)
                {
                    value = Macros.FormatNumber(_cfg.borderColor, options);
                    _textField.border = !isNaN(value);
                    if (_textField.border)
                    {
                        _textField.borderColor = value;
                    }
                }
                if (_cfg.bgColor != null)
                {
                    value = Macros.FormatNumber(_cfg.bgColor, options);
                    _textField.background = !isNaN(value);
                    if (_textField.background)
                    {
                        _textField.backgroundColor = value;
                    }
                }
                if (_cfg.bindToIcon)
                {
                    if (_bindToIconOffset != bindToIconOffset)
                    {
                        _bindToIconOffset = bindToIconOffset;
                        needAlign = true;
                    }
                }
                if (_cfg.textFormat)
                {
                    _textField.defaultTextFormat = Utils.createTextFormatFromConfig(_cfg.textFormat, options);
                    TextFieldEx.setVerticalAlign(_textField, Macros.FormatStringGlobal(_cfg.textFormat.valign, TextFieldEx.VALIGN_NONE));
                    _textField.htmlText = _textValue;
                }
                if (_cfg.shadow)
                {
                    _textField.filters = Utils.createShadowFiltersFromConfig(_cfg.shadow, options);
                }
                if (_cfg.format)
                {
                    value = Macros.FormatString(_cfg.format, options);
                    if (_textValue != value)
                    {
                        //Logger.add(_textValue + " => " + value);
                        _textValue = value;
                        _textField.htmlText = _textValue;
                        needAlign = true;
                    }
                }
                if (_getColorSchemeName != null)
                {
                    if (_cfg.highlight)
                    {
                        _highlightValue = Macros.FormatBoolean(_cfg.highlight, options, false);
                    }
                    value = _highlightValue ? _getColorSchemeName(options) : null;
                    if (_colorSchemeNameValue != value)
                    {
                        _colorSchemeNameValue = value;
                        _textField.textColor = App.colorSchemeMgr.getScheme(value).rgb;
                    }
                }

                if (needAlign)
                {
                    align();
                }
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        // PRIVATE

        private function align():void
        {
            if (!isNaN(widthValue))
                _textField.width = widthValue;
            if (!isNaN(heightValue))
                _textField.height = heightValue;
            if (_bounds && _layout == ExtraFields.LAYOUT_ROOT)
            {
                var align:String = Macros.FormatStringGlobal(_cfg.screenHAlign, TextFormatAlign.LEFT);
                x = xValue + Utils.HAlign(align, widthValue, _bounds.width);
                var valign:String = Macros.FormatStringGlobal(_cfg.screenVAlign, TextFieldEx.VALIGN_TOP);
                y = yValue + Utils.VAlign(valign, heightValue, _bounds.height);
            }
            else
            {
                x = _isLeftPanel ? (_xValue + _bindToIconOffset + _offsetX) : (-_xValue + _bindToIconOffset + _offsetX);
                y = _yValue + _offsetY;
                if (_cfg.align == TextFormatAlign.RIGHT)
                    x -= _textField.width;
                else if (_cfg.align == TextFormatAlign.CENTER)
                    x -= _textField.width / 2;
                if (_cfg.valign == TextFieldEx.VALIGN_BOTTOM)
                    y -= _textField.height;
                else if (_cfg.valign == TextFieldEx.VALIGN_CENTER)
                    y -= _textField.height / 2;
            }

            //if (Config.IS_DEVELOPMENT) { border = true; borderColor = 0xff0000; }
        }

        public function updateOnEvent(e:PlayerStateEvent):void
        {
            //Logger.addObject(e);
            update(isNaN(e.vehicleID) ? _lastOptions : BattleState.get(e.vehicleID));
            if (tweens != null)
            {
                tweens.restart();
            }
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
                    _visibleOnHotKeyEnabled = _keyHolded;
                }
                else
                {
                    _visibleOnHotKeyEnabled = !_keyHolded;
                }
                ExtraFieldsHelper.changeVisible(this, _visibleOnHotKeyEnabled && _visibilityFlag);
                //updateOnEvent(new PlayerStateEvent(PlayerStateEvent.ON_HOTKEY_PRESSED)); // need current vehicle id for players panel
            }
        }
    }
}
