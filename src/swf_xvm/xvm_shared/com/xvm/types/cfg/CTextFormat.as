/**
 * XVM: eXtended Visualization Mod for World of Tanks.
 * https://modxvm.com/
 */
package com.xvm.types.cfg
{
    import com.xfw.*;
    import flash.text.*;
    import scaleform.gfx.*;

    public dynamic class CTextFormat implements ICloneable
    {
        public var align:String;
        public var bold:*;
        public var color:*;
        public var enabled:*;
        public var font:String;
        public var indent:*;
        public var italic:*;
        public var leading:*;
        public var leftMargin:*;
        public var rightMargin:*;
        public var size:*;
        public var tabStops:Array;
        public var underline:*;
        public var valign:String;

        public function clone():*
        {
            var cloned:CTextFormat = new CTextFormat();
            cloned.align = align;
            cloned.bold = bold;
            cloned.color = color;
            cloned.enabled = enabled;
            cloned.font = font;
            cloned.indent = indent;
            cloned.italic = italic;
            cloned.leading = leading;
            cloned.leftMargin = leftMargin;
            cloned.rightMargin = rightMargin;
            cloned.size = size;
            cloned.tabStops = tabStops ? tabStops.concat() : null;
            cloned.underline = undefined;
            cloned.valign = valign;
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
