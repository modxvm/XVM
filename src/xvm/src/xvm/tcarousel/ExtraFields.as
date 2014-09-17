package xvm.tcarousel
{
    import com.xvm.*;
    import com.xvm.types.*;
    import com.xvm.types.dossier.*;
    import com.xvm.utils.*;
    import flash.display.*;
    import flash.filters.*;
    import flash.text.*;
    import flash.utils.*;
    import net.wg.gui.components.controls.*;
    import scaleform.gfx.*;

    public class ExtraFields
    {
        public static function createExtraFields(owner:MovieClip, width:Number, height:Number, cfg:Object):void
        {
            if (cfg == null)
                return;

            //Logger.addObject(cfg, 2);
            owner.cfg = cfg;

            var len:int = cfg.length;
            owner.formats = [];
            owner.data = {};
            for (var i:int = 0; i < len; ++i)
            {
                var format:Object = cfg[i];

                if (format == null)
                    continue;

                if (typeof format == "string")
                {
                    format = { format: format };
                    cfg[i] = format;
                }

                if (typeof format != "object")
                    continue;

                var isEmpty:Boolean = true;
                for (var _tmp:String in format)
                {
                    isEmpty = false;
                    break;
                }
                if (isEmpty)
                    continue;

                // make a copy of format, because it will be changed
                var fmt:Object = { };
                for (var n:String in format)
                    fmt[n] = format[n];
                owner.formats.push(fmt);

                //Logger.addObject(fmt);

                createExtraTextField(owner, fmt, owner.formats.length - 1, width, height);
            }
        }

        public static function updateVehicleExtraFields(owner:MovieClip, vdata:VehicleDossierCut):void
        {
            //Logger.add("updateVehicleExtraFields");
            var formats:Array = owner.formats;
            var len:Number = formats.length;
            for (var i:Number = 0; i < len; ++i)
            {
                var field:DisplayObject = owner.getChildByName("f" + i);
                if (field != null)
                {
                    var opt:MacrosFormatOptions = new MacrosFormatOptions();
                    opt.vdata = vdata;
                    _internal_update(field, formats[i], opt);
                }
            }
        }

        private static function createExtraTextField(owner:MovieClip, format:Object, n:Number, defW:Number, defH:Number):TextField
        {
            //Logger.addObject(format);
            var x:Number = format.x != null && !isNaN(format.x) ? format.x : 0;
            var y:Number = format.y != null && !isNaN(format.y) ? format.y : 0;
            var w:Number = format.w != null && !isNaN(format.w) ? format.w : defW;
            var h:Number = format.h != null  && !isNaN(format.h) ? format.h : defH;

            var tf:TextField = owner.addChild(new TextField()) as TextField;
            tf.name = "f" + n;
            owner.data[tf.name] = {
                x: x, y: y, w: w, h: h,
                align: format.align
            };

            tf.alpha = format.alpha != null && !isNaN(format.alpha) ? format.alpha / 100.0 : 1;
            tf.rotation = format.rotation != null && !isNaN(format.rotation) ? format.rotation : 0;

            tf.selectable = false;
            tf.multiline = true;
            tf.wordWrap = false;
            tf.antiAliasType = format.antiAliasType != null ? format.antiAliasType : AntiAliasType.ADVANCED;
            tf.autoSize = TextFieldAutoSize.NONE;
            TextFieldEx.setVerticalAlign(tf, format.valign != null ? format.valign : TextFieldEx.VALIGN_NONE);
            tf.styleSheet = Utils.createStyleSheet(Utils.createCSS("extraField", 0xFFFFFF, "$FieldFont", 14, "center", false, false));

            tf.border = format.borderColor != null;
            tf.borderColor = format.borderColor != null && !isNaN(format.borderColor) ? format.borderColor : 0xCCCCCC;
            tf.background = format.bgColor != null;
            tf.backgroundColor = format.bgColor != null && !isNaN(format.bgColor) ? format.bgColor : 0x000000;
            if (tf.background && !tf.border)
            {
                format.borderColor = format.bgColor;
                tf.border = true;
                tf.borderColor = tf.backgroundColor;
            }

            if (format.shadow != null)
            {
                tf.filters = [
                    new DropShadowFilter(
                        format.shadow.distance != null ? format.shadow.distance : 0,
                        format.shadow.angle != null ? format.shadow.angle : 45,
                        format.shadow.color != null ? parseInt(format.shadow.color) : 0x000000,
                        format.shadow.alpha != null ? format.shadow.alpha : 1,
                        format.shadow.blur != null ? format.shadow.blur : 4,
                        format.shadow.blur != null ? format.shadow.blur : 4,
                        format.shadow.strength != null ? format.shadow.strength : 1)
                ];
            }

            cleanupFormat(tf, format);

            alignField(tf);

            return tf;
        }

        // cleanup formats without macros to remove extra checks
        private static function cleanupFormat(field:TextField, format:Object):void
        {
            if (format.x != null && (typeof format.x != "string" || format.x.indexOf("{{") < 0))
                delete format.x;
            if (format.y != null && (typeof format.y != "string" || format.y.indexOf("{{") < 0))
                delete format.y;
            if (format.w != null && (typeof format.w != "string" || format.w.indexOf("{{") < 0))
                delete format.w;
            if (format.h != null && (typeof format.h != "string" || format.h.indexOf("{{") < 0))
                delete format.h;
            if (format.alpha != null && (typeof format.alpha != "string" || format.alpha.indexOf("{{") < 0))
                delete format.alpha;
            if (format.rotation != null && (typeof format.rotation != "string" || format.rotation.indexOf("{{") < 0))
                delete format.rotation;
            if (format.borderColor != null && (typeof format.borderColor != "string" || format.borderColor.indexOf("{{") < 0))
                delete format.borderColor;
            if (format.bgColor != null && (typeof format.bgColor != "string" || format.bgColor.indexOf("{{") < 0))
                delete format.bgColor;
        }

        private static function alignField(field:DisplayObject):void
        {
            var tf:TextField = field as TextField;

            var data:Object = (field.parent as MovieClip).data[field.name];
            //Logger.addObject(data);

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

            //Logger.add("x:" + x + " y:" + y + " w:" + w + " h:" + h + " align:" + data.align + " textWidth:" + tf.textWidth);

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
            }
        }

        private static function _internal_update(f:DisplayObject, format:Object, options:MacrosFormatOptions):void
        {
            var tf:TextField = f as TextField;

            var needAlign:Boolean = false;
            var data:Object = (f.parent as MovieClip).data[f.name];

            if (format.x != null)
            {
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

            if (needAlign)
                alignField(f);
        }

    }

}
