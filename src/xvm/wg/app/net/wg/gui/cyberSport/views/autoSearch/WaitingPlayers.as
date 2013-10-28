package net.wg.gui.cyberSport.views.autoSearch
{
   import net.wg.gui.components.advanced.FieldSet;
   import flash.display.MovieClip;
   import scaleform.clik.events.ButtonEvent;
   import net.wg.data.constants.generated.CYBER_SPORT_ALIASES;


   public class WaitingPlayers extends StateViewBase
   {
          
      public function WaitingPlayers() {
         super();
         currentState = CYBER_SPORT_ALIASES.AUTO_SEARCH_WAITING_PLAYERS_STATE;
         mainField.text = CYBERSPORT.WINDOW_AUTOSEARCH_WAITINGPLAYERS_MAINTEXT;
         cancelButton.label = CYBERSPORT.WINDOW_AUTOSEARCH_SEARCHCOMMAND_CANCELLBL;
         this.fieldSet.mouseEnabled = false;
         this.players = [this.player1,this.player2,this.player3,this.player4,this.player5,this.player6,this.player7];
         this.buttonsBG.visible = false;
         cancelButton.visible = false;
      }

      public var fieldSet:FieldSet;

      public var buttonsBG:MovieClip;

      public var player1:MovieClip = null;

      public var player2:MovieClip = null;

      public var player3:MovieClip = null;

      public var player4:MovieClip = null;

      public var player5:MovieClip = null;

      public var player6:MovieClip = null;

      public var player7:MovieClip = null;

      private var players:Array = null;

      override protected function updateView() : void {
         super.updateView();
         if(model.canInvokeAutoSearch)
         {
            this.buttonsBG.visible = true;
            cancelButton.visible = true;
         }
         updateTime();
         startTimer();
         this.initPlayersState(model.playersReadiness);
      }

      private function initPlayersState(param1:Array) : void {
         var _loc4_:String = null;
         var _loc2_:uint = param1.length;
         var _loc3_:* = 0;
         while(_loc3_ < _loc2_)
         {
            if(param1[_loc3_] == null)
            {
               this.players[_loc3_].gotoAndStop("locked");
            }
            else
            {
               _loc4_ = param1[_loc3_] == true?"ready":"normal";
               this.players[_loc3_].gotoAndStop(_loc4_);
            }
            _loc3_++;
         }
      }

      override protected function onTimer() : void {
         super.onTimer();
         updateTime();
         startTimer();
      }

      override public function dispose() : void {
         this.fieldSet.dispose();
         if(this.players)
         {
            this.players.splice(0,this.players.length);
            this.players = null;
         }
         super.dispose();
      }

      override protected function cancelButtonOnClick(param1:ButtonEvent) : void {
         super.cancelButtonOnClick(param1);
         cancelButton.enabled = false;
      }
   }

}