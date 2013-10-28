package net.wg.data.VO
{
   import net.wg.data.daapi.base.DAAPIDataClass;


   public class TrainingWindowVO extends DAAPIDataClass
   {
          
      public function TrainingWindowVO(param1:Object) {
         super(param1);
      }

      private var _description:String = "";

      private var _timeout:Number;

      private var _arena:Number;

      private var _privacy:Boolean;

      private var _create:Boolean;

      public function get create() : Boolean {
         return this._create;
      }

      public function set create(param1:Boolean) : void {
         this._create = param1;
      }

      public function get privacy() : Boolean {
         return this._privacy;
      }

      public function set privacy(param1:Boolean) : void {
         this._privacy = param1;
      }

      public function get arena() : Number {
         return this._arena;
      }

      public function set arena(param1:Number) : void {
         this._arena = param1;
      }

      public function get timeout() : Number {
         return this._timeout;
      }

      public function set timeout(param1:Number) : void {
         this._timeout = param1;
      }

      public function get description() : String {
         return this._description;
      }

      public function set description(param1:String) : void {
         this._description = param1;
      }
   }

}