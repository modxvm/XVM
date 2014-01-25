package net.wg.gui.lobby.questsWindow.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;


   public class AwardsVO extends DAAPIDataClass
   {
          
      public function AwardsVO(param1:Object) {
         this._openedQuests = [];
         super(param1);
      }

      private var _awardsStr:String = "";

      private var _openedQuests:Array;

      public function get awardsStr() : String {
         return this._awardsStr;
      }

      public function set awardsStr(param1:String) : void {
         this._awardsStr = param1;
      }

      public function get openedQuests() : Array {
         return this._openedQuests;
      }

      public function set openedQuests(param1:Array) : void {
         this._openedQuests = param1;
      }
   }

}