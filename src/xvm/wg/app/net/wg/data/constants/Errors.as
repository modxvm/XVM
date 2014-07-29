package net.wg.data.constants
{
    public class Errors extends Object
    {
        
        public function Errors()
        {
            super();
        }
        
        public static var MUST_NULL:String = " must be null.";
        
        public static var MUST_REGISTER:String = " component must registered before unregistering.";
        
        public static var ALREADY_REGISTERED:String = " component already registered.";
        
        public static var WASNT_UNREGISTERED:String = "object was not unregistered until destroying: ";
        
        public static var CANT_NULL:String = " can`t be null.";
        
        public static var CANT_NAN:String = " can`t be NaN.";
        
        public static var CANT_EMPTY:String = " can`t empty.";
        
        public static var WASNT_FOUND:String = " was not found.";
        
        public static var BAD_LINKAGE:String = "Error extracting object with linkage: ";
        
        public static var ABSTRACT_INVOKE:String = " abstract method can`t be invoked.";
        
        public static var MTHD_CORRUPT_INVOKE:String = "method invoking after object destruction";
        
        public static var INVALID_FOCUS_USING:String = "Unsafe using App.utils.focusHandler.setFocus. \n\"" + "It can damage the focus system functionality. Please, use in view, as like as:\n" + "\tthis.setFocus(form.header.closeButton). ";
    }
}
