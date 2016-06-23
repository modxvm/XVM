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
        public static const DEFAULT_TEXT_FIELD_WIDTH_HEIGHT:Number = 25;

        private var format:CExtraField;

        public function TextExtraField(format:CExtraField, defaultAlign:String)
        {
            super();

            this.format = format.clone();

            //Logger.addObject(format);

            //var x:Number = Macros.FormatNumber(m_name, format, "x", null, 0, 0);
            //var y:Number = Macros.FormatNumber(m_name, format, "y", null, 0, 0);
            //var w:Number = Macros.FormatNumber(m_name, format, "w", null, defW, 0);
            //var h:Number = Macros.FormatNumber(m_name, format, "h", null, defH, 0);

            //scaleX = Macros.FormatNumber(m_name, format, "scaleX", null, 1, 1) * 100;
            //tf._yscale = Macros.FormatNumber(m_name, format, "scaleY", null, 1, 1) * 100;
            //tf._alpha = Macros.FormatNumber(m_name, format, "alpha", null, 100, 100);
            //tf._rotation = Macros.FormatNumber(m_name, format, "rotation", null, 0, 0);

            selectable = false;
            multiline = true;
            wordWrap = false;
            //antiAliasType = Macros.GlobalString(format.antiAliasType, AntiAliasType.ADVANCED);
            autoSize = TextFieldAutoSize.NONE;
            //align = Macros.GlobalString(format.align, defaultAlign);
            TextFieldEx.setVerticalAlign(this, Macros.GlobalString(format.valign, TextFieldEx.VALIGN_NONE));
            styleSheet = WGUtils.createStyleSheet(WGUtils.createCSS("extraField", 0xFFFFFF, "$FieldFont", 14, "center"));

            //tf.borderColor = Macros.FormatNumber(m_name, format, "borderColor", null, 0xCCCCCC, 0xCCCCCC, true);
            //tf.background = format.bgColor != null;
            //tf.backgroundColor = Macros.FormatNumber(m_name, format, "bgColor", null, 0x000000, 0x000000, true);
            //if (tf.background && !tf.border)
            //{
            //    format.borderColor = format.bgColor;
            //    tf.border = true;
            //    tf.borderColor = tf.backgroundColor;
            //}

            //if (format.shadow != null)
            //{
            //    var macrosExists:Boolean =
            //        format.shadow.distance != null && String(format.shadow.distance).indexOf("{{") >= 0 ||
            //        format.shadow.angle != null && String(format.shadow.angle).indexOf("{{") >= 0 ||
            //        format.shadow.color != null && String(format.shadow.color).indexOf("{{") >= 0 ||
            //        format.shadow.alpha != null && String(format.shadow.alpha).indexOf("{{") >= 0 ||
            //        format.shadow.blur != null && String(format.shadow.blur).indexOf("{{") >= 0 ||
            //        format.shadow.strength != null && String(format.shadow.strength).indexOf("{{") >= 0;
            //    if (!macrosExists)
            //    {
            //        tf.filters = [
            //            new DropShadowFilter(
            //                format.shadow.distance != null ? format.shadow.distance : 0,
            //                format.shadow.angle != null ? format.shadow.angle : 45,
            //                format.shadow.color != null ? parseInt(format.shadow.color) : 0x000000,
            //                format.shadow.alpha != null ? format.shadow.alpha / 100.0 : 1,
            //                format.shadow.blur != null ? format.shadow.blur : 4,
            //                format.shadow.blur != null ? format.shadow.blur : 4,
            //                format.shadow.strength != null ? format.shadow.strength : 1)
            //        ];
            //        delete format.shadow;
            //    }
            //}

            //cleanupFormat(tf, format);

            //alignField(tf);
        }

        public final function dispose():void
        {

        }

        public function update(options:IVOMacrosOptions):void
        {
            /*var needAlign:Boolean = false;
            var data:Object = (f.parent as MovieClip).data[f.name];

            if (format.x != null)
            {
                if (format.bindToIcon)
                {
                    value += isLeftPanel
                        ? panel.m_list._x + panel.m_list.width
                        : App.appWidth - panel._x - panel.m_list._x + panel.m_list.width;
                }
                data.x = parseFloat(Macros.Format(null, format.x, options)) || 0;
                needAlign = true;
            }
            if (format.y != null)
            {
                data.y = parseFloat(Macros.Format(null, format.y, options)) || 0;
                needAlign = true;
            }
            if (format.w != null)
            {
                data.w = parseFloat(Macros.Format(null, format.w, options)) || 0;
                needAlign = true;
            }
            if (format.h != null)
            {
                data.h = parseFloat(Macros.Format(null, format.h, options)) || 0;
                needAlign = true;
            }
            if (format.alpha != null)
            {
                var alpha:Number = parseFloat(Macros.Format(null, format.alpha, options));
                f.alpha = isNaN(alpha) ? 1 : alpha / 100.0;
            }
            if (format.rotation != null)
                f.rotation = parseFloat(Macros.Format(null, format.rotation, options)) || 0;
            if (format.borderColor != null && tf != null)
                tf.borderColor = parseInt(Macros.Format(null, format.borderColor, options).split("#").join("0x")) || 0;
            if (format.bgColor != null && tf != null)
                tf.backgroundColor = parseInt(Macros.Format(null, format.bgColor, options).split("#").join("0x")) || 0;

            if (format.format != null && tf != null)
            {
                var txt:String = Macros.Format(null, format.format, options);
                //Logger.add(txt);
                tf.htmlText = "<span class='extraField'>" + txt + "</span>";
                needAlign = true;
            }

            if (format.shadow != null && tf != null)
            {
                tf.filters = Utils.createShadowFiltersFromConfig(format.shadow, options);
            }

            if (needAlign)
                alignField(f);*/
        }

        public function alignField():void
        {
            //var data:Object = (field.parent as MovieClip).data[field.name];
            //Logger.addObject(data);
/*
            var x:Number = data.x;
            var y:Number = data.y;
            var w:Number = data.w;
            var h:Number = data.h;

            if (tf != null)
            {
                if (tf.textWidth > 0)
                    w = tf.textWidth + 4; // 2 * 2-pixel gutter
            }

            if (data.align == "right")
                x -= w;
            else if (data.align == "center")
                x -= w / 2;

            //Logger.add("x:" + x + " y:" + y + " w:" + w + " h:" + h + " align:" + data.align);

            if (tf != null)
            {
                if (tf.x != x)
                    tf.x = x;
                if (tf.y != y)
                    tf.y = y;
                if (tf.width != w)
                    tf.width = w;
                if (tf.height != h)
                    tf.height = h;
            }*/
        }
    }
}
