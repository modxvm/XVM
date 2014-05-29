package net.wg.gui.components.tooltips.VO
{
   import net.wg.data.daapi.base.DAAPIDataClass;


   public class ClanInfoVO extends DAAPIDataClass
   {
          
      public function ClanInfoVO(param1:Object) {
         super(param1);
      }

      public var headerText:String = "";

      public var infoText:String = "";

      public var fullClanName:String = "";

      public var fortCreationDate:String = "";
   }

}