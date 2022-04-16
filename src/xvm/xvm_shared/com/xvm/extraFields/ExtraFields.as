/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.extraFields
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.types.cfg.*;
    import com.xvm.vo.*;
    import flash.geom.*;
    import flash.utils.*;
    import scaleform.clik.core.*;

    public class ExtraFields extends UIComponent
    {
        public static const LAYOUT_HORIZONTAL:String = "horizontal";
        public static const LAYOUT_VERTICAL:String = "vertical";
        public static const LAYOUT_HORIZONTAL_FIXED:String = "horizontal_fixed";
        public static const LAYOUT_VERTICAL_FIXED:String = "vertical_fixed";
        public static const LAYOUT_ROOT:String = "root";

        private var _bounds:Rectangle;
        private var _layout:String;
        private var _isFixedLayout:Boolean;
        private var _isLeftPanel:Boolean;

        public function ExtraFields(formats:Array, isLeftPanel:Boolean = true, getSchemeNameForText:Function = null, getSchemeNameForImage:Function = null,
            bounds:Rectangle = null, layout:String = null, defaultAlign:String = null, defaultTextFormatConfig:CTextFormat = null):void
        {
            // https://ci.modxvm.com/sonarqube/coding_rules?open=flex%3AS1447&rule_key=flex%3AS1447
            _init(formats, isLeftPanel, getSchemeNameForText, getSchemeNameForImage, bounds, layout, defaultAlign, defaultTextFormatConfig);
        }

        private function _init(formats:Array, isLeftPanel:Boolean, getSchemeNameForText:Function, getSchemeNameForImage:Function,
            bounds:Rectangle, layout:String, defaultAlign:String, defaultTextFormatConfig:CTextFormat):void
        {
            mouseEnabled = false;
            mouseChildren = false;
            
            _bounds = bounds;
            if (layout == LAYOUT_HORIZONTAL_FIXED)
            {
                _layout = LAYOUT_HORIZONTAL;
                _isFixedLayout = true;
            }
            else if (layout == LAYOUT_VERTICAL_FIXED)
            {
                _layout = LAYOUT_VERTICAL;
                _isFixedLayout = true;
            }
            else
            {
                _layout = layout;
                _isFixedLayout = false;
            }
            _isLeftPanel = isLeftPanel;

            var len:int = formats.length;
            for (var i:int = 0; i < len; ++i)
            {
                var format:* = formats[i];
                if (!format)
                    continue;

                if (format is String)
                {
                    format = { format: format };
                    formats[i] = format;
                }

                if (getQualifiedClassName(format) != "com.xvm.types.cfg::CExtraField")
                {
                    if (getQualifiedClassName(format) != "Object")
                    {
                        Logger.add("WARNING: extra field format is not Object class");
                        continue;
                    }
                    var isEmpty:Boolean = true;
                    for (var _tmp:String in format)
                    {
                        isEmpty = false;
                        break;
                    }
                    if (isEmpty)
                        continue;
                    format = ObjectConverter.convertData(format, CExtraField);
                }

                if (Macros.FormatBooleanGlobal(format.enabled, true))
                {
                    if (format.src != null)
                    {
                        // TODO: make ImageExtraField shared
                        var cls:Class;
                        try
                        {
                            cls = getDefinitionByName("com.xvm.extraFields::ImageExtraField") as Class;
                        }
                        catch (ex:Error)
                        {
                            if (!(ex is ReferenceError))
                            {
                                Logger.err(ex);
                            }
                            cls = null;
                        }
                        if (cls != null)
                        {
                            addChild(new cls(format, isLeftPanel, getSchemeNameForImage, _bounds, layout));
                        }
                        else
                        {
                            // Class ImageExtraField is not available in the markers
                            format.format = "<img src=\"" + format.src + "\"" +
                                (format.width != null  ? " width='" + format.width + "'" : "") +
                                (format.height != null  ? " height='" + format.height + "'" : "") +
                                ">";
                            format.width = null;
                            format.height = null;
                            format.src = null;
                        }
                    }
                    if (format.src == null)
                    {
                        addChild(new TextExtraField(format, isLeftPanel, getSchemeNameForText, _bounds, layout, defaultAlign, defaultTextFormatConfig));
                    }
                }
            }
        }

        override protected function configUI():void
        {
            super.configUI();
        }

        public function update(options:IVOMacrosOptions, bindToIconOffset:Number = 0, offsetX:Number = 0, offsetY:Number = 0):void
        {
            var len:int = this.numChildren;
            for (var i:int = 0; i < len; ++i)
            {
                var child:IExtraField = this.getChildAt(i) as IExtraField;
                if (child)
                {
                    child.update(options, bindToIconOffset, offsetX, offsetY, _bounds);
                    if (_bounds)
                    {
                        if (_layout && options != null)
                        {
                            var position:Number = _isFixedLayout ? options.position : (options.index + 1);
                            switch (_layout)
                            {
                                case LAYOUT_HORIZONTAL:
                                    var vx:Number = _bounds.x + (position - 1) * _bounds.width;
                                    x = _isLeftPanel ? vx : App.appWidth - vx;
                                    y = _bounds.y;
                                    break;
                                case LAYOUT_VERTICAL:
                                    x = _isLeftPanel ? _bounds.x : App.appWidth - _bounds.x;
                                    y = _bounds.y + (position - 1) * _bounds.height;
                                    break;
                            }
                        }
                    }
                }
            }
        }

        public function updateBounds(bounds:Rectangle):void
        {
            _bounds = bounds;
        }
    }
}
