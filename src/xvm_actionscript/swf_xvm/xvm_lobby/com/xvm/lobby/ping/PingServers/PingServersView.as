/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.lobby.ping.PingServers
{
    import com.xfw.*;
    import com.xfw.events.*;
    import com.xvm.*;
    import com.xvm.types.cfg.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import net.wg.gui.components.controls.UILoaderAlt; // '*' conflicts with UI classes
    import net.wg.gui.events.*;
    import org.idmedia.as3commons.util.*;
    import scaleform.clik.core.*;
    import scaleform.gfx.*;

    public class PingServersView extends UIComponent
    {
        private static const QUALITY_BAD:String = "bad";
        private static const QUALITY_POOR:String = "poor";
        private static const QUALITY_GOOD:String = "good";
        private static const QUALITY_GREAT:String = "great";
        private static const SERVER_COLOR:String = "server"; // actually it's server + delimiter
        private static const STYLE_NAME_PREFIX:String = "xvm_ping_";
        private static const COMMAND_GETCURRENTSERVER:String = "xvm_ping.getcurrentserver";
        private static const COMMAND_AS_CURRENTSERVER:String = "xvm_ping.as.currentserver";

        private var cfg:CPingServers;
        private var fields:Vector.<TextField>;
        private var currentServer:String;
        private var serverColor:Number;
        private var bgImage:UILoaderAlt;

        public function PingServersView(cfg:CPingServers)
        {
            // https://ci.modxvm.com/sonarqube/coding_rules?open=flex%3AS1447&rule_key=flex%3AS1447
            _init(cfg);
        }

        private function _init(cfg:CPingServers):void
        {
            mouseEnabled = false;
            this.cfg = cfg;
            this.serverColor = parseInt(cfg.fontStyle.serverColor, 16);
            if (cfg.bgImage != null)
            {
                createBackgroundImage(cfg.bgImage);
            }
            fields = new Vector.<TextField>();
            var f:TextField = createNewField();
            f.htmlText = makeStyledRow( { cluster: Locale.get("Initialization"), time: "..." } );
            updatePositions();
            PingServers.addEventListener(update);
            this.addEventListener(Event.RESIZE, updatePositions, false, 0, true);
            Xfw.addCommandListener(COMMAND_AS_CURRENTSERVER, currentServerCallback);
            Xfw.cmd(COMMAND_GETCURRENTSERVER);
        }

        override protected function onDispose():void
        {
            PingServers.removeEventListener(update);
            this.removeEventListener(Event.RESIZE, updatePositions);
            super.onDispose();
        }

        // -- Private

        private function currentServerCallback(name:String):void
        {
            currentServer = StringUtils.startsWith(name, "WOT ") ? name.slice(4) : name;
        }

        private function get_x_offset():int
        {
            switch (cfg.hAlign)
            {
                case "center":
                    return (App.appWidth - this.actualWidth) / 2;
                case "right":
                    return App.appWidth - this.actualWidth;
            }
            return 0;
        }

        private function get_y_offset():int
        {
            switch (cfg.vAlign)
            {
                case TextFieldEx.VALIGN_CENTER:
                    return (App.appHeight - this.actualHeight) / 2;
                case TextFieldEx.VALIGN_BOTTOM:
                    return App.appHeight - this.actualHeight;
            }
            return 0;
        }

        private function createBackgroundImage(src:String):void
        {
            // wild coding style :)
            bgImage = this.addChildAt(App.utils.classFactory.getComponent("UILoaderAlt", UILoaderAlt, {
                autoSize: true,
                maintainAspectRatio: false,
                source: "../../" + Utils.fixImgTag(src).replace("img://", "")
            }), 0) as UILoaderAlt;
            bgImage.addEventListener(UILoaderEvent.COMPLETE, function(e:UILoaderEvent):void {
                var img:UILoaderAlt = e.currentTarget as UILoaderAlt;
                var loader:Loader = img.getChildAt(1) as Loader;
                img.width = loader.contentLoaderInfo.content.width;
                img.height = loader.contentLoaderInfo.content.height;
            });
        }

        private function updatePositions():void
        {
            if (!fields.length)
                return
            var len:int = fields.length;
            for (var i:int = 1; i < len; ++i) // make full width
            {
                var currentField:TextField = fields[i];
                var prevField:TextField = fields[i - 1];
                currentField.x = prevField.x + prevField.width + cfg.columnGap;
            }
            // align using new width
            var y_offset:int = get_y_offset();
            fields[0].x = cfg.x + get_x_offset();
            fields[0].y = cfg.y + y_offset;
            len = fields.length;
            for (i = 1; i < len; ++i)
            {
                currentField = fields[i];
                prevField = fields[i - 1];
                currentField.x = prevField.x + prevField.width + cfg.columnGap;
                currentField.y = cfg.y + y_offset;
            }
            if (bgImage != null)
            {
                bgImage.x = fields[0].x;
                bgImage.y = fields[0].y;
            }
        }

        private function update(e:ObjectEvent):void
        {
            try
            {
                var responseList:Array = e.result as Array;
                if (!responseList.length)
                    return;
                clearAllFields();
                var len:int = responseList.length;
                for (var i:int = 0; i < len; ++i)
                    appendRowToFields(makeStyledRow(responseList[i]));
            }
            catch (ex:Error)
            {
                Logger.err(ex);
            }
        }

        /**
         * Each update data is obsolete.
         * Content is erased, but empty fields remain.
         */
        private function clearAllFields():void
        {
            for each (var tf:TextField in fields)
                tf.htmlText = "";
        }

        private function appendRowToFields(row:String):void
        {
            var tf:TextField = getReceiverField();
            tf.htmlText += row;
            updatePositions();
        }

        private function makeStyledRow(pingObj:Object):String
        {
            var cluster:String = pingObj.cluster;
            var time:String = pingObj.time;
            var raw:String = "";
            var isTitle:Boolean = (cluster == "###best_ping###");
            //deal with title and values
            if (isTitle)
                cluster = Locale.get("Ping");
            else
            {
                raw = time
                if (raw != "...")
                    while (raw.length < cfg.minimalValueLength) //left pad the value for minimal length
                        raw = " " + raw;
            }
            while (cluster.length < cfg.minimalNameLength) //left pad the value for minimal length
                cluster = cluster + " ";
            //put everything together: server + delimiter + padded value
            if ((cfg.showServerName && !isTitle) || time == "..." || (cfg.showTitle && isTitle))
            {
                if (!isNaN(serverColor) && time != "...")
                    raw = "<span class='" + STYLE_NAME_PREFIX + SERVER_COLOR + "'>" + cluster + cfg.delimiter + "</span>" + raw;
                else
                    raw = cluster + cfg.delimiter + raw;
            }
            //mark current server
            if (pingObj.cluster == currentServer)
                raw = cfg.currentServerFormat.replace("{server}", raw);
            return "<textformat leading='" + cfg.leading + "'><span class='" + STYLE_NAME_PREFIX + defineQuality(time) + "'>" + raw + "</span></textformat>";
        }

        private function defineQuality(time:String):String
        {
            var t:Number = parseInt(time);
            if (isNaN(t))
                return QUALITY_BAD;
            if (t < cfg.threshold[QUALITY_GREAT])
                return QUALITY_GREAT;
            if (t < cfg.threshold[QUALITY_GOOD])
                return QUALITY_GOOD;
            else if (t < cfg.threshold[QUALITY_POOR])
                return QUALITY_POOR;
            return QUALITY_BAD;
        }

        /**
         * Defines which field is appropriate for data apeend.
         * If there is no such field then create one.
         */
        private function getReceiverField():TextField
        {
            var firstNotFullField:TextField = getFirstNotFullField();
            return  firstNotFullField || createNewField();
        }

        /**
         * Align colums so they do not overlap each other.
        public function alignFields():void
        {
            for (var i:int = 1; i < fields.length; i++)
            {
                var currentField:TextField = fields[i];
                var prevField:TextField = fields[i - 1];
                currentField.x = prevField.x + prevField.width + cfg.columnGap;
            }
        }
         */

        // -- Private

        private function getFirstNotFullField():TextField
        {
            var len:int = fields.length;
            for (var i:int = 0; i < len; i++)
            {
                var field:TextField = fields[i];
                if (!field.htmlText || field.numLines < cfg.maxRows)
                {
                    return field;
                }
            }

            return null;
        }

        private function createNewField():TextField
        {
            //Logger.add("createNewField()");
            var newFieldNum:int = fields.length + 1;
            var newField:TextField = createField(newFieldNum);
            fields.push(newField);
            return fields[fields.length - 1];
        }

        public function createField(num:int):TextField
        {
            var tf:TextField = new TextField();
            tf.mouseEnabled = false;
            tf.selectable = false;
            TextFieldEx.setNoTranslate(tf, true);
            tf.antiAliasType = AntiAliasType.ADVANCED;
            tf.name = "tfPing" + num;
            tf.x = cfg.x + get_x_offset();
            tf.y = cfg.y + get_y_offset();
            tf.width = 200;
            tf.height = 200;
            tf.autoSize = TextFieldAutoSize.LEFT;
            tf.multiline = true;
            tf.wordWrap = false;
            tf.styleSheet = XfwUtils.createStyleSheet(createCss());
            tf.alpha = cfg.alpha / 100.0;
            tf.htmlText =  "";
            tf.filters = Utils.createShadowFiltersFromConfig(cfg.shadow);
            addChild(tf);
            return tf;
        }

        // -- Private

        private function createCss():String
        {
            var css:Array = [];
            css.push(createQualityCss(PingServersView.QUALITY_GREAT));
            css.push(createQualityCss(PingServersView.QUALITY_GOOD));
            css.push(createQualityCss(PingServersView.QUALITY_POOR));
            css.push(createQualityCss(PingServersView.QUALITY_BAD));
            if (!isNaN(serverColor))
                css.push(createServerColorCss());

            return css.join("");
        }

        private function createQualityCss(quality:String):String
        {
            var size:Number = cfg.fontStyle.size;
            var bold:Boolean = cfg.fontStyle.bold;
            var italic:Boolean = cfg.fontStyle.italic;
            var name:String = cfg.fontStyle.name;
            var color:Number = parseInt(cfg.fontStyle.color[quality], 16);

            return XfwUtils.createCSS(PingServersView.STYLE_NAME_PREFIX + quality, color, name, size, "left", bold, italic);
        }

        private function createServerColorCss():String
        {
            return "." + STYLE_NAME_PREFIX + SERVER_COLOR + " {color:" + XfwUtils.toHtmlColor(serverColor) + "};"
        }
    }
}
