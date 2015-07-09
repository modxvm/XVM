/**
 * XVM
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package xvm.ping.PingServers
{
    import com.xfw.*;
    import com.xfw.events.*;
    import com.xvm.*;
    import com.xvm.utils.*;
    import com.xvm.types.cfg.*;
    import flash.text.*;
    import flash.events.*;
    import scaleform.clik.core.*;

    public class PingServersView extends UIComponent
    {
        
        private static const QUALITY_BAD:String = "bad";
        private static const QUALITY_POOR:String = "poor";
        private static const QUALITY_GOOD:String = "good";
        private static const QUALITY_GREAT:String = "great";
        private static const STYLE_NAME_PREFIX:String = "xvm_ping_";

        private var cfg:CPingServers;
        private var fields:Vector.<TextField>;

        public function PingServersView(cfg:CPingServers)
        {
            mouseEnabled = false;
            this.cfg = cfg;
            fields = new Vector.<TextField>();
            var f:TextField = createNewField();
            f.htmlText = makeStyledRow( { cluster: Locale.get("Initialization"), time: "..." } );
            PingServers.addEventListener(update);
            this.addEventListener(Event.RESIZE, updatePositions);
        }

        override protected function onDispose():void
        {
            PingServers.removeEventListener(update);
            this.removeEventListener(Event.RESIZE, updatePositions);
            super.onDispose();
        }

        // -- Private

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
                case "center":
                    return (App.appHeight - this.actualHeight) / 2;
                case "bottom":
                    return App.appHeight - this.actualHeight;
            }
            return 0;
        }

        private function updatePositions():void
        {
            if (fields.length == 0)
                return
            for (var i:int = 1; i < fields.length; i++) // make full width
            {
                var currentField:TextField = fields[i];
                var prevField:TextField = fields[i - 1];
                currentField.x = prevField.x + prevField.width + cfg.columnGap;
            }
            // align using new width
            var y_offset:int = get_y_offset();
            fields[0].x = cfg.x + get_x_offset();
            fields[0].y = cfg.y + y_offset;
            for (i = 1; i < fields.length; i++)
            {
                currentField = fields[i];
                prevField = fields[i - 1];
                currentField.x = prevField.x + prevField.width + cfg.columnGap;
                currentField.y = cfg.y + y_offset;
            }
        }

        public function update(e:ObjectEvent):void
        {
            try
            {
                var responseTimeList:Array = e.result as Array;
                if (responseTimeList.length == 0)
                    return;
                clearAllFields();
                for (var i:int = 0; i < responseTimeList.length; ++i)
                    appendRowToFields(makeStyledRow(responseTimeList[i]));
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
            var raw:String = cluster + cfg.delimiter + time;
            if (cluster == "###best_ping###") //will be first in sorting
                raw = Locale.get("Ping") + cfg.delimiter + " ";
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
            for (var i:int = 0; i < fields.length; i++)
            {
                var field:TextField = fields[i];
                if (field.htmlText == "" || field.numLines < cfg.maxRows)
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
            tf.name = "tfPing" + num;
            tf.x = cfg.x + get_x_offset();
            tf.y = cfg.y + get_y_offset();
            tf.width = 200;
            tf.height = 200;
            tf.autoSize = TextFieldAutoSize.LEFT;
            tf.multiline = true;
            tf.wordWrap = false;
            tf.selectable = false;
            tf.mouseEnabled = false;
            tf.styleSheet = WGUtils.createStyleSheet(createCss());
            tf.alpha = cfg.alpha / 100.0;
            tf.htmlText =  "";
            if (cfg.shadow.enabled)
                tf.filters = [ Utils.createShadowFilterFromConfig(cfg.shadow) ];
            addChild(tf);
            return tf;
        }

        // -- Private

        private function createCss():String
        {
            var css:String = "";
            css += createQualityCss(PingServersView.QUALITY_GREAT);
            css += createQualityCss(PingServersView.QUALITY_GOOD)
            css += createQualityCss(PingServersView.QUALITY_POOR);
            css += createQualityCss(PingServersView.QUALITY_BAD);

            return css;
        }

        private function createQualityCss(quality:String):String
        {
            var size:Number = cfg.fontStyle.size;
            var bold:Boolean = cfg.fontStyle.bold;
            var italic:Boolean = cfg.fontStyle.italic;
            var name:String = cfg.fontStyle.name;
            var color:Number = parseInt(cfg.fontStyle.color[quality], 16);

            return WGUtils.createCSS(PingServersView.STYLE_NAME_PREFIX + quality, color, name, size, "left", bold, italic);
        }
    }
}
