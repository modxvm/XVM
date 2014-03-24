package net.wg.gui.components.tooltips.VO
{
   import net.wg.data.daapi.base.DAAPIDataClass;


   public class HistoricalModulesVO extends DAAPIDataClass
   {
          
      public function HistoricalModulesVO(param1:Object) {
         super(param1);
      }

      private static const FIELD_MODULES:String = "modules";

      public var tankName:String = "";

      public var modules:Array = null;

      override protected function onDataWrite(param1:String, param2:Object) : Boolean {
         var _loc3_:Array = null;
         var _loc4_:Object = null;
         var _loc5_:ModuleVO = null;
         if(param1 == FIELD_MODULES)
         {
            this.modules = [];
            _loc3_ = param2 as Array;
            for each (_loc4_ in _loc3_)
            {
               _loc5_ = new ModuleVO(_loc4_);
               this.modules.push(_loc5_);
            }
            return false;
         }
         return true;
      }

      override protected function onDispose() : void {
         this.disposeModules();
         super.onDispose();
      }

      private function disposeModules() : void {
         var _loc1_:ModuleVO = null;
         if(this.modules)
         {
            for each (_loc1_ in this.modules)
            {
               if(_loc1_)
               {
                  _loc1_.dispose();
               }
            }
            this.modules.splice(0);
            this.modules = null;
         }
      }
   }

}