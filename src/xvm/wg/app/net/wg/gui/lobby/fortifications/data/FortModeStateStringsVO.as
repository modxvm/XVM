package net.wg.gui.lobby.fortifications.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class FortModeStateStringsVO extends DAAPIDataClass
   {
      
      public function FortModeStateStringsVO(param1:Object) {
         super(param1);
      }
      
      private var _descrText:String = "";
      
      private var _headerTitle:String = "";
      
      public function get descrText() : String {
         return this._descrText;
      }
      
      public function set descrText(param1:String) : void {
         this._descrText = param1;
      }
      
      public function get headerTitle() : String {
         return this._headerTitle;
      }
      
      public function set headerTitle(param1:String) : void {
         this._headerTitle = param1;
      }
   }
}
