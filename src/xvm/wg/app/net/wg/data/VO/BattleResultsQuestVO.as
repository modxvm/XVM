package net.wg.data.VO
{
   import net.wg.gui.lobby.questsWindow.data.SubtaskVO;


   public class BattleResultsQuestVO extends SubtaskVO
   {
          
      public function BattleResultsQuestVO(param1:Object) {
         this._progressList = [];
         super(param1);
      }

      private var _awards:String = "";

      private var _progressList:Array;

      private var _alertMsg:String = "";

      public function get awards() : String {
         return this._awards;
      }

      public function set awards(param1:String) : void {
         this._awards = param1;
      }

      public function get progressList() : Array {
         return this._progressList;
      }

      public function set progressList(param1:Array) : void {
         this._progressList = param1;
      }

      public function get alertMsg() : String {
         return this._alertMsg;
      }

      public function set alertMsg(param1:String) : void {
         this._alertMsg = param1;
      }
   }

}