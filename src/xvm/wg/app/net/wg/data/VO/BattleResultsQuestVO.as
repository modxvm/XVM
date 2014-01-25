package net.wg.data.VO
{
   import net.wg.gui.lobby.questsWindow.data.SubtaskVO;
   import net.wg.gui.lobby.questsWindow.data.AwardsVO;
   import net.wg.gui.lobby.questsWindow.data.QuestRendererVO;


   public class BattleResultsQuestVO extends SubtaskVO
   {
          
      public function BattleResultsQuestVO(param1:Object) {
         this._progressList = [];
         super(param1);
      }

      private var _awards:AwardsVO = null;

      private var _progressList:Array;

      private var _alertMsg:String = "";

      override protected function onDataWrite(param1:String, param2:Object) : Boolean {
         switch(param1)
         {
            case "questInfo":
               questInfo = new QuestRendererVO(param2?param2:{});
               return false;
            case "awards":
               this._awards = param2?new AwardsVO(param2):null;
               return false;
            default:
               return true;
         }
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

      public function get awards() : AwardsVO {
         return this._awards;
      }

      public function set awards(param1:AwardsVO) : void {
         this._awards = param1;
      }
   }

}