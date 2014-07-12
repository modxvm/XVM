package net.wg.gui.lobby.settings
{
   public class SettingsChangesMap extends Object
   {
      
      public function SettingsChangesMap() {
         super();
         this.clear();
      }
      
      private var _data:Object;
      
      private var _len:uint;
      
      public function clear() : void {
         this.clearObject(this._data);
         this._data = new Object();
         this._len = 0;
      }
      
      private function clearObject(param1:Object) : void {
         var _loc2_:String = null;
         if(param1)
         {
            for(_loc2_ in param1)
            {
               if(!(param1[_loc2_] is String) && !(param1[_loc2_] is Number) && !(param1[_loc2_] is Boolean))
               {
                  delete this._data[_loc2_];
               }
               else
               {
                  this.clearObject(this._data[_loc2_]);
               }
            }
         }
      }
      
      public function tryAddChanges(param1:String, param2:*) : void {
         this.addChanges(this._data,param1,param2);
      }
      
      private function addChanges(param1:Object, param2:String, param3:*) : void {
         var _loc4_:String = null;
         if(!param1.hasOwnProperty(param2))
         {
            this._len++;
            param1[param2] = param3;
         }
         else if(!(param3 is String) && !(param3 is Number) && !(param3 is Boolean) && !(param3 is Array))
         {
            for(_loc4_ in param3)
            {
               this.addChanges(param1[param2],_loc4_,param3[_loc4_]);
            }
         }
         else
         {
            param1[param2] = param3;
         }
         
      }
      
      public function tryCutChanges(param1:String, param2:*) : void {
         this.cutChanges(this._data,param1,param2);
      }
      
      private function cutChanges(param1:Object, param2:String, param3:*) : Boolean {
         var _loc4_:String = null;
         var _loc5_:* = false;
         var _loc6_:uint = 0;
         var _loc7_:String = null;
         if(param1.hasOwnProperty(param2))
         {
            if(!(param3 is String) && !(param3 is Number) && !(param3 is Boolean) && !(param3 is Array))
            {
               for(_loc4_ in param3)
               {
                  _loc5_ = this.cutChanges(param1[param2],_loc4_,param3[_loc4_]);
                  if(_loc5_)
                  {
                     _loc6_ = 0;
                     for(_loc7_ in param1[param2])
                     {
                        _loc6_++;
                     }
                     if(_loc6_ == 0)
                     {
                        delete param1[param2];
                        return true;
                     }
                  }
               }
               return false;
            }
            this._len--;
            delete param1[param2];
            return true;
         }
         return false;
      }
      
      public function get length() : uint {
         return this._len;
      }
      
      public function getChanges() : Object {
         return this._data;
      }
      
      public function debug() : void {
         var _loc1_:String = null;
         var _loc2_:String = null;
         for(_loc1_ in this._data)
         {
            for(_loc2_ in this._data[_loc1_])
            {
            }
         }
      }
   }
}
