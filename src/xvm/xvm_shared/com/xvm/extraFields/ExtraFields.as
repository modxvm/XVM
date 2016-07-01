/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.extraFields
{
    import com.xfw.*;
    import com.xvm.*;
    import com.xvm.types.*;
    import com.xvm.types.dossier.*;
    import com.xvm.vo.*;
    import com.xvm.types.cfg.*;
    import flash.display.*;
    import flash.filters.*;
    import flash.text.*;
    import flash.geom.*;
    import flash.utils.*;
    import scaleform.gfx.*;
    import scaleform.clik.core.*;

    public class ExtraFields extends UIComponent
    {
        private var _bounds:Rectangle;
        private var _layout:String;
        private var _isLeftPanel:Boolean;

        public function ExtraFields(formats:Array, isLeftPanel:Boolean = true, getSchemeNameForText:Function = null, getSchemeNameForImage:Function = null, bounds:Rectangle = null, layout:String = null):void
        {
            mouseEnabled = false;
            mouseChildren = false;

            _bounds = bounds;
            _layout = layout;
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
                    addChild(format.src != null
                        ? new (App.utils.classFactory.getClass("com.xvm.extraFields::ImageExtraField"))(format, isLeftPanel, getSchemeNameForImage) // TODO: make ImageExtraField shared
                        : new TextExtraField(format, isLeftPanel, getSchemeNameForText, _bounds));
                }
            }
        }

        override protected function configUI():void
        {
            super.configUI();
        }

        public function update(options:IVOMacrosOptions, bindToIconOffset:Number = 0):void
        {
            for (var i:int = 0; i < this.numChildren; ++i)
            {
                var child:IExtraField = this.getChildAt(i) as IExtraField;
                if (child)
                {
                    child.update(options, bindToIconOffset);
                    if (_bounds && _layout)
                    {
                        if (_layout == "horizontal")
                        {
                            var vx:Number = _bounds.x + (options.position - 1) * _bounds.width;
                            x = _isLeftPanel ? vx : App.appWidth - vx;
                            y = _bounds.y;
                        }
                        else
                        {
                            x = _isLeftPanel ? _bounds.x : App.appWidth - _bounds.x;
                            y = _bounds.y + (options.position - 1) * _bounds.height;
                        }
                    }
                }
            }
        }
    }
}
