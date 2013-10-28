package net.wg.gui.components.common.ticker
{
   import net.wg.data.daapi.base.DAAPIDataClass;


   public class RSSEntryVO extends DAAPIDataClass
   {
          
      public function RSSEntryVO(param1:Object) {
         super(param1);
      }

      private var _id:String = "";

      private var _title:String = "";

      private var _summary:String = "";

      public function get id() : String {
         return this._id;
      }

      public function set id(param1:String) : void {
         this._id = param1;
      }

      public function get title() : String {
         return this._title;
      }

      public function set title(param1:String) : void {
         this._title = param1;
      }

      public function get summary() : String {
         return this._summary;
      }

      public function set summary(param1:String) : void {
         this._summary = param1;
      }
   }

}