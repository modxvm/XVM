package net.wg.gui.lobby.hangar.crew
{
   import net.wg.data.daapi.base.DAAPIDataClass;


   public class SkillsVO extends DAAPIDataClass
   {
          
      public function SkillsVO(param1:Object) {
         super(param1);
      }

      private var _icon:String = "";

      private var _inprogress:Boolean;

      private var _name:String = "";

      private var _desc:String = "";

      private var _active:Boolean;

      private var _selected:Boolean;

      private var _tankmanID:Number;

      private var _buy:Boolean;

      private var _level:Number;

      private var _id:String = "";

      public function get icon() : String {
         return this._icon;
      }

      public function set icon(param1:String) : void {
         this._icon = param1;
      }

      public function get name() : String {
         return this._name;
      }

      public function set name(param1:String) : void {
         this._name = param1;
      }

      public function get active() : Boolean {
         return this._active;
      }

      public function set active(param1:Boolean) : void {
         this._active = param1;
      }

      public function get selected() : Boolean {
         return this._selected;
      }

      public function set selected(param1:Boolean) : void {
         this._selected = param1;
      }

      public function get tankmanID() : Number {
         return this._tankmanID;
      }

      public function set tankmanID(param1:Number) : void {
         this._tankmanID = param1;
      }

      public function get buy() : Boolean {
         return this._buy;
      }

      public function set buy(param1:Boolean) : void {
         this._buy = param1;
      }

      public function get inprogress() : Boolean {
         return this._inprogress;
      }

      public function set inprogress(param1:Boolean) : void {
         this._inprogress = param1;
      }

      public function get desc() : String {
         return this._desc;
      }

      public function set desc(param1:String) : void {
         this._desc = param1;
      }

      public function get level() : Number {
         return this._level;
      }

      public function set level(param1:Number) : void {
         this._level = param1;
      }

      public function get id() : String {
         return this._id;
      }

      public function set id(param1:String) : void {
         this._id = param1;
      }
   }

}