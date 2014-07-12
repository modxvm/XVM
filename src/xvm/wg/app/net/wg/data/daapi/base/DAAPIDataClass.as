package net.wg.data.daapi.base
{
   import flash.events.EventDispatcher;
   import net.wg.infrastructure.interfaces.IDAAPIDataClass;
   import net.wg.utils.IAssertable;
   import net.wg.data.constants.Errors;
   import net.wg.infrastructure.exceptions.DAAPIBindException;
   import avmplus.getQualifiedClassName;
   
   public class DAAPIDataClass extends EventDispatcher implements IDAAPIDataClass
   {
      
      public function DAAPIDataClass(param1:Object) {
         super();
         this.fromHash(param1);
      }
      
      public static function compare(param1:Object, param2:Object) : Boolean {
         var _loc4_:Array = null;
         var _loc5_:uint = 0;
         var _loc6_:* = 0;
         var _loc7_:Object = null;
         var _loc3_:* = typeof param1;
         if(_loc3_ == "object")
         {
            if(param1 is Array)
            {
               _loc4_ = param1 as Array;
               if(param2 is Array)
               {
                  _loc5_ = _loc4_.length;
                  if(_loc5_ == param2.length)
                  {
                     _loc6_ = 0;
                     while(_loc6_ < _loc5_)
                     {
                        if(!compare(_loc4_[_loc6_],param2[_loc6_]))
                        {
                           return false;
                        }
                        _loc6_++;
                     }
                  }
                  else
                  {
                     return false;
                  }
               }
               else
               {
                  return false;
               }
            }
            else
            {
               for(_loc7_ in param1)
               {
                  if(param2.hasOwnProperty(_loc7_.toString()))
                  {
                     if(!compare(param1[_loc7_],param2[_loc7_]))
                     {
                        return false;
                     }
                     continue;
                  }
                  return false;
               }
            }
         }
         else if(param1 !== param2)
         {
            return false;
         }
         
         return true;
      }
      
      private var _hash:Object = null;
      
      public function fromHash(param1:Object) : void {
         var _loc4_:String = null;
         var _loc5_:* = undefined;
         var _loc6_:String = null;
         var _loc7_:String = null;
         var _loc8_:String = null;
         var _loc9_:String = null;
         var _loc2_:IAssertable = App.utils.asserter;
         _loc2_.assertNotNull(param1,"Hash" + Errors.CANT_NULL);
         this._hash = param1;
         var _loc3_:* = "can\'t find property for DAAPI data binding: ";
         for(_loc4_ in param1)
         {
            _loc5_ = param1[_loc4_];
            _loc6_ = _loc4_;
            if(this.onDataWrite(_loc6_,_loc5_))
            {
               _loc2_.assert(hasOwnProperty(_loc6_),_loc3_ + _loc6_,DAAPIBindException);
               if(_loc5_ != undefined)
               {
                  _loc7_ = typeof this[_loc4_];
                  _loc8_ = typeof _loc5_;
                  if(_loc7_ != "object")
                  {
                     _loc9_ = "invalid type on property \'" + getQualifiedClassName(this) + "." + _loc4_ + "\': can`t cast value \'" + _loc5_ + "\' with type \'" + _loc8_ + "\'to \'" + _loc7_ + "\'";
                     _loc2_.assert(_loc7_ == _loc8_,_loc9_,DAAPIBindException);
                  }
                  else
                  {
                     _loc2_.assert(_loc8_ == "object","incorrect cast value \'" + _loc5_ + "\' to field with type Object." + " Please, change type of \'" + getQualifiedClassName(this) + "." + _loc4_ + "\' field  to \'" + _loc8_ + "\' type or initialize it as Values.EMPTY_STR",DAAPIBindException);
                  }
               }
               this[_loc4_] = _loc5_;
            }
         }
      }
      
      public final function dispose() : void {
         var _loc1_:String = null;
         var _loc2_:* = undefined;
         var _loc3_:String = null;
         this.onDispose();
         for(_loc1_ in this._hash)
         {
            _loc2_ = this._hash[_loc1_];
            _loc3_ = _loc1_;
            delete this[_loc1_];
         }
         this._hash = null;
      }
      
      protected function onDispose() : void {
      }
      
      public function toHash() : Object {
         var _loc2_:String = null;
         var _loc3_:Object = null;
         var _loc4_:String = null;
         var _loc1_:Object = {};
         for(_loc2_ in this._hash)
         {
            _loc3_ = this._hash[_loc2_];
            _loc4_ = _loc2_.substr(0);
            if(this.onDataRead(_loc2_,_loc1_))
            {
               _loc1_[_loc4_] = _loc3_;
            }
         }
         return _loc1_;
      }
      
      protected function onDataWrite(param1:String, param2:Object) : Boolean {
         return true;
      }
      
      protected function onDataRead(param1:String, param2:Object) : Boolean {
         return true;
      }
      
      public function getHash() : Object {
         return this._hash;
      }
      
      public function isEquals(param1:DAAPIDataClass) : Boolean {
         return compare(this._hash,param1.getHash());
      }
   }
}
