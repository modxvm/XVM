package net.wg.gui.lobby.questsWindow.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class RequirementBlockVO extends DAAPIDataClass
   {
      
      public function RequirementBlockVO(param1:Object) {
         this._containerElements = [];
         this._topConditions = [];
         super(param1);
      }
      
      private var _title:String = "";
      
      private var _description:String = "";
      
      private var _containerElements:Array;
      
      private var _topConditions:Array;
      
      public function get title() : String {
         return this._title;
      }
      
      public function set title(param1:String) : void {
         this._title = param1;
      }
      
      public function get containerElements() : Array {
         return this._containerElements;
      }
      
      public function set containerElements(param1:Array) : void {
         this._containerElements = param1;
      }
      
      public function get description() : String {
         return this._description;
      }
      
      public function set description(param1:String) : void {
         this._description = param1;
      }
      
      public function get topConditions() : Array {
         return this._topConditions;
      }
      
      public function set topConditions(param1:Array) : void {
         this._topConditions = param1;
      }
   }
}
