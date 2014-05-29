package net.wg.data.constants
{
   import __AS3__.vec.Vector;


   public class ContainerTypes extends Object
   {
          
      public function ContainerTypes() {
         super();
      }

      public static const VIEW:String = "view";

      public static const LOBBY_SUB_VIEW:String = "lobbySubView";

      public static const WINDOW:String = "window";

      public static const BROWSER:String = "browser";

      public static const TOP_WINDOW:String = "topWindow";

      public static const CURSOR:String = "cursor";

      public static const WAITING:String = "waiting";

      public static const SERVICE_LAYOUT:String = "serviceLayout";

      public static const CTNR_ORDER:Vector.<String> = Vector.<String>([WAITING,SERVICE_LAYOUT,TOP_WINDOW,BROWSER,WINDOW,LOBBY_SUB_VIEW,VIEW]);
   }

}