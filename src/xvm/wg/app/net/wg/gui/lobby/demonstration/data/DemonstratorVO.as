package net.wg.gui.lobby.demonstration.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import scaleform.clik.data.DataProvider;


   public class DemonstratorVO extends DAAPIDataClass
   {
          
      public function DemonstratorVO(param1:Object) {
         super(param1);
      }

      private var _standard:DataProvider;

      private var _assault:DataProvider;

      private var _encounter:DataProvider;

      private var _nations:DataProvider;

      public function get standard() : DataProvider {
         return this._standard;
      }

      public function set standard(param1:DataProvider) : void {
         this._standard = param1;
      }

      public function get assault() : DataProvider {
         return this._assault;
      }

      public function set assault(param1:DataProvider) : void {
         this._assault = param1;
      }

      public function get encounter() : DataProvider {
         return this._encounter;
      }

      public function set encounter(param1:DataProvider) : void {
         this._encounter = param1;
      }

      public function get nations() : DataProvider {
         return this._nations;
      }

      public function set nations(param1:DataProvider) : void {
         this._nations = param1;
      }

      override protected function onDispose() : void {
         super.onDispose();
         this._standard.cleanUp();
         this._assault.cleanUp();
         this._encounter.cleanUp();
         this._standard = null;
         this._assault = null;
         this._encounter = null;
      }

      override protected function onDataWrite(param1:String, param2:Object) : Boolean {
         switch(param1)
         {
            case "standard":
            case "assault":
            case "encounter":
            case "nations":
               this[param1] = this.convertToDataProvider(param2 as Array);
               return false;
            default:
               return true;
         }
      }

      private function convertToDataProvider(param1:Array) : DataProvider {
         var _loc3_:Object = null;
         var _loc2_:DataProvider = new DataProvider();
         for each (_loc3_ in param1)
         {
            _loc2_.push(new MapItemVO(_loc3_));
         }
         return _loc2_;
      }
   }

}