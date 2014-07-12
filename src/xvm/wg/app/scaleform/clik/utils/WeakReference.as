package scaleform.clik.utils
{
   import flash.utils.Dictionary;
   
   public class WeakReference extends Object
   {
      
      public function WeakReference(param1:Object) {
         super();
         this._dictionary = new Dictionary(true);
         this._dictionary[param1] = 1;
      }
      
      protected var _dictionary:Dictionary;
      
      public function get value() : Object {
         var _loc1_:Object = null;
         for(_loc1_ in this._dictionary)
         {
            return _loc1_;
         }
         return null;
      }
   }
}
