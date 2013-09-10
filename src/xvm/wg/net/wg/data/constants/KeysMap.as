package net.wg.data.constants 
{
    import flash.ui.*;
    import scaleform.gfx.*;
    
    public class KeysMap extends Object
    {
        public function KeysMap()
        {
            super();
            return;
        }

        public static function get mapping():Object
        {
            if (!inited) 
                init();
            return __mapping;
        }

        internal static function init():void
        {
            inited = true;
            __mapping = new Object();
            __mapping[KEY_NONE] = {"command":"NONE", "to_show":""};
            __mapping[scaleform.gfx.MouseEventEx.LEFT_BUTTON] = {"command":"LEFTMOUSE", "to_show":"#controls:mouse/key_left"};
            __mapping[scaleform.gfx.MouseEventEx.MIDDLE_BUTTON] = {"command":"MOUSE2", "to_show":"#controls:mouse/key_middle"};
            __mapping[scaleform.gfx.MouseEventEx.RIGHT_BUTTON] = {"command":"MOUSE1", "to_show":"#controls:mouse/key_right"};
            __mapping[4] = {"command":"MOUSE4", "to_show":"#controls:mouse/key_4"};
            __mapping[5] = {"command":"MOUSE5", "to_show":"#controls:mouse/key_5"};
            __mapping[6] = {"command":"MOUSE6", "to_show":"#controls:mouse/key_6"};
            __mapping[7] = {"command":"MOUSE7", "to_show":"#controls:mouse/key_7"};
            __mapping[flash.ui.Keyboard.ESCAPE] = {"command":"ESCAPE", "to_show":"#controls:keyboard/key_escape"};
            __mapping[flash.ui.Keyboard.ALTERNATE] = {"command":"LALT", "to_show":"#controls:keyboard/key_left_alt"};
            __mapping[flash.ui.Keyboard.ENTER] = {"command":"ENTER", "to_show":"Enter"};
            __mapping[165] = {"command":"RALT", "to_show":"#controls:keyboard/key_right_alt"};
            __mapping[flash.ui.Keyboard.TAB] = {"command":"TAB", "to_show":"#controls:keyboard/key_tab"};
            __mapping[flash.ui.Keyboard.CAPS_LOCK] = {"command":"CAPSLOCK", "to_show":"#controls:keyboard/key_capslock"};
            __mapping[flash.ui.Keyboard.SHIFT] = {"command":"LSHIFT", "to_show":"#controls:keyboard/key_left_shift"};
            __mapping[161] = {"command":"RSHIFT", "to_show":"#controls:keyboard/key_right_shift"};
            __mapping[flash.ui.Keyboard.BACKSPACE] = {"command":"BACKSPACE", "to_show":"#controls:keyboard/key_bacjspace"};
            __mapping[flash.ui.Keyboard.SPACE] = {"command":"SPACE", "to_show":"#controls:keyboard/key_space"};
            __mapping[flash.ui.Keyboard.CONTROL] = {"command":"LCONTROL", "to_show":"#controls:keyboard/key_left_ctrl"};
            __mapping[163] = {"command":"RCONTROL", "to_show":"#controls:keyboard/key_right_ctrl"};
            __mapping[flash.ui.Keyboard.UP] = {"command":"UPARROW", "to_show":"#controls:keyboard/key_uparrow"};
            __mapping[flash.ui.Keyboard.DOWN] = {"command":"DOWNARROW", "to_show":"#controls:keyboard/key_downarrow"};
            __mapping[flash.ui.Keyboard.RIGHT] = {"command":"RIGHTARROW", "to_show":"#controls:keyboard/key_rightarrow"};
            __mapping[flash.ui.Keyboard.LEFT] = {"command":"LEFTARROW", "to_show":"#controls:keyboard/key_leftarrow"};
            __mapping[flash.ui.Keyboard.END] = {"command":"END", "to_show":"#controls:keyboard/key_end"};
            __mapping[flash.ui.Keyboard.HOME] = {"command":"HOME", "to_show":"#controls:keyboard/key_home"};
            __mapping[flash.ui.Keyboard.DELETE] = {"command":"DELETE", "to_show":"#controls:keyboard/key_delete"};
            __mapping[flash.ui.Keyboard.INSERT] = {"command":"INSERT", "to_show":"#controls:keyboard/key_insert"};
            __mapping[flash.ui.Keyboard.PAGE_UP] = {"command":"PGUP", "to_show":"#controls:keyboard/key_pgup"};
            __mapping[flash.ui.Keyboard.PAGE_DOWN] = {"command":"PGDN", "to_show":"#controls:keyboard/key_pgdn"};
            __mapping[flash.ui.Keyboard.NUMPAD_0] = {"command":"NUMPAD0", "to_show":"Numpad 0"};
            __mapping[flash.ui.Keyboard.NUMPAD_1] = {"command":"NUMPAD1", "to_show":"Numpad 1"};
            __mapping[flash.ui.Keyboard.NUMPAD_2] = {"command":"NUMPAD2", "to_show":"Numpad 2"};
            __mapping[flash.ui.Keyboard.NUMPAD_3] = {"command":"NUMPAD3", "to_show":"Numpad 3"};
            __mapping[flash.ui.Keyboard.NUMPAD_4] = {"command":"NUMPAD4", "to_show":"Numpad 4"};
            __mapping[flash.ui.Keyboard.NUMPAD_5] = {"command":"NUMPAD5", "to_show":"Numpad 5"};
            __mapping[flash.ui.Keyboard.NUMPAD_6] = {"command":"NUMPAD6", "to_show":"Numpad 6"};
            __mapping[flash.ui.Keyboard.NUMPAD_7] = {"command":"NUMPAD7", "to_show":"Numpad 7"};
            __mapping[flash.ui.Keyboard.NUMPAD_8] = {"command":"NUMPAD8", "to_show":"Numpad 8"};
            __mapping[flash.ui.Keyboard.NUMPAD_9] = {"command":"NUMPAD9", "to_show":"Numpad 9"};
            __mapping[flash.ui.Keyboard.NUMPAD_DIVIDE] = {"command":"NUMPADSLASH", "to_show":"Numpad divide"};
            __mapping[flash.ui.Keyboard.NUMPAD_SUBTRACT] = {"command":"NUMPADMINUS", "to_show":"Numpad minus"};
            __mapping[flash.ui.Keyboard.NUMPAD_MULTIPLY] = {"command":"NUMPADSTAR", "to_show":"Numpad star"};
            __mapping[flash.ui.Keyboard.NUMPAD_ENTER] = {"command":"NUMPADENTER", "to_show":"Numpad enter"};
            __mapping[flash.ui.Keyboard.NUMPAD_DECIMAL] = {"command":"NUMPADPERIOD", "to_show":"Numpad comma"};
            __mapping[flash.ui.Keyboard.NUMPAD_ADD] = {"command":"ADD", "to_show":"Numpad add"};
            __mapping[flash.ui.Keyboard.F1] = {"command":"F1", "to_show":"F1"};
            __mapping[flash.ui.Keyboard.F2] = {"command":"F2", "to_show":"F2"};
            __mapping[flash.ui.Keyboard.F3] = {"command":"F3", "to_show":"F3"};
            __mapping[flash.ui.Keyboard.F4] = {"command":"F4", "to_show":"F4"};
            __mapping[flash.ui.Keyboard.F5] = {"command":"F5", "to_show":"F5"};
            __mapping[flash.ui.Keyboard.F6] = {"command":"F6", "to_show":"F6"};
            __mapping[flash.ui.Keyboard.F7] = {"command":"F7", "to_show":"F7"};
            __mapping[flash.ui.Keyboard.F8] = {"command":"F8", "to_show":"F8"};
            __mapping[flash.ui.Keyboard.F9] = {"command":"F9", "to_show":"F9"};
            __mapping[flash.ui.Keyboard.F10] = {"command":"F10", "to_show":"F10"};
            __mapping[flash.ui.Keyboard.F11] = {"command":"F11", "to_show":"F11"};
            __mapping[flash.ui.Keyboard.F12] = {"command":"F12", "to_show":"F12"};
            __mapping[flash.ui.Keyboard.F13] = {"command":"F13", "to_show":"F13"};
            __mapping[flash.ui.Keyboard.F14] = {"command":"F14", "to_show":"F14"};
            __mapping[flash.ui.Keyboard.F15] = {"command":"F15", "to_show":"F15"};
            __mapping[flash.ui.Keyboard.LEFTBRACKET] = {"command":"LBRACKET", "to_show":"["};
            __mapping[flash.ui.Keyboard.RIGHTBRACKET] = {"command":"RBRACKET", "to_show":"]"};
            __mapping[flash.ui.Keyboard.SEMICOLON] = {"command":"SEMICOLON", "to_show":";"};
            __mapping[flash.ui.Keyboard.QUOTE] = {"command":"APOSTROPHE", "to_show":"\'"};
            __mapping[flash.ui.Keyboard.BACKSLASH] = {"command":"BACKSLASH", "to_show":"\\"};
            __mapping[flash.ui.Keyboard.SLASH] = {"command":"SLASH", "to_show":"/"};
            __mapping[flash.ui.Keyboard.PERIOD] = {"command":"STOP", "to_show":"."};
            __mapping[flash.ui.Keyboard.COMMA] = {"command":"COMMA", "to_show":","};
            __mapping[flash.ui.Keyboard.MINUS] = {"command":"MINUS", "to_show":"-"};
            __mapping[flash.ui.Keyboard.EQUAL] = {"command":"EQUALS", "to_show":"="};
            return;
        }

        
        {
            inited = false;
            KEY_NONE = 666;
        }

        internal static var __mapping:Object;

        internal static var inited:Boolean=false;

        public static var KEY_NONE:Number=666;
    }
}
