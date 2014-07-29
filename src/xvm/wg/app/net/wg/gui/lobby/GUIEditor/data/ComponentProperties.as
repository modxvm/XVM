package net.wg.gui.lobby.GUIEditor.data
{
    import flash.text.TextFieldAutoSize;
    
    public class ComponentProperties extends Object
    {
        
        public function ComponentProperties()
        {
            super();
        }
        
        private static var HTML_TEXT_HASH:Object = {"name":"htmlText",
        "type":PropTypes.STRING
    };
    
    private static var TEXT_HASH:Object = {"name":"text",
    "type":PropTypes.STRING
};

private static var SELECTED_TEXT_HASH:Object = {"name":"selectedText",
"type":PropTypes.STRING,
"canModify":false
};

private static var CLASS_HASH:Object = {"name":"class",
"type":PropTypes.STRING,
"canModify":false
};

private static var SUPER_CLASS_HASH:Object = {"name":"superClass",
"type":PropTypes.STRING,
"canModify":false
};

private static var CURRENT_LABEL_HASH:Object = {"name":"currentLabel",
"type":PropTypes.STRING,
"canModify":false
};

private static var CURRENT_FRAME_LABEL_HASH:Object = {"name":"currentFrameLabel",
"type":PropTypes.STRING,
"canModify":false
};

private static var TAB_ENABLED_HASH:Object = {"name":"tabEnabled",
"type":PropTypes.FLAG
};

private static var MOUSE_ENABLED_HASH:Object = {"name":"mouseEnabled",
"type":PropTypes.FLAG
};

private static var DOUBLE_CLICK_ENABLED_HASH:Object = {"name":"doubleClickEnabled",
"type":PropTypes.FLAG
};

private static var VISIBLE_HASH:Object = {"name":"visible",
"type":PropTypes.FLAG
};

private static var ENABLED_HASH:Object = {"name":"enabled",
"type":PropTypes.FLAG
};

private static var TAB_CHILDREN_HASH:Object = {"name":"tabChildren",
"type":PropTypes.FLAG
};

private static var MOUSE_CHILDREN_HASH:Object = {"name":"mouseChildren",
"type":PropTypes.FLAG
};

private static var USE_HAND_CURSOR_HASH:Object = {"name":"useHandCursor",
"type":PropTypes.FLAG
};

private static var MULTILINE_HASH:Object = {"name":"multiline",
"type":PropTypes.FLAG
};

private static var SELECTABLE_HASH:Object = {"name":"selectable",
"type":PropTypes.FLAG
};

private static var HAS_FOCUS_HASH:Object = {"name":"hasFocus",
"type":PropTypes.FLAG,
"canModify":false
};

private static var FOCUSED_HASH:Object = {"name":"focused",
"type":PropTypes.FLAG,
"canModify":false
};

private static var SELECTED_HASH:Object = {"name":"selected",
"type":PropTypes.FLAG,
"canModify":false
};

private static var BACKGROUND_HASH:Object = {"name":"background",
"type":PropTypes.FLAG
};

private static var BORDER_HASH:Object = {"name":"border",
"type":PropTypes.FLAG
};

private static var CONDENSE_WHITE_HASH:Object = {"name":"condenseWhite",
"type":PropTypes.FLAG
};

private static var MOUSE_WHEEL_ENABLED_HASH:Object = {"name":"mouseWheelEnabled",
"type":PropTypes.FLAG
};

private static var BUTTON_MODE_HASH:Object = {"name":"buttonMode",
"type":PropTypes.FLAG
};

private static var AUTOREPEAT_HASH:Object = {"name":"autoRepeat",
"type":PropTypes.FLAG
};

private static var X_HASH:Object = {"name":"x",
"type":PropTypes.NUMBER
};

private static var Y_HASH:Object = {"name":"y",
"type":PropTypes.NUMBER
};

private static var WIDTH_HASH:Object = {"name":"width",
"type":PropTypes.NUMBER
};

private static var HEIGHT_HASH:Object = {"name":"height",
"type":PropTypes.NUMBER
};

private static var ROTATION_HASH:Object = {"name":"rotation",
"type":PropTypes.NUMBER
};

private static var TEXT_WIDTH_HASH:Object = {"name":"textWidth",
"type":PropTypes.NUMBER,
"canModify":false
};

private static var TEXT_HEIGHT_HASH:Object = {"name":"textHeight",
"type":PropTypes.NUMBER,
"canModify":false
};

private static var TAB_INDEX_HASH:Object = {"name":"tabIndex",
"type":PropTypes.NUMBER,
"allowedValues":[0,65535]
};

private static var CURRENT_FRAME_HASH:Object = {"name":"currentFrame",
"type":PropTypes.NUMBER,
"canModify":false
};

private static var NUM_CHILDREN_HASH:Object = {"name":"numChildren",
"type":PropTypes.NUMBER,
"canModify":false
};

private static var FRAMES_LOADED_HASH:Object = {"name":"framesLoaded",
"type":PropTypes.NUMBER,
"canModify":false
};

private static var TOTAL_FRAMES_HASH:Object = {"name":"totalFrames",
"type":PropTypes.NUMBER,
"canModify":false
};

private static var NUMLINES_HASH:Object = {"name":"numLines",
"type":PropTypes.NUMBER,
"canModify":false
};

private static var SCROLL_H_HASH:Object = {"name":"scrollH",
"type":PropTypes.NUMBER
};

private static var SCROLL_V_HASH:Object = {"name":"scrollV",
"type":PropTypes.NUMBER
};

private static var MAX_SCROLL_H_HASH:Object = {"name":"maxScrollH",
"type":PropTypes.NUMBER,
"canModify":false
};

private static var MAX_SCROLL_V_HASH:Object = {"name":"maxScrollV",
"type":PropTypes.NUMBER,
"canModify":false
};

private static var LENGTH_HASH:Object = {"name":"length",
"type":PropTypes.NUMBER,
"canModify":false
};

private static var MAX_CHARS_HASH:Object = {"name":"maxChars",
"type":PropTypes.NUMBER
};

private static var SELECTION_BEGIN_INDEX_HASH:Object = {"name":"selectionBeginIndex",
"type":PropTypes.NUMBER
};

private static var SELECTION_END_INDEX_HASH:Object = {"name":"selectionEndIndex",
"type":PropTypes.NUMBER
};

private static var ROW_COUNT_HASH:Object = {"name":"rowCount",
"type":PropTypes.NUMBER
};

private static var ROW_HEIGHT_HASH:Object = {"name":"rowHeight",
"type":PropTypes.NUMBER
};

private static var ALPHA_HASH:Object = {"name":"alpha",
"type":PropTypes.CONSTRAINED_NUMBER,
"allowedValues":[0,1]
};

private static var SCALE_X_HASH:Object = {"name":"scaleX",
"type":PropTypes.CONSTRAINED_NUMBER,
"allowedValues":[0,1]
};

private static var SCALE_Y_HASH:Object = {"name":"scaleY",
"type":PropTypes.CONSTRAINED_NUMBER,
"allowedValues":[0,1]
};

private static var AUTOSIZE_HASH:Object = {"name":"autoSize",
"type":PropTypes.STATES,
"allowedValues":[TextFieldAutoSize.CENTER,TextFieldAutoSize.LEFT,TextFieldAutoSize.RIGHT,TextFieldAutoSize.NONE]
};

public static var HTML_TEXT:ComponentPropertyVO = new ComponentPropertyVO(HTML_TEXT_HASH);

public static var TEXT:ComponentPropertyVO = new ComponentPropertyVO(TEXT_HASH);

public static var SELECTED_TEXT:ComponentPropertyVO = new ComponentPropertyVO(SELECTED_TEXT_HASH);

public static var CLASS:ComponentPropertyVO = new ComponentPropertyVO(CLASS_HASH);

public static var SUPER_CLASS:ComponentPropertyVO = new ComponentPropertyVO(SUPER_CLASS_HASH);

public static var CURRENT_LABEL:ComponentPropertyVO = new ComponentPropertyVO(CURRENT_LABEL_HASH);

public static var CURRENT_FRAME_LABEL:ComponentPropertyVO = new ComponentPropertyVO(CURRENT_FRAME_LABEL_HASH);

public static var TAB_ENABLED:ComponentPropertyVO = new ComponentPropertyVO(TAB_ENABLED_HASH);

public static var MOUSE_ENABLED:ComponentPropertyVO = new ComponentPropertyVO(MOUSE_ENABLED_HASH);

public static var DOUBLE_CLICK_ENABLED:ComponentPropertyVO = new ComponentPropertyVO(DOUBLE_CLICK_ENABLED_HASH);

public static var VISIBLE:ComponentPropertyVO = new ComponentPropertyVO(VISIBLE_HASH);

public static var ENABLED:ComponentPropertyVO = new ComponentPropertyVO(ENABLED_HASH);

public static var TAB_CHILDREN:ComponentPropertyVO = new ComponentPropertyVO(TAB_CHILDREN_HASH);

public static var MOUSE_CHILDREN:ComponentPropertyVO = new ComponentPropertyVO(MOUSE_CHILDREN_HASH);

public static var USE_HAND_CURSOR:ComponentPropertyVO = new ComponentPropertyVO(USE_HAND_CURSOR_HASH);

public static var MULTILINE:ComponentPropertyVO = new ComponentPropertyVO(MULTILINE_HASH);

public static var SELECTABLE:ComponentPropertyVO = new ComponentPropertyVO(SELECTABLE_HASH);

public static var HAS_FOCUS:ComponentPropertyVO = new ComponentPropertyVO(HAS_FOCUS_HASH);

public static var FOCUSED:ComponentPropertyVO = new ComponentPropertyVO(FOCUSED_HASH);

public static var SELECTED:ComponentPropertyVO = new ComponentPropertyVO(SELECTED_HASH);

public static var BACKGROUND:ComponentPropertyVO = new ComponentPropertyVO(BACKGROUND_HASH);

public static var BORDER:ComponentPropertyVO = new ComponentPropertyVO(BORDER_HASH);

public static var CONDENSE_WHITE:ComponentPropertyVO = new ComponentPropertyVO(CONDENSE_WHITE_HASH);

public static var MOUSE_WHEEL_ENABLED:ComponentPropertyVO = new ComponentPropertyVO(MOUSE_WHEEL_ENABLED_HASH);

public static var BUTTON_MODE:ComponentPropertyVO = new ComponentPropertyVO(BUTTON_MODE_HASH);

public static var AUTOREPEAT:ComponentPropertyVO = new ComponentPropertyVO(AUTOREPEAT_HASH);

public static var X:ComponentPropertyVO = new ComponentPropertyVO(X_HASH);

public static var Y:ComponentPropertyVO = new ComponentPropertyVO(Y_HASH);

public static var WIDTH:ComponentPropertyVO = new ComponentPropertyVO(WIDTH_HASH);

public static var HEIGHT:ComponentPropertyVO = new ComponentPropertyVO(HEIGHT_HASH);

public static var ROTATION:ComponentPropertyVO = new ComponentPropertyVO(ROTATION_HASH);

public static var TEXT_WIDTH:ComponentPropertyVO = new ComponentPropertyVO(TEXT_WIDTH_HASH);

public static var TEXT_HEIGHT:ComponentPropertyVO = new ComponentPropertyVO(TEXT_HEIGHT_HASH);

public static var TAB_INDEX:ComponentPropertyVO = new ComponentPropertyVO(TAB_INDEX_HASH);

public static var CURRENT_FRAME:ComponentPropertyVO = new ComponentPropertyVO(CURRENT_FRAME_HASH);

public static var NUM_CHILDREN:ComponentPropertyVO = new ComponentPropertyVO(NUM_CHILDREN_HASH);

public static var FRAMES_LOADED:ComponentPropertyVO = new ComponentPropertyVO(FRAMES_LOADED_HASH);

public static var TOTAL_FRAMES:ComponentPropertyVO = new ComponentPropertyVO(TOTAL_FRAMES_HASH);

public static var NUMLINES:ComponentPropertyVO = new ComponentPropertyVO(NUMLINES_HASH);

public static var SCROLL_H:ComponentPropertyVO = new ComponentPropertyVO(SCROLL_H_HASH);

public static var SCROLL_V:ComponentPropertyVO = new ComponentPropertyVO(SCROLL_V_HASH);

public static var MAX_SCROLL_H:ComponentPropertyVO = new ComponentPropertyVO(MAX_SCROLL_H_HASH);

public static var MAX_SCROLL_V:ComponentPropertyVO = new ComponentPropertyVO(MAX_SCROLL_V_HASH);

public static var LENGTH:ComponentPropertyVO = new ComponentPropertyVO(LENGTH_HASH);

public static var MAX_CHARS:ComponentPropertyVO = new ComponentPropertyVO(MAX_CHARS_HASH);

public static var SELECTION_BEGIN_INDEX:ComponentPropertyVO = new ComponentPropertyVO(SELECTION_BEGIN_INDEX_HASH);

public static var SELECTION_END_INDEX:ComponentPropertyVO = new ComponentPropertyVO(SELECTION_END_INDEX_HASH);

public static var ALPHA:ComponentPropertyVO = new ComponentPropertyVO(ALPHA_HASH);

public static var SCALE_X:ComponentPropertyVO = new ComponentPropertyVO(SCALE_X_HASH);

public static var SCALE_Y:ComponentPropertyVO = new ComponentPropertyVO(SCALE_Y_HASH);

public static var AUTOSIZE:ComponentPropertyVO = new ComponentPropertyVO(AUTOSIZE_HASH);

public static var ROW_COUNT:ComponentPropertyVO = new ComponentPropertyVO(ROW_COUNT_HASH);

public static var ROW_HEIGHT:ComponentPropertyVO = new ComponentPropertyVO(ROW_HEIGHT_HASH);
}
}
