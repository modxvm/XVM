package net.wg.gui.login.impl
{
   import flash.display.InteractiveObject;


   final class LoginUtils extends Object
   {
          
      function LoginUtils() {
         super();
      }

      private static var ms_instance:LoginUtils = null;

      public static function get instance() : LoginUtils {
         if(ms_instance == null)
         {
            ms_instance = new LoginUtils();
         }
         return ms_instance;
      }

      public function initTabIndex(param1:Array) : void {
         var _loc2_:Number = 0;
         while(_loc2_ < param1.length)
         {
            InteractiveObject(param1[_loc2_]).tabIndex = _loc2_ + 1;
            _loc2_++;
         }
      }
   }

}