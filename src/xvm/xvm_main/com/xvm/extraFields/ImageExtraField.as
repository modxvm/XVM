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
    import com.xvm.wg.*;
    import flash.text.*;
    import flash.events.*;
    import flash.geom.*;
    import scaleform.gfx.*;

    public class ImageExtraField extends ImageWG implements IExtraField
    {
        private var _cfg:CExtraField;
        private var isLeftPanel:Boolean;
        private var _getColorSchemeName:Function;
        private var _bounds:Rectangle;
        private var _layout:String;

        private var _initialized:Boolean = false;

        private var _xValue:Number = 0;
        private var _yValue:Number = 0;
        private var _bindToIconOffset:Number = 0;
        private var _offsetX:Number = 0;
        private var _offsetY:Number = 0;
        private var _widthValue:Number = NaN;
        private var _heightValue:Number = NaN;
        private var _srcValue:String = null;
        private var _highlightValue:Boolean = false;
        private var _colorSchemeNameValue:String = null;
        private var _keyHolded:Boolean = false;

        public function ImageExtraField(format:CExtraField, isLeftPanel:Boolean = true, getColorSchemeName:Function = null, bounds:Rectangle = null, layout:String = null)
        {
            super();

            mouseEnabled = false;
            mouseChildren = false;

            this._cfg = format.clone();
            this.isLeftPanel = isLeftPanel;
            this._getColorSchemeName = getColorSchemeName;
            this._bounds = bounds;
            this._layout = layout;

            var defaultAlign:String = isLeftPanel ? TextFormatAlign.LEFT : TextFormatAlign.RIGHT;
            _cfg.align = Macros.FormatStringGlobal(_cfg.align, defaultAlign);
            _cfg.bindToIcon = Macros.FormatBooleanGlobal(_cfg.bindToIcon, false);
            if (_cfg.hotKeyCode != null)
            {
                _cfg.visibleOnHotKey = Macros.FormatBooleanGlobal(_cfg.visibleOnHotKey, false);
                _cfg.onHold = Macros.FormatBooleanGlobal(_cfg.onHold, true);
            }

            ExtraFieldsHelper.setupEvents(this);
        }

        override protected function onDispose():void
        {
            super.onDispose();
            Xfw.removeCommandListener(XvmCommands.AS_ON_KEY_EVENT, onKeyEvent);
            _cfg = null;
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
            return _widthValue;
        }

        public function get heightValue():Number
        {
            return _heightValue;
        }

        override protected function onImgDataCompleteHandler(param1:Event):void
        {
            super.onImgDataCompleteHandler(param1);
            align();
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

            value = Macros.Format(_cfg.src, options) || "";
            if (Macros.IsCached(_cfg.src, options))
            {
                _srcValue = value;
                _cfg.src = null;
                if (_srcValue != null && source != _srcValue)
                {
                    //Logger.add("source: " + source + " => " + _srcValue);
                    source = _srcValue;
                }
            }

            value = Macros.FormatBoolean(_cfg.highlight, options, false);
            if (Macros.IsCached(_cfg.highlight, options))
            {
                _highlightValue = value;
                _cfg.highlight = null;
            }
        }

        public function update(options:IVOMacrosOptions, bindToIconOffset:Number = 0, offsetX:Number = 0, offsetY:Number = 0, bounds:Rectangle = null):void
        {
            _bindToIconOffset = bindToIconOffset;
            _offsetX = offsetX;
            _offsetY = offsetY;

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
            if (_cfg.bindToIcon && !isNaN(bindToIconOffset))
            {
                value = isLeftPanel ? (_xValue + bindToIconOffset) : (-_xValue + bindToIconOffset);
                if (x != value)
                {
                    needAlign = true;
                }
            }
            else
            {
                _bindToIconOffset = 0;
            }
            if (_cfg.src)
            {
                value = Macros.Format(_cfg.src, options);
                //value = Utils.fixImgTag(value); // is required?
                if (_srcValue != value)
                {
                    //Logger.add(_srcValue + " => " + value);
                    _srcValue = value;
                    if (_srcValue != null && source != _srcValue)
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

        private function align():void
        {
            if (!isNaN(_widthValue))
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
                x = isLeftPanel ? (_xValue + _bindToIconOffset + _offsetX) : (-_xValue + _bindToIconOffset + _offsetX);
                y = _yValue + _offsetY;
                if (_cfg.align == TextFormatAlign.RIGHT)
                    x -= width;
                else if (_cfg.align == TextFormatAlign.CENTER)
                    x -= width / 2;
            }
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
