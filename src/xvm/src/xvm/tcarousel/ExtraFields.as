package xvm.tcarousel
{
    import com.xvm.*;
    import com.xvm.types.*;
    import com.xvm.utils.*;
    import flash.display.*;
    import flash.filters.*;
    import flash.text.*;

    public class ExtraFields
    {
        public static function createExtraFields(owner:Sprite, width:Number, height:Number, cfg:Object):void
        {
            if (cfg == null)
                return;

            owner["cfg"] = cfg;

            var len:int = cfg.formats.length;
            owner["formats"] = [];
            for (var i:int = 0; i < len; ++i)
            {
                var format:Object = cfg.formats[i];

                if (format == null)
                    continue;

                if (typeof format == "string")
                {
                    format = { format: format };
                    cfg.formats[i] = format;
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
                owner["formats"].push(fmt);

                Logger.add("createExtraTextField: " + fmt);

                //if (fmt.src != null)
                //    createExtraMovieClip(mc, fmt, mc.formats.length - 1);
                //else
                    createExtraTextField(owner, fmt, owner["formats"].length - 1, width, height);
            }
        }

        public static function updateExtraFields(owner:Sprite):void
        {
            //Logger.add("updateExtraFields");
            //var obj = BattleState.getUserData(m_name);
            var formats:Array = owner["formats"];
            var len:Number = formats.length;
            for (var i:Number = 0; i < len; ++i)
                _internal_update(owner["f" + i], formats[i], null /*obj*/);
        }


        /*private function createExtraMovieClip(mc:MovieClip, format:Object, n:Number)
        {
            //Logger.addObject(format);
            var x:Number = format.x != null && !isNaN(format.x) ? format.x : 0;
            var y:Number = format.y != null && !isNaN(format.y) ? format.y : 0;
            var w:Number = format.w != null && !isNaN(format.w) ? format.w : NaN;
            var h:Number = format.h != null && !isNaN(format.h) ? format.h : NaN;

            var img:UILoaderAlt = (UILoaderAlt)(mc.attachMovie("UILoaderAlt", "f" + n, mc.getNextHighestDepth()));
            img["data"] = {
                x: x, y: y, w: w, h: h,
                format: format,
                align: format.align != null ? format.align : (isLeftPanel ? "left" : "right")
            };
            //Logger.addObject(img["data"]);

            img._alpha = format.alpha != null && !isNaN(format.alpha) ? format.alpha : 100;
            img._rotation = format.rotation != null && !isNaN(format.rotation) ? format.rotation : 0;

            img.autoSize = true;
            img.maintainAspectRatio = false;
            var me = this;
            img.visible = false;
            img.onLoadInit = function() { me.onExtraMovieClipLoadInit(img); }

            cleanupFormat(img, format);

            return img;
        }

        private function onExtraMovieClipLoadInit(img:UILoaderAlt)
        {
            //Logger.add("onExtraMovieClipLoadInit: " + m_name + " " + img.source);

            var data = img["data"];
            if (isNaN(data.w) && data.format.w == null)
                data.w = img.content._width;
            if (isNaN(data.h) && data.format.h == null)
                data.h = img.content._height;
            //Logger.addObject(data, 2, m_name);

            img.visible = false;
            img._x = 0;
            img._y = 0;
            img.width = 0;
            img.height = 0;
            alignField(img);

            setTimeout(function() { img.visible = true; }, 1);
        }*/

        private static function createExtraTextField(owner:Sprite, format:Object, n:Number, defW:Number, defH:Number):TextField
        {
            //Logger.addObject(format);
            var x:Number = format.x != null && !isNaN(format.x) ? format.x : 0;
            var y:Number = format.y != null && !isNaN(format.y) ? format.y : 0;
            var w:Number = format.w != null && !isNaN(format.w) ? format.w : defW;
            var h:Number = format.h != null  && !isNaN(format.h) ? format.h : defH;
            var tf:TextField = owner.addChild(new TextField()) as TextField;
            tf.name = "f" + n;
            tf["data"] = {
                x: x, y: y, w: w, h: h,
                align: format.align
            };

            tf.alpha = format.alpha != null && !isNaN(format.alpha) ? format.alpha : 100;
            tf.rotation = format.rotation != null && !isNaN(format.rotation) ? format.rotation : 0;

            tf.selectable = false;
            tf.multiline = true;
            tf.wordWrap = false;
            tf.antiAliasType = format.antiAliasType != null ? format.antiAliasType : "advanced";
            tf.autoSize = "none";
            //tf.verticalAlign = format.valign != null ? format.valign : "none";
            //tf.styleSheet =  Utils.createStyleSheet(Utils.createCSS("extraField", 0xFFFFFF, "$FieldFont", 14, "center", false, false));

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
            //var img:UILoaderAlt = UILoaderAlt(field);

            var data:Object = field["data"];
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
            else
            {
                /*if (img.x != x)
                    img.x = x;
                if (img.y != y)
                    img.y = y;
                if (img.width != w || img.height != h)
                {
                    //Logger.add(img.width + "->" + w + " " + x + " " + y + " " + m_name + " " + wrapper._name);
                    img.setSize(w, h);
                    img.validateNow();
                }*/
            }
        }

        private static function _internal_update(f:DisplayObject, format:Object, options:MacrosFormatOptions):void
        {
            var m_name:String = null;

            var tf:TextField = f as TextField;

            var needAlign:Boolean = false;
            var data:Object = f["data"];

            if (format.x != null)
            {
                data.x = parseFloat(Macros.Format(m_name, format.x, options)) || 0;
                needAlign = true;
            }
            if (format.y != null)
            {
                data.y = parseFloat(Macros.Format(m_name, format.y, options)) || 0;
                needAlign = true;
            }
            if (format.w != null)
            {
                data.w = parseFloat(Macros.Format(m_name, format.w, options)) || 0;
                needAlign = true;
            }
            if (format.h != null)
            {
                data.h = parseFloat(Macros.Format(m_name, format.h, options)) || 0;
                needAlign = true;
            }
            if (format.alpha != null)
            {
                var alpha:Number = parseFloat(Macros.Format(m_name, format.alpha, options));
                f.alpha = isNaN(alpha) ? 100 : alpha;
            }
            if (format.rotation != null)
                f.rotation = parseFloat(Macros.Format(m_name, format.rotation, options)) || 0;
            if (format.borderColor != null && tf != null)
                tf.borderColor = parseInt(Macros.Format(m_name, format.borderColor, options).split("#").join("0x")) || 0;
            if (format.bgColor != null && tf != null)
                tf.backgroundColor = parseInt(Macros.Format(m_name, format.bgColor, options).split("#").join("0x")) || 0;

            if (format.format != null && tf != null)
            {
                var txt:String = Macros.Format(m_name, format.format, options);
                //Logger.add(m_name + " " + txt);
                tf.htmlText = "<span class='extraField'>" + txt + "</span>";
                //if (format.format.indexOf("{{") < 0) // TODO
                //    delete format.format;
                needAlign = true;
            }

            /*if (format.src != null)
            {
                //var dead = (wrapper.data.vehicleState & net.wargaming.ingame.VehicleStateInBattle.IS_ALIVE) == 0;
                //Logger.add(dead + " " + obj.dead + " " + m_name);
                var src:String = Macros.Format(m_name, format.src, options);
                src = "../../" + Utils.fixImgTag(src).split("img://").join("");
                if (f.source != src)
                {
                    //Logger.add(m_name + " " + f.source + " => " + src);
                    f._visible = false;
                    f.source = src;
                }
            }*/

            if (needAlign)
                alignField(f);
        }

    }

}
