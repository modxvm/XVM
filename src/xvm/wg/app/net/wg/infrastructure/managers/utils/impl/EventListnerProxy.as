package net.wg.infrastructure.managers.utils.impl
{


   public class EventListnerProxy extends Object
   {
          
      public function EventListnerProxy(param1:Object, param2:String, param3:Function, param4:Boolean) {
         super();
         this.objRef = param1;
         this.eventRef = param2;
         this.funcRef = param3;
         this._useCapture = param4;
      }

      private var objRef:Object;

      private var eventRef:String;

      private var funcRef:Function;

      private var _useCapture:Boolean;

      public function finalize() : void {
         this.objRef = null;
         this.eventRef = null;
         this.funcRef = null;
      }

      public function get obj() : Object {
         return this.objRef;
      }

      public function get event() : String {
         return this.eventRef;
      }

      public function get func() : Function {
         return this.funcRef;
      }

      public function get useCapture() : Boolean {
         return this._useCapture;
      }

      public function set useCapture(param1:Boolean) : void {
         this._useCapture = param1;
      }
   }

}