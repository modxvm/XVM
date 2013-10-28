package net.wg.gui.lobby.store
{


   public final class STORE_STATUS_COLOR extends Object
   {
          
      public function STORE_STATUS_COLOR() {
         super();
      }

      public static const CRITICAL:uint = 16711680;

      public static const WARNING:uint = 13814699;

      public static const INFO:uint = 4945434;

      public static function getColor(param1:String) : uint {
         var _loc2_:Object =
            {
               "critical":CRITICAL,
               "warning":WARNING,
               "info":INFO
            }
         ;
         if(App.instance)
         {
            App.utils.asserter.assert(_loc2_.hasOwnProperty(param1),"unknown status for color: " + param1);
            return _loc2_[param1];
         }
         DebugUtils.LOG_WARNING("App is not available. 0x0 color returned.");
         return 0;
      }
   }

}