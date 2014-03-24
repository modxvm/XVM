package net.wg.gui.components.tooltips.VO
{
   import net.wg.data.daapi.base.DAAPIDataClass;


   public class ModuleVO extends DAAPIDataClass
   {
          
      public function ModuleVO(param1:Object) {
         super(param1);
      }

      public var type:String = "";

      public var label:String = "";
   }

}