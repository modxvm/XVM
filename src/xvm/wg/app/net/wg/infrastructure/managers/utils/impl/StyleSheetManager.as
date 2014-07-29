package net.wg.infrastructure.managers.utils.impl
{
    import net.wg.utils.IStyleSheetManager;
    import flash.text.StyleSheet;
    import flashx.textLayout.formats.TextDecoration;
    
    public class StyleSheetManager extends Object implements IStyleSheetManager
    {
        
        public function StyleSheetManager()
        {
            super();
        }
        
        public function getRedHyperlinkCSS() : StyleSheet
        {
            var _loc1_:StyleSheet = new StyleSheet();
            _loc1_.setStyle("a:link",{"color":"#969687",
            "textDecoration":TextDecoration.UNDERLINE
        });
        _loc1_.setStyle("a:hover",{"color":"#FF0000",
        "textDecoration":TextDecoration.UNDERLINE
    });
    _loc1_.setStyle("a:active",{"color":"#FF0000",
    "textDecoration":TextDecoration.UNDERLINE
});
return _loc1_;
}

public function getYellowHyperlinkCSS() : StyleSheet
{
var _loc1_:StyleSheet = new StyleSheet();
_loc1_.setStyle("a:link",{"color":"#f25322",
"textDecoration":TextDecoration.UNDERLINE
});
_loc1_.setStyle("a:hover",{"color":"#ff7432",
"textDecoration":TextDecoration.UNDERLINE
});
_loc1_.setStyle("a:active",{"color":"#ff7432",
"textDecoration":TextDecoration.UNDERLINE
});
return _loc1_;
}
}
}
