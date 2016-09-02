/**
 * XVM Config
 * @author Maxim Schedriviy <max(at)modxvm.com>
 */
package com.xvm.types.cfg
{
    import com.xfw.*;
    import flash.text.*;
    import scaleform.gfx.*;

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
        public var valign:String;
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
            cloned.valign = valign;
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
                _defaultConfigForMarkers.valign = TextFieldEx.VALIGN_NONE;
            }
            return _defaultConfigForMarkers;
        }

        private static var _defaultConfigForBattle:Object = {};
        public static function GetDefaultConfigForBattle(align:String = TextFormatAlign.LEFT):CTextFormat
        {
            var cfg:CTextFormat = _defaultConfigForBattle[align];
            if (cfg == null)
            {
                cfg = new CTextFormat();
                cfg.enabled = true;
                cfg.font = "$FieldFont";
                cfg.size = 13;
                cfg.color = 0xFFFFFF;
                cfg.align = align;
                cfg.valign = TextFieldEx.VALIGN_NONE;
                _defaultConfigForBattle[align] = cfg;
            }
            return cfg;
        }

        private static var _defaultConfigForLobby:CTextFormat = null;
        public static function GetDefaultConfigForLobby():CTextFormat
        {
            if (_defaultConfigForLobby == null)
            {
                _defaultConfigForLobby = new CTextFormat();
                _defaultConfigForLobby.enabled = true;
                _defaultConfigForLobby.font = "$FieldFont";
                _defaultConfigForLobby.size = 13;
                _defaultConfigForLobby.color = 0xFFFFFF;
                _defaultConfigForLobby.align = TextFormatAlign.LEFT;
                _defaultConfigForLobby.valign = TextFieldEx.VALIGN_NONE;
            }
            return _defaultConfigForLobby;
        }
    }
}
