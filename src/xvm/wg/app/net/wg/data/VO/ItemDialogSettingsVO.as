package net.wg.data.VO
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class ItemDialogSettingsVO extends DAAPIDataClass
   {
      
      public function ItemDialogSettingsVO(param1:Object) {
         super(param1);
      }
      
      public var title:String = "";
      
      public var submitBtnLabel:String = "";
      
      public var cancelBtnLabel:String = "";
   }
}
