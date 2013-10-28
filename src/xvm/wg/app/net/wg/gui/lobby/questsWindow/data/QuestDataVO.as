package net.wg.gui.lobby.questsWindow.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;


   public class QuestDataVO extends DAAPIDataClass
   {
          
      public function QuestDataVO(param1:Object) {
         this._nextTasks = [];
         super(param1);
      }

      private var _header:HeaderDataVO = null;

      private var _info:InfoDataVO = null;

      private var _award:String = "";

      private var _nextTasks:Array;

      override protected function onDataWrite(param1:String, param2:Object) : Boolean {
         switch(param1)
         {
            case "header":
               this._header = param2?new HeaderDataVO(param2):null;
               return false;
            case "info":
               this._info = param2?new InfoDataVO(param2):null;
               return false;
            default:
               return true;
         }
      }

      public function get header() : HeaderDataVO {
         return this._header;
      }

      public function set header(param1:HeaderDataVO) : void {
         this._header = param1;
      }

      public function get info() : InfoDataVO {
         return this._info;
      }

      public function set info(param1:InfoDataVO) : void {
         this._info = param1;
      }

      public function get award() : String {
         return this._award;
      }

      public function set award(param1:String) : void {
         this._award = param1;
      }

      public function get nextTasks() : Array {
         return this._nextTasks;
      }

      public function set nextTasks(param1:Array) : void {
         this._nextTasks = param1;
      }
   }

}