/**
 * XVM Config
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.types.cfg
{
    import com.xfw.*;
    import flash.text.*;

    public dynamic class CTextFormat extends Object implements ICloneable
    {
        public var enabled:*;
        public var font:String;
        public var size:*;
        public var color:*;
        public var bold:*;
        public var italic:*;
        public var underline:*;
        public var align:String;
        public var leftMargin:*;
        public var rightMargin:*;
        public var indent:*;
        public var leading:*;
        public var tabStops:Array;

        public function clone():*
        {
            var cloned:CTextFormat = new CTextFormat();
            cloned.enabled = enabled;
            cloned.font = font;
            cloned.size = size;
            cloned.color = color;
            cloned.bold = bold;
            cloned.italic = italic;
            cloned.underline = undefined;
            cloned.align = align;
            cloned.leftMargin = leftMargin;
            cloned.rightMargin = rightMargin;
            cloned.indent = indent;
            cloned.leading = leading;
            cloned.tabStops = tabStops ? tabStops.concat() : null;
            return cloned;
        }

        private static var _defaultConfigForMarkers:CTextFormat = null;
        public static function GetDefaultConfigForMarkers():CTextFormat
        {
            if (_defaultConfigForMarkers == null)
            {
                _defaultConfigForMarkers = new CTextFormat();
                _defaultConfigForMarkers.enabled = true;
                _defaultConfigForMarkers.font = "$FieldFont";
                _defaultConfigForMarkers.size = 13;
                _defaultConfigForMarkers.color = "{{c:system}}";
                _defaultConfigForMarkers.align = TextFormatAlign.CENTER;
            }
            return _defaultConfigForMarkers;
        }

        private static var _defaultConfigForBattleLabels:CTextFormat = null;
        public static function GetDefaultConfigForBattleLabels():CTextFormat
        {
            if (_defaultConfigForBattleLabels == null)
            {
                _defaultConfigForBattleLabels = new CTextFormat();
                _defaultConfigForBattleLabels.enabled = true;
                _defaultConfigForBattleLabels.font = "$FieldFont";
                _defaultConfigForBattleLabels.size = 13;
                _defaultConfigForBattleLabels.color = 0xFFFFFF;
                _defaultConfigForBattleLabels.align = TextFormatAlign.LEFT;
            }
            return _defaultConfigForBattleLabels;
        }
    }
}
