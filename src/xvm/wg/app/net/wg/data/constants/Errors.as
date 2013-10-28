package net.wg.data.constants
{


   public class Errors extends Object
   {
          
      public function Errors() {
         super();
      }

      public static const MUST_NULL:String = " must be null.";

      public static const MUST_REGISTER:String = " component must registered before unregistering.";

      public static const ALREADY_REGISTERED:String = " component already registered.";

      public static const WASNT_UNREGISTERED:String = "object was not unregistered until destroying: ";

      public static const CANT_NULL:String = " can`t be null.";

      public static const CANT_NAN:String = " can`t be NaN.";

      public static const CANT_EMPTY:String = " can`t emty.";

      public static const WASNT_FOUND:String = " was not found.";

      public static const BAD_LINKAGE:String = "Error extracting object with linkage: ";

      public static const ABSTRACT_INVOKE:String = " abstract method can`t be invoked.";

      public static const HDLR_CORRUPT_INVOKE:String = "handler invoking after manager destruction";
   }

}