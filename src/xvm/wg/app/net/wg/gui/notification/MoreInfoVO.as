package net.wg.gui.notification
{
   import net.wg.data.daapi.base.DAAPIDataClass;


   public class MoreInfoVO extends DAAPIDataClass
   {
          
      public function MoreInfoVO(param1:Object) {
         super(param1);
      }

      public var command:String = "";

      public var enabled:Boolean;

      public var param:Object;
   }

}