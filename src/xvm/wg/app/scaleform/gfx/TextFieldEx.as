package scaleform.gfx
{
    import flash.text.TextField;
    import flash.display.BitmapData;
    
    public final class TextFieldEx extends InteractiveObjectEx
    {
        
        public function TextFieldEx() {
            super();
        }
        
        public static var VALIGN_NONE:String = "none";
        
        public static var VALIGN_TOP:String = "top";
        
        public static var VALIGN_CENTER:String = "center";
        
        public static var VALIGN_BOTTOM:String = "bottom";
        
        public static var TEXTAUTOSZ_NONE:String = "none";
        
        public static var TEXTAUTOSZ_SHRINK:String = "shrink";
        
        public static var TEXTAUTOSZ_FIT:String = "fit";
        
        public static var VAUTOSIZE_NONE:String = "none";
        
        public static var VAUTOSIZE_TOP:String = "top";
        
        public static var VAUTOSIZE_CENTER:String = "center";
        
        public static var VAUTOSIZE_BOTTOM:String = "bottom";
        
        public static function appendHtml(param1:TextField, param2:String) : void {
        }
        
        public static function setIMEEnabled(param1:TextField, param2:Boolean) : void {
        }
        
        public static function setVerticalAlign(param1:TextField, param2:String) : void {
        }
        
        public static function getVerticalAlign(param1:TextField) : String {
            return "none";
        }
        
        public static function setVerticalAutoSize(param1:TextField, param2:String) : void {
        }
        
        public static function getVerticalAutoSize(param1:TextField) : String {
            return "none";
        }
        
        public static function setTextAutoSize(param1:TextField, param2:String) : void {
        }
        
        public static function getTextAutoSize(param1:TextField) : String {
            return "none";
        }
        
        public static function setImageSubstitutions(param1:TextField, param2:Object) : void {
        }
        
        public static function updateImageSubstitution(param1:TextField, param2:String, param3:BitmapData) : void {
        }
        
        public static function setNoTranslate(param1:TextField, param2:Boolean) : void {
        }
        
        public static function getNoTranslate(param1:TextField) : Boolean {
            return false;
        }
        
        public static function setBidirectionalTextEnabled(param1:TextField, param2:Boolean) : void {
        }
        
        public static function getBidirectionalTextEnabled(param1:TextField) : Boolean {
            return false;
        }
        
        public static function setSelectionTextColor(param1:TextField, param2:uint) : void {
        }
        
        public static function getSelectionTextColor(param1:TextField) : uint {
            return 4.294967295E9;
        }
        
        public static function setSelectionBkgColor(param1:TextField, param2:uint) : void {
        }
        
        public static function getSelectionBkgColor(param1:TextField) : uint {
            return 4.27819008E9;
        }
        
        public static function setInactiveSelectionTextColor(param1:TextField, param2:uint) : void {
        }
        
        public static function getInactiveSelectionTextColor(param1:TextField) : uint {
            return 4.294967295E9;
        }
        
        public static function setInactiveSelectionBkgColor(param1:TextField, param2:uint) : void {
        }
        
        public static function getInactiveSelectionBkgColor(param1:TextField) : uint {
            return 4.27819008E9;
        }
    }
}
