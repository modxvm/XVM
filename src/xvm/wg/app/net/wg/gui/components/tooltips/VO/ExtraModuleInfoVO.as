package net.wg.gui.components.tooltips.VO
{
   import net.wg.data.daapi.base.DAAPIDataClass;


   public class ExtraModuleInfoVO extends DAAPIDataClass
   {
          
      public function ExtraModuleInfoVO(param1:Object) {
         super(param1);
      }

      public var source:String = "";

      public var text:String = "";
   }

}