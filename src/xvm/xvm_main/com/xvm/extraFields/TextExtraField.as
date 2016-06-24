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
        //public static const DEFAULT_TEXT_FIELD_WIDTH:Number = 300;
        //public static const DEFAULT_TEXT_FIELD_WIDTH_HEIGHT:Number = 25;

        private var cfg:CExtraField;
        private var isLeftPanel:Boolean;
        private var getColorSchemeName:Function;

        private var _initialized:Boolean = false;

        private var _xValue:Number = 0;
        private var _yValue:Number = 0;
        private var _widthValue:Number = NaN;
        private var _heightValue:Number = NaN;
        private var _colorSchemeNameValue:String = null;

        public function TextExtraField(format:CExtraField, isLeftPanel:Boolean, getColorSchemeName:Function)
        {
            super();

            this.cfg = format.clone();
            this.isLeftPanel = isLeftPanel;
            this.getColorSchemeName = getColorSchemeName;

            var defaultAlign:String = isLeftPanel ? TextFormatAlign.LEFT : TextFormatAlign.RIGHT;
            cfg.align = Macros.FormatStringGlobal(cfg.align, defaultAlign);
            cfg.bindToIcon = Macros.FormatBooleanGlobal(cfg.bindToIcon, false);

            selectable = false;
            multiline = true;
            wordWrap = false;
            autoSize = TextFieldAutoSize.NONE;
            antiAliasType = Macros.FormatStringGlobal(cfg.antiAliasType, AntiAliasType.ADVANCED);
            TextFieldEx.setVerticalAlign(this, Macros.FormatStringGlobal(cfg.valign, TextFieldEx.VALIGN_NONE));
            styleSheet = WGUtils.createStyleSheet(WGUtils.createCSS("TextExtraField", 0xFFFFFF, "$FieldFont", 14, "center"));
        }

        public final function dispose():void
        {

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
                    border = !isNaN(value);
                    borderColor = value;
                }
                cfg.borderColor = null;
            }

            value = Macros.FormatNumber(cfg.bgColor, options, NaN, true);
            if (Macros.IsCached(cfg.bgColor, options))
            {
                if (!isNaN(value))
                {
                    background = !isNaN(value);
                    backgroundColor = value;
                }
                cfg.bgColor = null;
            }

            if (background && !border)
            {
                cfg.borderColor = cfg.bgColor;
                border = true;
                borderColor = backgroundColor;
            }

            value = Macros.Format(cfg.format, options) || "";
            if (Macros.IsCached(cfg.format, options))
            {
                cfg.format = value;
            }

            /*if (cfg.shadow != null)
            {
                var shadow:CShadow = cfg.shadow.clone();
                //value = Macros.Format(options.playerName, shadow., options);

                return !Macros.GlobalBoolean(cfg.enabled, true, options) ? null : [new DropShadowFilter(
                Macros.GlobalNumber(cfg.distance, 0, options),
                Macros.GlobalNumber(cfg.angle, 0, options),
                Macros.GlobalNumber(cfg.color, 0, options),
                Macros.GlobalNumber(cfg.alpha, 70, options) / 100.0,
                Macros.GlobalNumber(cfg.blur, 4, options),
                Macros.GlobalNumber(cfg.blur, 4, options),
                Macros.GlobalNumber(cfg.strength, 2, options),
                Macros.GlobalNumber(cfg.quality, 3, options),
                Macros.GlobalBoolean(cfg.inner, false, options),
                Macros.GlobalBoolean(cfg.knockout, false, options),
                Macros.GlobalBoolean(cfg.hideObject, false, options))];

                    format.shadow.distance != null && String(format.shadow.distance).indexOf("{{") >= 0 ||
                    format.shadow.angle != null && String(format.shadow.angle).indexOf("{{") >= 0 ||
                    format.shadow.color != null && String(format.shadow.color).indexOf("{{") >= 0 ||
                    format.shadow.alpha != null && String(format.shadow.alpha).indexOf("{{") >= 0 ||
                    format.shadow.blur != null && String(format.shadow.blur).indexOf("{{") >= 0 ||
                    format.shadow.strength != null && String(format.shadow.strength).indexOf("{{") >= 0;
                if (!macrosExists)
                {
                    tf.filters = [
                        new DropShadowFilter(
                            format.shadow.distance != null ? format.shadow.distance : 0,
                            format.shadow.angle != null ? format.shadow.angle : 45,
                            format.shadow.color != null ? parseInt(format.shadow.color) : 0x000000,
                            format.shadow.alpha != null ? format.shadow.alpha / 100.0 : 1,
                            format.shadow.blur != null ? format.shadow.blur : 4,
                            format.shadow.blur != null ? format.shadow.blur : 4,
                            format.shadow.strength != null ? format.shadow.strength : 1)
                    ];
                    delete format.shadow;
                }
            }*/
        }

        public function update(options:IVOMacrosOptions, bindToIconOffset:Number = NaN):void
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
                tf.htmlText = "<span class='TextExtraField'>" + txt + "</span>";
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
