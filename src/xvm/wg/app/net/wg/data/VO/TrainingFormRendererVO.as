package net.wg.data.VO
{
   import net.wg.data.daapi.base.DAAPIDataClass;


   public class TrainingFormRendererVO extends DAAPIDataClass
   {
          
      public function TrainingFormRendererVO(param1:Object) {
         super(param1);
      }

      private var _comment:String = "";

      private var _arena:String = "";

      private var _count:Number = 0;

      private var _total:Number = 0;

      private var _owner:String = "";

      private var _icon:String = "";

      private var _disabled:Boolean;

      private var _id:Number = 0;

      public function get id() : Number {
         return this._id;
      }

      public function set id(param1:Number) : void {
         this._id = param1;
      }

      public function get disabled() : Boolean {
         return this._disabled;
      }

      public function set disabled(param1:Boolean) : void {
         this._disabled = param1;
      }

      public function get icon() : String {
         return this._icon;
      }

      public function set icon(param1:String) : void {
         this._icon = param1;
      }

      public function get owner() : String {
         return this._owner;
      }

      public function set owner(param1:String) : void {
         this._owner = param1;
      }

      public function get total() : Number {
         return this._total;
      }

      public function set total(param1:Number) : void {
         this._total = param1;
      }

      public function get count() : Number {
         return this._count;
      }

      public function set count(param1:Number) : void {
         this._count = param1;
      }

      public function get arena() : String {
         return this._arena;
      }

      public function set arena(param1:String) : void {
         this._arena = param1;
      }

      public function get comment() : String {
         return this._comment;
      }

      public function set comment(param1:String) : void {
         this._comment = param1;
      }
   }

}