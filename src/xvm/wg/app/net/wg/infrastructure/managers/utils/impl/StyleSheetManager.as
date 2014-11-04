package net.wg.infrastructure.managers.utils.impl
{
    import net.wg.utils.IStyleSheetManager;
    import flash.text.TextField;
    import flash.text.StyleSheet;
    
    public class StyleSheetManager extends Object implements IStyleSheetManager
    {
        
        public function StyleSheetManager()
        {
            super();
        }
        
        public static var LINK_COLOR_NORMAL:String = "#C9C9B6";
        
        public static var LINK_COLOR_HOVER:String = "#EE7000";
        
        public static var LINK_COLOR_PRESS:String = "#EE7000";
        
        public static var LINK_COLOR_VISITED:String = "#C9C9B6";
        
        public function setLinkStyle(param1:TextField) : void
        {
            var _loc2_:StyleSheet = param1.styleSheet;
            if(_loc2_ == null)
            {
                _loc2_ = new StyleSheet();
            }
            _loc2_.setStyle("a:link",{"color":LINK_COLOR_NORMAL,
            "textDecoration":"underline"
        });
        _loc2_.setStyle("a:hover",{"color":LINK_COLOR_HOVER,
        "textDecoration":"underline"
    });
    _loc2_.setStyle("a:active",{"color":LINK_COLOR_PRESS,
    "textDecoration":"underline"
});
_loc2_.setStyle("a:visited",{"color":LINK_COLOR_VISITED,
"textDecoration":"underline"
});
_loc2_.setStyle("forceFocused",{"color":LINK_COLOR_HOVER});
param1.styleSheet = _loc2_;
}

public function setForceFocusedStyle(param1:String) : String
{
return "<forceFocused>" + param1 + "</forceFocused>";
}
}
}
