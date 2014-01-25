package net.wg.gui.crewOperations
{
   import net.wg.data.daapi.base.DAAPIDataClass;


   public class CrewOperationsInitVO extends DAAPIDataClass
   {
          
      public function CrewOperationsInitVO(param1:Object) {
         super(param1);
      }

      public var operationsArray:Array;

      private var _castedOperations:Array;

      public function get castedOperations() : Array {
         return this._castedOperations;
      }

      override protected function onDataWrite(param1:String, param2:Object) : Boolean {
         var _loc3_:* = 0;
         var _loc4_:* = 0;
         if(param1 == "operationsArray")
         {
            this._castedOperations = [];
            _loc3_ = param2?param2.length:0;
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               this._castedOperations.push(new CrewOperationInfoVO(param2[_loc4_]));
               _loc4_++;
            }
            return false;
         }
         return this.hasOwnProperty(param1);
      }
   }

}