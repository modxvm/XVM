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
    import net.wg.gui.components.controls.*;
    import net.wg.gui.events.*;
    import scaleform.gfx.*;
    import scaleform.clik.core.*;

    public class ExtraFields extends UIComponent
    {
        private var _size:Rectangle;
        private var _layout:String;

        public function ExtraFields(formats:Array, defaultAlign:String, size:Rectangle = null, layout:String = null):void
        {
            visible = false;
            _size = size;
            _layout = layout;

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

                if (Macros.GlobalBoolean(format.enabled, true))
                {
                    addChild(format.src != null ? new ImageExtraField(format) : new TextExtraField(format, defaultAlign));
                }
            }
        }

        public function update(options:IVOMacrosOptions):void
        {
            for (var i:int = 0; i < this.numChildren; ++i)
            {
                var child:IExtraField = this.getChildAt(i) as IExtraField;
                if (child)
                {
                    child.update(options);
                }
            }
        }
    }
}
