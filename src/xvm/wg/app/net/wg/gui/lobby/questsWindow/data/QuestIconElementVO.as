package net.wg.gui.lobby.questsWindow.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;


   public class QuestIconElementVO extends DAAPIDataClass
   {
          
      public function QuestIconElementVO(param1:Object) {
         super(param1);
      }

      private var _label:String = "";

      private var _icon:String = "";

      private var _linkage:String = "QuestIconElement_UI";

      private var _dataType:String = "";

      private var _dataValue:String = "";

      public function get label() : String {
         return this._label;
      }

      public function set label(param1:String) : void {
         this._label = param1;
      }

      public function get icon() : String {
         return this._icon;
      }

      public function set icon(param1:String) : void {
         this._icon = param1;
      }

      public function get linkage() : String {
         return this._linkage;
      }

      public function set linkage(param1:String) : void {
         this._linkage = param1;
      }

      public function get dataValue() : String {
         return this._dataValue;
      }

      public function set dataValue(param1:String) : void {
         this._dataValue = param1;
      }

      public function get dataType() : String {
         return this._dataType;
      }

      public function set dataType(param1:String) : void {
         this._dataType = param1;
      }
   }

}