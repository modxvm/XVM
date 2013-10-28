package net.wg.gui.lobby.confirmModuleWindow
{
   import net.wg.data.daapi.base.DAAPIDataClass;


   public class ConfirmModuleSettingsVO extends DAAPIDataClass
   {
          
      public function ConfirmModuleSettingsVO(param1:Object) {
         super(param1);
      }

      public var title:String = "";

      public var submitBtnLabel:String = "";

      public var cancelBtnLabel:String = "";
   }

}