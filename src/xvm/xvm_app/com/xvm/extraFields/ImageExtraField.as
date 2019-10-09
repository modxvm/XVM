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
    import com.xvm.vo.IVOMacrosOptions;
    import com.xvm.wg.ImageXVM;
    import flash.geom.Rectangle;
    import flash.text.TextFormatAlign;
    import scaleform.gfx.TextFieldEx;

    public class ImageExtraField extends ImageXVM implements IExtraField
    {
        private var _cfg:CExtraField;
        private var isLeftPanel:Boolean;
        private var _getColorSchemeName:Function;
        private var _bounds:Rectangle;
        private var _layout:String;
        private var _lastOptions:IVOMacrosOptions = null;

        private var _initialized:Boolean = false;

        private var _xValue:Number = 0;
        private var _yValue:Number = 0;
        private var _bindToIconOffset:Number = 0;
        private var _offsetX:int = 0;
        private var _offsetY:int = 0;
        private var _widthValue:Number = NaN;
        private var _heightValue:Number = NaN;
        private var _srcValue:String = null;
        private var _scaleXValue:Number = NaN;
        private var _scaleYValue:Number = NaN;
        private var _highlightValue:Boolean = false;
        private var _colorSchemeNameValue:String = null;
        private var _keyHolded:Boolean = false;
        private var _visibleOnHotKeyEnabled:Boolean = true;
        private var _visibilityFlag:Boolean = true;
        private var _tweens:TimelineLite = null;
        private var _tweensIn:TimelineLite = null;
        private var _tweensOut:TimelineLite = null;

        public function ImageExtraField(format:CExtraField, isLeftPanel:Boolean = true, getColorSchemeName:Function = null,
            bounds:Rectangle = null, layout:String = null)
        {
            super();
            // https://ci.modxvm.com/sonarqube/coding_rules?open=flex%3AS1447&rule_key=flex%3AS1447
            _init(format, isLeftPanel, getColorSchemeName, bounds, layout);
        }

        private function _init(format:CExtraField, isLeftPanel:Boolean, getColorSchemeName:Function, bounds:Rectangle, layout:String):void
        {
            mouseEnabled = false;
            mouseChildren = false;
            buttonMode = false;
            visible = false;

            this._cfg = format.clone();
            this.isLeftPanel = isLeftPanel;
            this._getColorSchemeName = getColorSchemeName;
            this._bounds = bounds;
            this._layout = layout;

            var defaultAlign:String = isLeftPanel ? TextFormatAlign.LEFT : TextFormatAlign.RIGHT;
            _cfg.align = Macros.FormatStringGlobal(_cfg.align, defaultAlign);
            _cfg.valign = Macros.FormatStringGlobal(_cfg.valign, TextFieldEx.VALIGN_NONE);
            _cfg.bindToIcon = Macros.FormatBooleanGlobal(_cfg.bindToIcon, false);
            if (_cfg.hotKeyCode != null)
            {
                _cfg.visibleOnHotKey = Macros.FormatBooleanGlobal(_cfg.visibleOnHotKey, true);
                _visibleOnHotKeyEnabled = !_cfg.visibleOnHotKey;
                _cfg.onHold = Macros.FormatBooleanGlobal(_cfg.onHold, true);
            }

            ExtraFieldsHelper.setupEvents(this);
        }

        override protected function onDispose():void
        {
            super.dispose();
            Xfw.removeCommandListener(XvmCommands.AS_ON_KEY_EVENT, onKeyEvent);
            _cfg = null;
        }

        override protected function imageDataReady():void
        {
            super.imageDataReady();
            align();
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
            return isNaN(_widthValue) ? _bitmap.width : _widthValue;
        }

        public function get heightValue():Number
        {
            return isNaN(_heightValue) ? _bitmap.height : _heightValue;
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
                alpha = value / 100.0;
                _cfg.alpha = null;
            }

            value = Macros.FormatNumber(_cfg.rotation, options, 0);
            if (Macros.IsCached(_cfg.rotation, options))
            {
                rotation = value;
                _cfg.rotation = null;
            }

            _scaleXValue = Macros.FormatNumber(_cfg.scaleX, options, 1);
            if (Macros.IsCached(_cfg.scaleX, options))
            {
                _cfg.scaleX = null;
            }

            _scaleYValue = Macros.FormatNumber(_cfg.scaleY, options, 1);
            if (Macros.IsCached(_cfg.scaleY, options))
            {
                _cfg.scaleY = null;
            }

            value = Macros.Format(_cfg.src, options) || "";
            if (Macros.IsCached(_cfg.src, options))
            {
                _srcValue = value;
                _cfg.src = null;
                if (_srcValue != null)
                {
                    if (source != _srcValue)
                    {
                        //Logger.add("source: " + source + " => " + _srcValue);
                        source = _srcValue;
                    }
                }
            }

            value = Macros.FormatBoolean(_cfg.highlight, options, false);
            if (Macros.IsCached(_cfg.highlight, options))
            {
                _highlightValue = value;
                _cfg.highlight = null;
            }
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
                    _scaleXValue = Macros.FormatNumber(_cfg.scaleX, options, 1);
                }
                if (_bitmap.scaleX != _scaleXValue)
                {
                    needAlign = true;
                }
                if (_cfg.scaleY != null)
                {
                    _scaleYValue = Macros.FormatNumber(_cfg.scaleY, options, 1);
                }
                if (_bitmap.scaleY != _scaleXValue)
                {
                    needAlign = true;
                }
                if (_cfg.bindToIcon)
                {
                    if (_bindToIconOffset != bindToIconOffset)
                    {
                        _bindToIconOffset = bindToIconOffset;
                        needAlign = true;
                    }
                }
                if (_cfg.src)
                {
                    value = Macros.Format(_cfg.src, options);
                    //value = Utils.fixImgTag(value); // is required?
                    if (_srcValue != value)
                    {
                        //Logger.add(_srcValue + " => " + value);
                        _srcValue = value;
                        if (source != _srcValue)
                        {
                            //Logger.add("source: " + source + " => " + _srcValue);
                            source = _srcValue;
                        }
                        //needAlign = true; // is required?
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
                        this.transform.colorTransform = App.colorSchemeMgr.getScheme(value).colorTransform;
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

        private function align():void
        {
            if (_bitmap.scaleX != _scaleXValue)
            {
                _bitmap.scaleX = _scaleXValue;
            }
            if (_bitmap.scaleY != _scaleYValue)
            {
                _bitmap.scaleY = _scaleYValue;
            }
            if (!isNaN(_widthValue))
                width = _widthValue;
            if (!isNaN(_heightValue))
                height = _heightValue;
            var x:Number;
            var y:Number;
            if (_bounds && _layout == ExtraFields.LAYOUT_ROOT)
            {
                var align:String = Macros.FormatStringGlobal(_cfg.screenHAlign, TextFormatAlign.LEFT);
                x = xValue + Utils.HAlign(align, widthValue, _bounds.width);
                var valign:String = Macros.FormatStringGlobal(_cfg.screenVAlign, TextFieldEx.VALIGN_TOP);
                y = yValue + Utils.VAlign(valign, heightValue, _bounds.height);
            }
            else
            {
                x = isLeftPanel ? (_xValue + _bindToIconOffset + _offsetX) : (-_xValue + _bindToIconOffset + _offsetX);
                y = _yValue + _offsetY;
                if (_cfg.align == TextFormatAlign.RIGHT)
                    x -= width;
                else if (_cfg.align == TextFormatAlign.CENTER)
                    x -= width / 2;
                if (_cfg.valign == TextFieldEx.VALIGN_BOTTOM)
                    y -= height;
                else if (_cfg.valign == TextFieldEx.VALIGN_CENTER)
                    y -= height / 2;
            }
            if (_scaleXValue < 0)
            {
                x += widthValue;
            }
            if (_scaleYValue < 0)
            {
                y += heightValue;
            }
            if (this.x != x)
            {
                this.x = x;
            }
            if (this.y != y)
            {
                this.y = y;
            }
        }

        public function updateOnEvent(e:PlayerStateEvent):void
        {
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
