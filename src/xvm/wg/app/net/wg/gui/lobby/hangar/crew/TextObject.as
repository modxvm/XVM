package net.wg.gui.lobby.hangar.crew
{
   public class TextObject extends Object
   {
      
      public function TextObject() {
         super();
      }
      
      private var _levelSpecializationMainHtml:String = null;
      
      private var _nameTF:String = null;
      
      private var _rank:String = null;
      
      private var _roleHtml:String = null;
      
      public function get roleHtml() : String {
         return this._roleHtml;
      }
      
      public function set roleHtml(param1:String) : void {
         this._roleHtml = param1;
      }
      
      public function get rank() : String {
         return this._rank;
      }
      
      public function set rank(param1:String) : void {
         this._rank = param1;
      }
      
      public function get nameTF() : String {
         return this._nameTF;
      }
      
      public function set nameTF(param1:String) : void {
         this._nameTF = param1;
      }
      
      public function get levelSpecializationMainHtml() : String {
         return this._levelSpecializationMainHtml;
      }
      
      public function set levelSpecializationMainHtml(param1:String) : void {
         this._levelSpecializationMainHtml = param1;
      }
   }
}
