package net.wg.gui.notification
{
   import net.wg.data.daapi.base.DAAPIDataClass;


   public class NotificationDialogInitInfoVO extends DAAPIDataClass
   {
          
      public function NotificationDialogInitInfoVO(param1:Object) {
         super(param1);
      }

      public var title:String = "";

      public var closeBtnTitle:String = "";
   }

}