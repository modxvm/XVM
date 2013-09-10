package scaleform.gfx 
{
    import flash.events.*;
    
    public final class IMEEventEx extends flash.events.Event
    {
        public function IMEEventEx(arg1:String)
        {
            super(arg1);
            return;
        }

        public static const SET_CURRENT_INPUT_LANGUAGE:String="SetCurrentInputLanguage";

        public static const SET_SUPPORTED_LANGUAGES:String="SetSupportedLanguages";

        public static const SET_SUPPORTED_IMENAMES:String="SetSupportedIMENames";

        public static const SET_IMENAME:String="SetIMEName";

        public static const SET_CURRENT_LANGUAGE:String="SetCurrentLanguage";

        public static const REMOVE_STATUS_WINDOW:String="RemoveStatusWindow";

        public static const DISPLAY_STATUS_WINDOW:String="DisplayStatusWindow";

        public static const SET_CONVERSION_STATUS:String="SetConversionStatus";

        public var message:String;
    }
}
